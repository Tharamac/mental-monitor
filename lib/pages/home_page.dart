import 'package:cron/cron.dart';
import 'package:dartz/dartz.dart' hide State;
import 'package:duration/duration.dart';
import 'package:duration/locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mental_monitor/api/notification_api.dart';
import 'package:mental_monitor/blocs/record_form/record_form_cubit.dart';
import 'package:mental_monitor/blocs/user/user_bloc.dart';
import 'package:mental_monitor/constant/palette.dart';
import 'package:mental_monitor/pages/new_entries_page.dart';
import 'package:mental_monitor/util.dart';
import 'package:mental_monitor/widgets/line_chart_widget.dart';
import 'package:mental_monitor/widgets/menu_drawer.dart';
import 'package:mental_monitor/widgets/zoomable_chart.dart';

import '../widgets/entry_record_card.dart';

class HomePage extends StatefulWidget {
  final Either<String, Map<String, dynamic>> currentUserData;
  const HomePage({
    Key? key,
    required this.currentUserData,
  }) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final cron = Cron();
  @override
  void initState() {
    clearTodayRecord();

    widget.currentUserData.fold((newUser) {
      context.read<UserSessionBloc>().add(RegisterUserEvent(newUser));
    }, (existingUser) {
      context
          .read<UserSessionBloc>()
          .add(ImportExistingUserEvent(existingUser));
    });

    super.initState();
  }

  clearTodayRecord() {
    cron.schedule(Schedule.parse('0 0 * * *'), () async {
      context.read<UserSessionBloc>().add(ReDailyRecord());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text(
          "วันนี้คุณเป็นยังไงบ้าง",
          // style: GoogleFonts.ibmPlexSansThai(),
        ),
      ),
      drawer: const MainMenuDrawerWidget(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final latestRecords = context.read<UserSessionBloc>().state.records;
          context.read<RecordFormCubit>().loadLatestRecords(latestRecords);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (builder) => const NewMentalEntryPage()));
        },
        extendedTextStyle: GoogleFonts.ibmPlexSansThai(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        label: Text(
          'เพิ่ม/แก้ไขบันทึก',
        ),
        icon: const Icon(
          Icons.edit_calendar_outlined,
        ),
      ),

      body: BlocBuilder<UserSessionBloc, UserSessionState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "สรุประดับอารมณ์ย้อนหลัง",
                        style: GoogleFonts.ibmPlexSansThai(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      // TextButton.icon(
                      //   onPressed: () {
                      //     Navigator.of(context).push(MaterialPageRoute(
                      //         builder: (builder) =>
                      //             const NewMentalEntryPage()));
                      //   },
                      //   icon: Icon(
                      //       (state.todayRecord == null)
                      //           ? Icons.add
                      //           : Icons.edit,
                      //       color: Colors.black),
                      //   label: Text(
                      //     (state.todayRecord == null)
                      //         ? "สร้างบันทึก"
                      //         : "แก้ไข",
                      //     style: GoogleFonts.ibmPlexSansThai(
                      //         fontWeight: FontWeight.w400,
                      //         color: Colors.black),
                      //   ),
                      // ),
                      // IconButton(
                      //     onPressed: () {
                      //       Navigator.of(context).push(MaterialPageRoute(
                      //           builder: (builder) =>
                      //               const NewMentalEntryPage()));
                      //     },
                      //     icon: Icon(state.todayRecord == null
                      //         ? Icons.add
                      //         : Icons.edit)),
                    ],
                  ),
                ),

                // if(state.todayRecord )
                AspectRatio(
                    aspectRatio: 2,
                    child: ZoomableChart(
                        maxX: 7,
                        builder: (minX, maxX) {
                          return LineChartWidget(minX, maxX);
                        })),

                // Flexible(flex: 2, child: _buildTodayRecord(state)),
                // Flexible(
                //   child: SingleChildScrollView(
                //     child: Text(),
                //   ),
                // ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "บันทึกที่ผ่านมา",
                    style: GoogleFonts.ibmPlexSansThai(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                    flex: 3,
                    child: (state.records.isNotEmpty)
                        ? ListView(
                            children: state.records
                                .map((record) => EntryRecordCard(
                                      record: record,
                                      useDefaultColor: true,
                                    ))
                                .toList(),
                          )
                        : const Center(child: Text("ไม่มีบันทึกที่ผ่านมา"))),
              ],
            ),
          );
        },
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildTodayRecord(UserSessionState state) {
    final tdRec = state.todayRecord;
    final widgetColor = tdRec == null
        ? Colors.blueGrey[400]
        : moodSliderPalette2[tdRec.moodLevel - 1];

    return Card(
      color: widgetColor,
      child: Padding(
        padding: const EdgeInsets.only(left: 12, top: 12, right: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'วันที่ ${formatDateInThai(tdRec?.recordDate ?? DateTime.now())}',
                      style: GoogleFonts.ibmPlexSansThai(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                      ),
                    ),
                    if (tdRec != null) ...[
                      Text(
                        'บันทึกเมื่อ ${DateFormat.Hm().format(tdRec.recordDate)}',
                        style: GoogleFonts.ibmPlexSansThai(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          height: 1.4,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.nights_stay_rounded,
                            size: 16,
                            color: Colors.black,
                          ),
                          Text(
                            ' ${tdRec.sleepTime.inHours} ชั่วโมง',
                            style: GoogleFonts.ibmPlexSansThai(
                                fontWeight: FontWeight.w600,
                                // height: 1.2,
                                // decoration: TextDecoration(),
                                color: Colors.black),
                          )
                        ],
                      ),
                    ]
                  ],
                ),
                if (tdRec != null) ...[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "ระดับอารมณ์",
                        style: GoogleFonts.ibmPlexSansThai(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                        ),
                      ),
                      // SizedBox(height: 1),
                      Text(
                        tdRec.moodLevel.toString(),
                        style: GoogleFonts.ibmPlexSansThai(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ]
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Transform.rotate(
                    angle: pi, child: const Icon(Icons.format_quote))
              ],
            ),
            Expanded(
              child: Container(
                  padding: const EdgeInsets.all(12),
                  // alignment: tdRec == null
                  //     ? Alignment.center : ,
                  decoration: BoxDecoration(
                      color: HSLColor.fromColor(widgetColor!)
                          .withLightness(0.7)
                          .toColor(),
                      borderRadius: BorderRadius.circular(6)),
                  child: tdRec == null
                      ? Text(
                          "วันนี้ยังไม่ได้บันทึกเรื่องราว\nแท็บ [+ สร้างบันทึก] เพื่อเริ่มเลย",
                          // textAlign: TextAlign.center,
                          style: GoogleFonts.ibmPlexSansThai(
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      : SingleChildScrollView(
                          child: Text(
                            tdRec.howWasYourDay,
                            // textAlign: TextAlign.left,
                            style: GoogleFonts.ibmPlexSansThai(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [const Icon(Icons.format_quote)],
            ),
            // const SizedBox(
            //   height: 8,
            // ),
          ],
        ),
      ),
    );
  }
}
/*

 if (addEditRecord)
              TextButton.icon(
                style: ElevatedButton.styleFrom(primary: widgetColor),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (builder) => const NewMentalEntryPage()));
                },
                icon: const Icon(Icons.edit, color: Colors.black),
                label: Text(
                  "แก้ไขบันทึกของวันนี้",
                  style: GoogleFonts.ibmPlexSansThai(
                      fontWeight: FontWeight.w600, color: Colors.black),
                ),
              ),
*/
