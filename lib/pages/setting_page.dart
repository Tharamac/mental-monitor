import 'dart:io';

import 'package:duration/duration.dart';
import 'package:duration/locale.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mental_monitor/api/notification_api.dart';
import 'package:mental_monitor/blocs/user/user_bloc.dart';
import 'package:mental_monitor/constant/palette.dart';
import 'package:mental_monitor/file_manager.dart';
import 'package:mental_monitor/model/daily_record.dart';
import 'package:mental_monitor/util.dart';

class SettingPage extends StatelessWidget {
  SettingPage({Key? key}) : super(key: key);
  final emailController = TextEditingController();

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
      body: BlocBuilder<UserSessionBloc, UserSessionState>(
        builder: (context, state) {
          final currentNotifiedTime = state.notifiedTime ??
              DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day, 19, 0, 0);
          return Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "การแจ้งเตือนการบันทึก",
                  style: GoogleFonts.ibmPlexSansThai(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                        "แอพจะแจ้งเตือนเวลา ${DateFormat.Hm().format(currentNotifiedTime)} ของทุกวัน"),
                    TextButton(
                      onPressed: () async {
                        final TimeOfDay? newTime = await showTimePicker(
                          context: context,
                          initialTime:
                              TimeOfDay.fromDateTime(currentNotifiedTime),
                          initialEntryMode: TimePickerEntryMode.input,
                          confirmText: "ตกลง",
                          cancelText: "ยกเลิก",
                          helpText: "",
                          // hourLabelText: "",
                          // minuteLabelText: ""
                        );
                        if (newTime != null) {
                          context
                              .read<UserSessionBloc>()
                              .add(UpdateNotifiedTime(newTime));
                          LocalNoticeService().cancelNotification(0);
                          LocalNoticeService().showDailyNotificationAtTime(0,
                              "วันนี้เป็นอย่างไรบ้าง", "บันทึกเรื่องราววันนี้ได้เลย", "notify memo", newTime);
                        }
                      },
                      child: Text("เปลี่ยนเวลา"),
                    )
                  ],
                ),
                Divider(),
                Text(
                  "สำรองข้อมูล",
                  style: GoogleFonts.ibmPlexSansThai(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextButton(
                    onPressed: (() {}), child: Text("สำรองข้อมูลตอนนี้")),
                Divider(),
                Text(
                  "ส่งข้อมูลไปที่อีเมล์",
                  style: GoogleFonts.ibmPlexSansThai(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: TextFormField(
                        // readOnly: true,
                        controller: emailController,
                        maxLines: 1,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          // contentPadding: EdgeInsets.all(8),
                          label: Text("อีเมล์แอดเดรส"),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2,
                                color: Colors.blueGrey), //<-- SEE HERE
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2,
                                color: Colors.blueGrey), //<-- SEE HERE
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () async {
                          final records =
                              context.read<UserSessionBloc>().state.records;

                          var excel = Excel.createExcel();
                          Sheet recordSheet = excel['records'];

                          CellStyle fieldCellStyle = CellStyle(
                              backgroundColorHex: "#c3c9c3",
                              fontFamily:
                                  GoogleFonts.ibmPlexSansThai().fontFamily);
                          CellStyle normalCellStyle = CellStyle(
                              fontFamily:
                                  GoogleFonts.ibmPlexSansThai().fontFamily);
                          for (int ind = 1;
                              ind <= DailyRecord.getFieldName.length;
                              ind++) {
                            var cell = recordSheet
                                .cell(CellIndex.indexByString('A$ind'));
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
                                    columnIndex: ind, rowIndex: 0))
                                .cellStyle = normalCellStyle;
                            // dateCell.value = formatDateInThai(recordPos.recordDate);
                            recordSheet
                                .cell(CellIndex.indexByColumnRow(
                                    columnIndex: ind, rowIndex: 1))
                                .cellStyle = normalCellStyle;
                            recordSheet
                                .cell(CellIndex.indexByColumnRow(
                                    columnIndex: ind, rowIndex: 2))
                                .cellStyle = CellStyle(
                              backgroundColorHex:
                                  '#${moodSliderPalette2[recordPos.moodLevel - 1]!.value.toRadixString(16).substring(2, 8)}',
                              fontFamily:
                                  GoogleFonts.ibmPlexSansThai().fontFamily,
                            );
                            recordSheet
                                .cell(CellIndex.indexByColumnRow(
                                    columnIndex: ind, rowIndex: 3))
                                .cellStyle = normalCellStyle;
                            recordSheet
                                .cell(CellIndex.indexByColumnRow(
                                    columnIndex: ind, rowIndex: 4))
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
                            recipients: [emailController.text],
                            attachmentPaths: [
                              await FileManager(fileName: "out", format: "xlsx")
                                  .localFile
                                  .then((value) => value.path)
                            ],
                            isHTML: false,
                          );

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
                        child: Text("ส่ง"))
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
