import 'dart:io';

import 'package:export_strat/email_service.dart';
import 'package:export_strat/model/database.dart';
import 'package:export_strat/model/test_dao.dart';
import 'package:export_strat/sqlite.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  TextEditingController nameEntryController = TextEditingController();
  TextEditingController ageEntryController = TextEditingController();
  late AppDatabase database;
  late TestDao testDao;

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    final db = await Sqlite().openDatabase();
    setState(() {
      database = db;
      testDao = TestDao(database);
    });
  }

  String? filePath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Information"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            TextFormField(
              controller: nameEntryController,
              decoration: const InputDecoration(disabledBorder: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: ageEntryController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(disabledBorder: OutlineInputBorder()),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                final person = Test(
                  name: nameEntryController.text,
                  age: int.parse(ageEntryController.text),
                );
                await testDao.insertTest(person);
              },
              child: const Text("Save my Data"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final allTests = await testDao.getAllTests();
                if (allTests.isNotEmpty) {
                  debugPrint("db length: ${allTests.length}");
                  for (var item in allTests) {
                    debugPrint(item.toJson().toString());
                  }
                }
              },
              child: const Text("Get my Data"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                filePath = await Sqlite().exportToCsv(database);
                debugPrint("Exported CSV path: $filePath");
              },
              child: const Text("Export data"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (filePath == null) {
                  filePath = await Sqlite().exportToCsv(database);
                  debugPrint("Exported CSV path: $filePath");
                }
                final emailService = EmailService(
                  senderName: "University of Michigan",
                  senderEmail: 'tsrnb.25@gmail.com',
                  appPassword: 'itnr cgor yobi cscz',
                );

                try {
                  final attachment = FileAttachment(File(filePath!));
                  await emailService.sendEmail(
                    recipientEmail: 'nithin.bharadwaj@symphonize.com',
                    subject: 'Dimlight Study report',
                    body: "Please find the attachment",
                    isHtml: false,
                    ccRecipients: ['tsrnb.53@gmail.com'],
                    bccRecipients: ['fudiciousofficial@gmail.com'],
                    attachments: [attachment],
                  );
                  // await emailService.sendTemplatedEmail(
                  //   recipientEmail: 'tsrnb.53@gmail.com',
                  //   subject: 'Study Report',
                  //   template: EmailTemplate.studyReport,
                  //   templateVariables: {
                  //     'participant_name': 'John Doe',
                  //     'contact_email': 'research@umich.edu',
                  //     'researcher_name': 'Dr. Jane Smith',
                  //     'current_year': DateTime.now().year.toString()
                  //   },
                  //   attachments: [attachment],
                  // );
                } catch (e) {
                  debugPrint('Error occurred: $e');
                }
              },
              child: const Text("Email CSV"),
            ),
          ],
        ),
      ),
    );
  }
}
