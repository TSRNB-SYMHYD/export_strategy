import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

enum EmailTemplate {
  welcome,
  studyReport,
}

class EmailService {
  final Address _sender;
  late SmtpServer _smtpServer;

  EmailService({required String senderName, required String senderEmail, required String appPassword})
      : assert(
            senderName.isNotEmpty && senderEmail.isNotEmpty && appPassword.isNotEmpty && _validateEmail(senderEmail)),
        _sender = Address(senderEmail, senderName) {
    _smtpServer = gmail(senderEmail, appPassword);
  }

  Future<SendReport> sendEmail({
    required String recipientEmail,
    required String subject,
    required String body,
    List<String>? ccRecipients,
    List<String>? bccRecipients,
    List<Attachment>? attachments,
    bool isHtml = false,
  }) async {
    assert(recipientEmail.isNotEmpty && _validateEmail(recipientEmail) && subject.isNotEmpty && body.isNotEmpty);
    assert(ccRecipients?.every(_validateEmail) ?? true);
    assert(bccRecipients?.every(_validateEmail) ?? true);

    final message = _createMessage(
      recipientEmail: recipientEmail,
      subject: subject,
      body: body,
      ccRecipients: ccRecipients,
      bccRecipients: bccRecipients,
      attachments: attachments,
      isHtml: isHtml,
    );

    return _sendMessage(message);
  }

  Future<SendReport> sendTemplatedEmail({
    required String recipientEmail,
    required String subject,
    required EmailTemplate template,
    required Map<String, String> templateVariables,
    List<String>? ccRecipients,
    List<String>? bccRecipients,
    List<Attachment>? attachments,
  }) async {
    String htmlContent = await _loadTemplate(template);
    String body = _applyTemplateVariables(htmlContent, templateVariables);

    return sendEmail(
      recipientEmail: recipientEmail,
      subject: subject,
      body: body,
      ccRecipients: ccRecipients,
      bccRecipients: bccRecipients,
      attachments: attachments,
      isHtml: true,
    );
  }

  Future<List<SendReport>> sendBulkEmails({
    required List<String> recipientEmails,
    required String subject,
    required String body,
    bool isHtml = false,
  }) async {
    assert(recipientEmails.isNotEmpty && recipientEmails.every(_validateEmail));

    return Future.wait(recipientEmails.map((email) => sendEmail(
          recipientEmail: email,
          subject: subject,
          body: body,
          isHtml: isHtml,
        ).catchError((e) {
          debugPrint('Failed to send email to $email: $e');
          return SendReport(Message(), DateTime.now(), DateTime.now(), DateTime.now());
        })));
  }

  Message _createMessage({
    required String recipientEmail,
    required String subject,
    required String body,
    List<String>? ccRecipients,
    List<String>? bccRecipients,
    List<Attachment>? attachments,
    bool isHtml = false,
  }) {
    final message = Message()
      ..from = _sender
      ..recipients.add(recipientEmail)
      ..subject = subject
      ..ccRecipients.addAll(ccRecipients ?? [])
      ..bccRecipients.addAll(bccRecipients ?? [])
      ..attachments.addAll(attachments ?? []);

    isHtml ? message.html = body : message.text = body;
    return message;
  }

  Future<SendReport> _sendMessage(Message message) async {
    try {
      final sendReport = await send(message, _smtpServer);
      debugPrint(sendReport.toString());
      return sendReport;
    } on MailerException catch (e) {
      debugPrint('Message not sent. error: $e');
      rethrow;
    }
  }

  Future<String> _loadTemplate(EmailTemplate template) async {
    String assetPath;
    switch (template) {
      case EmailTemplate.welcome:
        assetPath = 'assets/templates/welcome.html';
        break;

      case EmailTemplate.studyReport:
        assetPath = 'assets/templates/study_report.html';
        break;
    }
    try {
      return await rootBundle.loadString(assetPath);
    } catch (e) {
      throw Exception('Failed to load email template: $assetPath. Error: $e');
    }
  }

  String _applyTemplateVariables(String template, Map<String, String> variables) {
    variables.forEach((key, value) {
      template = template.replaceAll('{{$key}}', value);
    });
    return template;
  }

  static bool _validateEmail(String email) => RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
}
