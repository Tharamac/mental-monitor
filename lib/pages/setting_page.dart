import 'dart:io';
// import 'dart:io' show Platform;

import 'dart:math';

import 'package:duration/duration.dart';
import 'package:duration/locale.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mental_monitor/api/notification_api.dart';
import 'package:mental_monitor/blocs/notified_time/notified_state.dart';
import 'package:mental_monitor/blocs/notified_time/notified_time_cubit.dart';
import 'package:mental_monitor/blocs/user/user_bloc.dart';
import 'package:mental_monitor/constant/constant.dart';
import 'package:mental_monitor/constant/palette.dart';
import 'package:mental_monitor/file_manager.dart';
import 'package:mental_monitor/model/daily_record.dart';
import 'package:mental_monitor/util.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:random_string/random_string.dart';

class SettingPage extends StatelessWidget {
  SettingPage({Key? key}) : super(key: key);
  // final emailController = TextEditingController();
  final rand = Random.secure();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text("การตั้งค่า",
              style: GoogleFonts.ibmPlexSansThai(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ))),
      body: BlocBuilder<NotfiedTimeCubit, NotifiedTimeState>(
        builder: (context, state) {
          final currentNotifiedTime = state.notifiedTime;
          return Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "การแจ้งเตือนการบันทึก",
                  style: GoogleFonts.ibmPlexSansThai(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                // SizedBox(
                //   height: 12,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "แอพจะแจ้งเตือนเวลา ${MaterialLocalizations.of(context).formatTimeOfDay(currentNotifiedTime, alwaysUse24HourFormat: true)} น. ของทุกวัน",
                      style: GoogleFonts.ibmPlexSansThai(
                          fontSize: 15, fontWeight: FontWeight.normal),
                    ),
                    TextButton(
                      onPressed: () async {
                        final TimeOfDay? newTime = await showTimePicker(
                          context: context,
                          initialTime: currentNotifiedTime,
                          initialEntryMode: TimePickerEntryMode.input,
                          confirmText: "ตกลง",
                          cancelText: "ยกเลิก",
                          helpText: "",
                          // hourLabelText: "",
                          // minuteLabelText: ""
                        );
                        if (newTime != null) {
                          context
                              .read<NotfiedTimeCubit>()
                              .updateNotifiedTimeSetting(newTime);
                        }
                      },
                      child: Text("เปลี่ยนเวลา",
                          style: GoogleFonts.ibmPlexSansThai(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                    )
                  ],
                ),
                Divider(),
                Text(
                  "ส่งข้อมูลไปที่อีเมล์",
                  style: GoogleFonts.ibmPlexSansThai(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                // SizedBox(
                //   height: 12,
                // ),
                Row(
                  children: [
                    TextButton(
                        onPressed: () async {
                          final state = context.read<UserSessionBloc>().state;
                          final record_exclude_today = state.records;
                          final today = state.todayRecord;
                          final records = (today != null)
                              ? [today, ...record_exclude_today]
                              : record_exclude_today;

                          var excel = Excel.createExcel();

                          Sheet recordSheet = excel['records'];
                          excel.delete('Sheet1');

                          CellStyle fieldCellStyle = CellStyle(
                              backgroundColorHex: "#c3c9c3",
                              fontFamily:
                                  GoogleFonts.ibmPlexSansThai().fontFamily,
                              bold: true);
                          CellStyle normalCellStyle = CellStyle(
                              fontFamily:
                                  GoogleFonts.ibmPlexSansThai().fontFamily);
                          for (int ind = 1;
                              ind <= DailyRecord.getFieldName.length;
                              ind++) {
                            var cell = recordSheet.cell(CellIndex.indexByString(
                                '${String.fromCharCode(64 + ind)}1'));
                            cell.cellStyle = fieldCellStyle;
                            cell.value = DailyRecord.getFieldName[ind - 1];
                          }
                          for (int ind = 1; ind <= records.length; ind++) {
                            var recordPos = records[ind - 1];

                            recordSheet.appendRow([
                              formatDateInThai(recordPos.recordDate),
                              DateFormat.Hm().format(recordPos.recordDate),
                              recordPos.moodLevel,
                              recordPos.howWasYourDay,
                              prettyDuration(recordPos.sleepTime,
                                  locale:
                                      DurationLocale.fromLanguageCode('th')!)
                            ]);

                            recordSheet
                                .cell(CellIndex.indexByColumnRow(
                                    columnIndex: 0, rowIndex: ind))
                                .cellStyle = normalCellStyle;
                            // dateCell.value = formatDateInThai(recordPos.recordDate);
                            recordSheet
                                .cell(CellIndex.indexByColumnRow(
                                    columnIndex: 1, rowIndex: ind))
                                .cellStyle = normalCellStyle;
                            recordSheet
                                .cell(CellIndex.indexByColumnRow(
                                    columnIndex: 2, rowIndex: ind))
                                .cellStyle = CellStyle(
                              backgroundColorHex:
                                  '#${moodSliderPalette2[recordPos.moodLevel - 1]!.value.toRadixString(16).substring(2, 8)}',
                              fontFamily:
                                  GoogleFonts.ibmPlexSansThai().fontFamily,
                            );
                            recordSheet
                                .cell(CellIndex.indexByColumnRow(
                                    columnIndex: 3, rowIndex: ind))
                                .cellStyle = normalCellStyle;
                            recordSheet
                                .cell(CellIndex.indexByColumnRow(
                                    columnIndex: 4, rowIndex: ind))
                                .cellStyle = normalCellStyle;
                          }

                          FileManager(fileName: "out", format: "xlsx")
                              .localFile
                              .then((value) {
                            value
                              ..createSync(recursive: true)
                              ..writeAsBytesSync(excel.encode()!);
                          });

                          final Email email = Email(
                            body: '',
                            subject:
                                'นำส่งบันทึกของคุณ${context.read<UserSessionBloc>().state.name}',
                            // recipients: [emailController.text],
                            attachmentPaths: [
                              await FileManager(fileName: "out", format: "xlsx")
                                  .localFile
                                  .then((value) => value.path)
                            ],
                            isHTML: false,
                          );
                          // String username = 'moodtracker.theapp@yahoo.com';
                          // String password = 'f?9\$*NSCrh!P_(Z';

                          // final smtpServer = yahoo(username, password);

                          // // Create our message.
                          // final message = Message()
                          //   ..from = Address(username, 'Mood tracker')
                          //   ..recipients.add(username)
                          //   ..subject =
                          //       'นำส่งบันทึกของคุณ${context.read<UserSessionBloc>().state.name}'
                          //   ..attachments = [
                          //     FileAttachment(await FileManager(
                          //             fileName: "out", format: "xlsx")
                          //         .localFile)
                          //   ];
                          // // //                          Logger.root.level = Level.ALL;
                          // // // Logger.root.onRecord.listen((LogRecord rec) {
                          // // //   print('${rec.level.name}: ${rec.time}: ${rec.message}');
                          // // // });

                          // try {
                          //   final sendReport = await send(message, smtpServer);
                          //   print('Message sent: ' + sendReport.toString());
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     SnackBar(
                          //       content: Text("ส่งอีเมล์สำเร็จ"),
                          //     ),
                          //   );
                          // } on MailerException catch (e) {
                          //   print('Message not sent.');
                          //   print(e.message);
                          //   for (var p in e.problems) {
                          //     print('Problem: ${p.code}: ${p.msg}');
                          //   }
                          // }

                          try {
                            await FlutterEmailSender.send(email);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("ส่งอีเมล์สำเร็จ"),
                              ),
                            );
                          } catch (error) {
                            print(error);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("ส่งอีเมล์ล้มเหลว"),
                              ),
                            );
                          }

                          // String csv =
                          //     const ListToCsvConverter().convert([snapshot]);
                          // print(csv);
                        },
                        child: Text("ไปยังหน้าส่งอีเมล์",
                            style: GoogleFonts.ibmPlexSansThai(
                                fontSize: 16, fontWeight: FontWeight.w600)))
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
