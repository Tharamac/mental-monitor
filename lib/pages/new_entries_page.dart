import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:collection/collection.dart';
import 'package:mental_monitor/blocs/record_form/record_form_cubit.dart';
import 'package:mental_monitor/blocs/record_form/record_form_state.dart';
import 'package:mental_monitor/blocs/user/user_bloc.dart';
import 'package:mental_monitor/constant/palette.dart';
import 'package:mental_monitor/model/core/datetime_expansion.dart';
import 'package:mental_monitor/model/daily_record.dart';
import 'package:mental_monitor/util.dart';

class NewMentalEntryPage extends StatefulWidget {
  const NewMentalEntryPage({Key? key}) : super(key: key);

  @override
  State<NewMentalEntryPage> createState() => _NewMentalEntryPageState();
}

class _NewMentalEntryPageState extends State<NewMentalEntryPage> {
  // double _currentSliderValue = 5;
  final _formKey = GlobalKey<FormState>();
  // DateTime today = DateTime(
  //     DateTime.now().year + 543, DateTime.now().month, DateTime.now().day);
  TextEditingController dailynoteController = TextEditingController();
  TextEditingController hourDurationController = TextEditingController();
  TextEditingController minuteDurationController = TextEditingController();
  int selectedDay = 0;
  final ValueNotifier<bool> canSleep = ValueNotifier<bool>(true);
  late final RecordFormState workingState;

  @override
  void initState() {
    final snapshot = context.read<RecordFormCubit>().state.currentWorkingRecord;
    // workingState =

    // _currentSliderValue = snapshot.todayRecord?.moodLevel.toDouble() ?? 5.0;
    dailynoteController.text = snapshot?.howWasYourDay ?? "";
    // hourDurationController.text =
    //     snapshot?.sleepTime.inHours.toString() ?? "";
    // minuteDurationController.text =
    //     snapshot?.sleepTime.inMinutes.remainder(60).toString() ?? "";
    if (snapshot?.sleepTime.inHours == 0) {
      canSleep.value = false;
      hourDurationController.text = "";
    } else {
      canSleep.value = true;
      hourDurationController.text =
          snapshot?.sleepTime.inHours.toString() ?? "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget segmentControlChildren(String dayAgoText, int dayAgo) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                dayAgoText,
                style: GoogleFonts.ibmPlexSansThai(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: (-dayAgo == selectedDay)
                      ? Colors.white
                      : Colors.blue[400],
                ),
              ),
              Text(
                formatDateInThai(
                    DateTime.now().subtract(Duration(days: dayAgo)),
                    shorten: true),
                style: GoogleFonts.ibmPlexSansThai(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: (-dayAgo == selectedDay)
                        ? Colors.white
                        : Colors.blue[400],
                    height: 0.8),
              ),
            ],
          ),
        );
    DropdownMenuItem<int> dropDownChildren(String dayAgoText, int? dayAgo) =>
        DropdownMenuItem<int>(
          value: -(dayAgo ?? 0),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "${dayAgo ?? ""}$dayAgoText",
                style: GoogleFonts.ibmPlexSansThai(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: Colors.blue,
                ),
              ),
              Text(
                " — ${formatDateInThai(DateTime.now().subtract(Duration(days: dayAgo ?? 0)))}",
                style: GoogleFonts.ibmPlexSansThai(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        );
    // RichText(
    //   text: TextSpan(
    //       text: "$dayAgoText\n",
    //       style: GoogleFonts.ibmPlexSansThai(
    //         fontSize: 12,
    //         fontWeight: FontWeight.w800,
    //         color: Colors.blue[400],
    //       ),
    //       children: [
    //         TextSpan(
    //             text: formatDateInThai(
    //                 DateTime.now().subtract(Duration(days: dayAgo)),
    //                 shorten: true),
    //             style: GoogleFonts.ibmPlexSansThai(
    //               fontSize: 12,
    //               fontWeight: FontWeight.w400,
    //             ))
    //       ]),
    // );
    return MultiBlocListener(
        listeners: [
          BlocListener<UserSessionBloc, UserSessionState>(
            listenWhen: (previous, current) => !const DeepCollectionEquality()
                .equals(previous.records, current.records),
            listener: (context, state) {
              context.read<RecordFormCubit>().loadLatestRecords(state.records);
            },
          ),
          BlocListener<RecordFormCubit, RecordFormState>(
            listenWhen: (previous, current) {
              return !previous.currentWorkingRecord!.recordDate.dateOnly
                  .isAtSameMomentAs(
                      current.currentWorkingRecord!.recordDate.dateOnly);
            },
            listener: (context, state) {
              //
              final currentHowwasYourDay =
                  state.currentWorkingRecord?.howWasYourDay ?? "";
              dailynoteController.text = currentHowwasYourDay;
              final currentSleepTime =
                  state.currentWorkingRecord?.sleepTime.inHours.toString() ??
                      "";
              if (currentSleepTime == "0") {
                canSleep.value = false;
                hourDurationController.text = "";
              } else {
                canSleep.value = true;
                hourDurationController.text = currentSleepTime;
              }
            },
          ),
        ],
        child: Scaffold(
            // resizeToAvoidBottomInset: false,
            appBar: AppBar(
              centerTitle: true,
              title: Text("วันนี้คุณเป็นยังไงบ้าง",
                  style: GoogleFonts.ibmPlexSansThai(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  )),
              actions: [
                TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final record = DailyRecord(
                            recordDate:
                                DateTime.now().add(Duration(days: selectedDay)),
                            moodLevel: context
                                .read<RecordFormCubit>()
                                .state
                                .currentWorkingRecord!
                                .moodLevel
                                .toInt(),
                            howWasYourDay: dailynoteController.text,
                            sleepTime: canSleep.value
                                ? Duration(
                                    hours:
                                        int.parse(hourDurationController.text),
                                    // minutes: int.parse(minuteDurationController.text)
                                  )
                                : Duration.zero);
                        context.read<UserSessionBloc>().add(UpdateDailyRecord(
                            record)); // todo: support every date
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("บันทึกสำเร็จ",
                              style: GoogleFonts.ibmPlexSansThai(
                                fontWeight: FontWeight.w400,
                                // fontSize: 18
                              )),
                        ));
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text("บันทึก",
                        style: GoogleFonts.ibmPlexSansThai(
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                        ))),
              ],
            ),
            body: SafeArea(
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                      child: Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: DropdownButtonFormField<int>(
                                value: selectedDay,
                                decoration: InputDecoration(
                                  // contentPadding: EdgeInsets.all(8),
                                  label: Text("วันที่",
                                      style: GoogleFonts.ibmPlexSansThai(
                                        fontSize: 18,
                                        color: Colors.blueGrey,
                                        fontWeight: FontWeight.w800,
                                      )),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2,
                                        color: Colors.blueGrey), //<-- SEE HERE
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2,
                                        color: Colors.blueGrey), //<-- SEE HERE
                                  ),
                                ),
                                items: [
                                  for (var i = 3; i > 0; i--) ...[
                                    dropDownChildren(" วันที่แล้ว", i)
                                  ],
                                  ...[dropDownChildren("วันนี้", null)],
                                ],
                                // dropdownMenuEntries: colorEntries,x
                                onChanged: (int? currentDayOffset) async {
                                  final backupSelectedDayOffset = selectedDay;
                                  setState(() {
                                    selectedDay = currentDayOffset!;
                                  });
                                  final selectedDate = DateTime.now()
                                      .dateOnly
                                      .add(Duration(days: currentDayOffset!));
                                  await confirmChangingDateDialog(
                                      currentDate: DateTime.now().dateOnly.add(
                                          Duration(
                                              days: backupSelectedDayOffset)),
                                      onDelete: () {
                                        context
                                            .read<RecordFormCubit>()
                                            .changeRecordByDate(selectedDate);
                                        Navigator.of(context).pop();
                                      },
                                      onCancel: () {
                                        setState(() {
                                          selectedDay = backupSelectedDayOffset;
                                        });
                                        context
                                            .read<RecordFormCubit>()
                                            .changeRecordByDate(DateTime.now()
                                                .dateOnly
                                                .add(Duration(
                                                    days:
                                                        backupSelectedDayOffset)));
                                        Navigator.of(context).pop();
                                      });
                                  // }
                                  //  else {
                                  //   context
                                  //       .read<RecordFormCubit>()
                                  //       .changeRecordByDate(selectedDate);
                                  // }

                                  // confirmChangingDateDialog(
                                  //     DateTime.now().subtract(
                                  //         Duration(days: -backupSelectedDay)),
                                  //     () {
                                  //   Navigator.of(context).pop();
                                  // }, () {
                                  //   Navigator.of(context).pop();
                                  // }, () {
                                  //   setState(() {
                                  //     selectedDay = backupSelectedDay;
                                  //   });
                                  //   Navigator.of(context).pop();
                                  // });
                                },
                              )),
                          // TextFormField(
                          //   readOnly: true,
                          //   controller: TextEditingController(
                          //       text: formatDateInThai(DateTime.now())),
                          //   maxLines: 1,
                          //   decoration: const InputDecoration(
                          //     // contentPadding: EdgeInsets.all(8),
                          //     label: const Text("วันที่"),
                          //     enabledBorder: const OutlineInputBorder(
                          //       borderSide: const BorderSide(
                          //           width: 2,
                          //           color: Colors.blueGrey), //<-- SEE HERE
                          //     ),
                          //     focusedBorder: const OutlineInputBorder(
                          //       borderSide: const BorderSide(
                          //           width: 2,
                          //           color: Colors.blueGrey), //<-- SEE HERE
                          //     ),
                          //   ),
                          // ),
                          // Text("30 เมษายน 2565"),
                          const Divider(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  flex: 5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "คะแนนอารมณ์วันนี้",
                                        style: GoogleFonts.ibmPlexSansThai(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                          "1 คือ อารมณ์โดยรวมแย่มาก, 10 คือ อารมณ์โดยรวมดีมาก",
                                          style: GoogleFonts.ibmPlexSansThai(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          )),
                                      // Row(
                                      //     children: moodSliderPalette1
                                      //         .asMap()
                                      //         .entries
                                      //         .map((entry) {
                                      //   int idx = entry.key;
                                      //   Color? val = entry.value;

                                      //   return Expanded(
                                      //       child: Column(
                                      //     children: [
                                      //       Container(
                                      //         color: val,
                                      //         height: 30,
                                      //       ),
                                      //       Center(
                                      //           child:
                                      //               Text((idx + 1).toString())),
                                      //     ],
                                      //   ));
                                      // }).toList()),
                                    ],
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: BlocSelector<
                                      RecordFormCubit,
                                      RecordFormState,
                                      double>(selector: (state) {
                                    return state.currentWorkingRecord?.moodLevel
                                            .toDouble() ??
                                        5.0;
                                  }, builder: (context, currentSliderValue) {
                                    return Container(
                                        // color: Colors.amber,
                                        padding: EdgeInsets.only(top: 12),
                                        child: Text(
                                          currentSliderValue.toInt().toString(),
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.ibmPlexSansThai(
                                            color: moodSliderPalette1[
                                                currentSliderValue.toInt() - 1],
                                            fontSize: 48,
                                            height: 1,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ));
                                  }))
                            ],
                          ),
                          // Bloc<RecordFormCubit, RecordFormState>(
                          BlocSelector<RecordFormCubit, RecordFormState,
                              double>(
                            selector: (state) {
                              return state.currentWorkingRecord?.moodLevel
                                      .toDouble() ??
                                  5.0;
                            },
                            builder: (context, currentSliderValue) {
                              return SliderTheme(
                                data: SliderThemeData(
                                  showValueIndicator: ShowValueIndicator.always,
                                  valueIndicatorTextStyle:
                                      GoogleFonts.ibmPlexSansThai(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  trackHeight: 5,
                                ),
                                child: Slider(
                                  value: currentSliderValue,
                                  max: 10,
                                  min: 1,
                                  divisions: 9,
                                  // label: _currentSliderValue.toString(),
                                  // mouseCursor: MouseCursor.defer,
                                  activeColor: moodSliderPalette1[
                                          currentSliderValue.toInt() - 1]
                                      ?.withAlpha(120),
                                  inactiveColor: moodSliderPalette1[
                                          currentSliderValue.toInt() - 1]
                                      ?.withAlpha(120),
                                  thumbColor: moodSliderPalette1[
                                      currentSliderValue.toInt() - 1],
                                  label: currentSliderValue.round().toString(),

                                  onChanged: (double value) {
                                    context.read<RecordFormCubit>().updateData(
                                        newMoodLevel: value.toInt());
                                    // setState(() {
                                    //   _currentSliderValue = value;
                                    // });
                                  },
                                ),
                              );
                            },
                          ),
                          Transform.rotate(
                              angle: pi, child: const Icon(Icons.format_quote)),
                          TextFormField(
                            // scrollPadding: EdgeInsets.all(45),
                            controller: dailynoteController,
                            validator: (input) {
                              if ((input ?? "").isNotEmpty) {
                                return null;
                              } else {
                                return "ถ้าไม่มีให้ใส่ -";
                              }
                            },
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(12),
                              label: Text("วันนี้รู้สึกอย่างไรบ้าง :"),
                              alignLabelWithHint: true,
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
                            maxLines: 8,
                          ),
                          const Icon(Icons.format_quote),
                          const Divider(),
                          Text(
                            "ข้อมูลการนอน",
                            style: GoogleFonts.ibmPlexSansThai(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),

                          // const SizedBox(
                          //   height: 12,
                          // ),
                          ValueListenableBuilder(
                            valueListenable: canSleep,

                            builder: (BuildContext context, bool value,
                                    Widget? child) =>
                                Column(
                              children: [
                                CheckboxListTile(
                                    contentPadding: EdgeInsets.zero,
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    value: !value,
                                    title: const Text(
                                        "ท่านไม่ได้นอน หรือ นอนไม่หลับ"),
                                    onChanged: (bool? checkSleep) {
                                      // setState(() {
                                      canSleep.value = !checkSleep!;
                                      // });
                                    }),
                                if (value)
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 16.0),
                                        child: Text(
                                          "เวลานอนรวมโดยประมาณ",
                                          style: GoogleFonts.ibmPlexSansThai(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        // flex: 2,
                                        child: TextFormField(
                                          // style: TextStyle(fontSize: 40),
                                          // textAlign: TextAlign.center,
                                          // enabled: false,
                                          maxLength: 2,
                                          validator: (input) {
                                            if ((input ?? "").isEmpty &&
                                                value) {
                                              return "กรุณาใส่จำนวนชั่วโมง";
                                            }
                                          },

                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          textAlign: TextAlign.left,
                                          keyboardType: TextInputType.number,
                                          controller: hourDurationController,
                                          decoration: const InputDecoration(
                                            // contentPadding: EdgeInsets.all(12),
                                            errorMaxLines: 2,
                                            contentPadding:
                                                EdgeInsets.only(left: 12),
                                            // label: Text("ชั่วโมง"),
                                            counterText: "",

                                            errorStyle: TextStyle(
                                              height: 1,
                                            ),

                                            alignLabelWithHint: true,
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Colors
                                                      .blueGrey), //<-- SEE HERE
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Colors
                                                      .blueGrey), //<-- SEE HERE
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text("ชั่วโมง"),
                                      ),
                                    ],
                                  )
                              ],
                            ),

                            // Expanded(
                            //   // flex: 2,
                            //   child: TextFormField(
                            //     // style: TextStyle(fontSize: 40),
                            //     // textAlign: TextAlign.center,
                            //     // enabled: false,
                            //     maxLength: 2,
                            //     validator: (input) {
                            //       if ((input ?? "").isEmpty) {
                            //         return "กรุณาใส่จำนวนนาที";
                            //       }
                            //       int minute = int.parse(input ?? "");
                            //       if (!minute.isNegative && minute < 60) {
                            //         return null;
                            //       } else {
                            //         return "ตัวเลขนาทีจะต้องอยู่ระหว่าง 0 - 59";
                            //       }
                            //     },
                            //     inputFormatters: <TextInputFormatter>[
                            //       FilteringTextInputFormatter.digitsOnly
                            //     ],

                            //     textAlign: TextAlign.left,
                            //     keyboardType: TextInputType.number,
                            //     controller: minuteDurationController,
                            //     decoration: const InputDecoration(
                            //       errorMaxLines: 2,
                            //       errorStyle: TextStyle(
                            //         height: 1,
                            //       ),
                            //       counterText: "",
                            //       contentPadding: EdgeInsets.only(left: 12),
                            //       label: Text("นาที"),
                            //       // alignLabelWithHint: true,
                            //       enabledBorder: UnderlineInputBorder(
                            //         borderSide: BorderSide(
                            //             width: 1,
                            //             color: Colors.blueGrey), //<-- SEE HERE
                            //       ),
                            //       focusedBorder: UnderlineInputBorder(
                            //         borderSide: BorderSide(
                            //             width: 1,
                            //             color: Colors.blueGrey), //<-- SEE HERE
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // SizedBox(
                            //   width: 16,
                            // ),
                          ),
                        ]),
                  ))),
            )));
  }

  Future<void> confirmChangingDateDialog(
      {required DateTime currentDate,
      required VoidCallback onDelete,
      required VoidCallback onCancel}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'แจ้งเตือนการเปลี่ยนวันที่',
            style: GoogleFonts.ibmPlexSansThai(
                fontSize: 16, fontWeight: FontWeight.bold),
          ),
          content: Text(
              'คุณต้องการจะเปลี่ยนวันที่เป็น ${formatDateInThai(currentDate)} หรือไม่ (หากตกลงข้อมูลปัจจุบันจะถูกลบหากไม่บันทึก)'),
          actions: <Widget>[
            TextButton(
              child: const Text('ตกลง'),
              onPressed: onDelete,
            ),
            TextButton(
              child: const Text('ยกเลิกการเปลี่ยนวันที่'),
              onPressed: onCancel,
            ),
          ],
        );
      },
    );
  }
}
