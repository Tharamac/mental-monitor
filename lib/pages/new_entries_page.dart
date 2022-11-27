import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mental_monitor/blocs/user/user_bloc.dart';
import 'package:mental_monitor/constant/palette.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:mental_monitor/model/daily_record.dart';
import 'package:mental_monitor/model/user.dart';
import 'package:mental_monitor/util.dart';

class NewMentalEntryPage extends StatefulWidget {
  const NewMentalEntryPage({Key? key}) : super(key: key);

  @override
  State<NewMentalEntryPage> createState() => _NewMentalEntryPageState();
}

class _NewMentalEntryPageState extends State<NewMentalEntryPage> {
  double _currentSliderValue = 5;
  final _formKey = GlobalKey<FormState>();
  // DateTime today = DateTime(
  //     DateTime.now().year + 543, DateTime.now().month, DateTime.now().day);
  TextEditingController dailynoteController = TextEditingController();
  TextEditingController hourDurationController = TextEditingController();
  TextEditingController minuteDurationController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    final todayRecord = DailyRecord(
                        recordDate: DateTime.now(),
                        moodLevel: _currentSliderValue.toInt(),
                        howWasYourDay: dailynoteController.text,
                        sleepTime: Duration(
                            hours: int.parse(hourDurationController.text),
                            minutes: int.parse(minuteDurationController.text)));

                    // pass
                    // print(todayRecord.toJson());
                    // print(DailyRecord.fromJson(todayRecord.toJson()));
                    // pass
                    context
                        .read<UserSessionBloc>()
                        .add(UpdateDailyRecord(todayRecord));
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("บันทึกสำเร็จ"),
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
                        TextFormField(
                          readOnly: true,
                          controller: TextEditingController(
                              text: formatDateInThai(DateTime.now())),
                          maxLines: 1,
                          decoration: const InputDecoration(
                            // contentPadding: EdgeInsets.all(8),
                            label: const Text("วันที่"),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 2,
                                  color: Colors.blueGrey), //<-- SEE HERE
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 2,
                                  color: Colors.blueGrey), //<-- SEE HERE
                            ),
                          ),
                        ),
                        // Text("30 เมษายน 2565"),
                        const Divider(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                flex: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    Row(
                                        children: emotionSliderPalette2
                                            .asMap()
                                            .entries
                                            .map((entry) {
                                      int idx = entry.key;
                                      Color? val = entry.value;

                                      return Expanded(
                                          child: Container(
                                        color: val,
                                        child: Text((idx + 1).toString()),
                                        height: 30,
                                      ));
                                    }).toList()),
                                  ],
                                )),
                            Expanded(
                              flex: 1,
                              child: Container(
                                  // color: Colors.amber,
                                  padding: EdgeInsets.only(top: 12),
                                  child: Text(
                                    _currentSliderValue.toInt().toString(),
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.ibmPlexSansThai(
                                      color: emotionSliderPalette2[
                                          _currentSliderValue.toInt() - 1],
                                      fontSize: 48,
                                      height: 1,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                            )
                          ],
                        ),
                        SliderTheme(
                          data: SliderThemeData(
                            showValueIndicator: ShowValueIndicator.always,
                            valueIndicatorTextStyle:
                                GoogleFonts.ibmPlexSansThai(
                              fontWeight: FontWeight.bold,
                            ),
                            trackHeight: 5,
                          ),
                          child: Slider(
                            value: _currentSliderValue,
                            max: 10,
                            min: 1,
                            divisions: 9,
                            // mouseCursor: MouseCursor.defer,
                            activeColor: emotionSliderPalette2[
                                    _currentSliderValue.toInt() - 1]
                                ?.withAlpha(120),
                            inactiveColor: emotionSliderPalette2[
                                    _currentSliderValue.toInt() - 1]
                                ?.withAlpha(120),
                            thumbColor: emotionSliderPalette2[
                                _currentSliderValue.toInt() - 1],
                            label: _currentSliderValue.round().toString(),
                            onChanged: (double value) {
                              setState(() {
                                _currentSliderValue = value;
                              });
                            },
                          ),
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
                            contentPadding: const EdgeInsets.all(12),
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

                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Text(
                                "เวลานอนรวม",
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
                                  if ((input ?? "").isEmpty) {
                                    return "กรุณาใส่จำนวนชั่วโมง";
                                  }
                                },

                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                textAlign: TextAlign.left,
                                keyboardType: TextInputType.number,
                                controller: hourDurationController,
                                decoration: const InputDecoration(
                                  // contentPadding: EdgeInsets.all(12),
                                  errorMaxLines: 2,
                                  contentPadding:
                                      const EdgeInsets.only(left: 12),
                                  label: const Text("ชั่วโมง"),
                                  counterText: "",

                                  errorStyle: TextStyle(
                                    height: 1,
                                  ),

                                  // alignLabelWithHint: true,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.blueGrey), //<-- SEE HERE
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.blueGrey), //<-- SEE HERE
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(":"),
                            ),
                            Expanded(
                              // flex: 2,
                              child: TextFormField(
                                // style: TextStyle(fontSize: 40),
                                // textAlign: TextAlign.center,
                                // enabled: false,
                                maxLength: 2,
                                validator: (input) {
                                  if ((input ?? "").isEmpty) {
                                    return "กรุณาใส่จำนวนนาที";
                                  }
                                  int minute = int.parse(input ?? "");
                                  if (!minute.isNegative && minute < 60) {
                                    return null;
                                  } else {
                                    return "ตัวเลขนาทีจะต้องอยู่ระหว่าง 0 - 59";
                                  }
                                },
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],

                                textAlign: TextAlign.left,
                                keyboardType: TextInputType.number,
                                controller: minuteDurationController,
                                decoration: const InputDecoration(
                                  errorMaxLines: 2,
                                  errorStyle: TextStyle(
                                    height: 1,
                                  ),
                                  counterText: "",
                                  contentPadding:
                                      const EdgeInsets.only(left: 12),
                                  label: Text("นาที"),
                                  // alignLabelWithHint: true,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.blueGrey), //<-- SEE HERE
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.blueGrey), //<-- SEE HERE
                                  ),
                                ),
                              ),
                            ),
                            // SizedBox(
                            //   width: 16,
                            // ),
                          ],
                        ),

                        // Text("วันนี้คุณตื่นกี่โมง"),
                        // Row(
                        //   children: [
                        //     TextFormField(
                        //       // onTap: () async {
                        //       // final DateTime? picked = await showDatePicker(
                        //       //   context: context,
                        //       //   // initialDate: selectedDate,
                        //       //   // initialDatePickerMode: DatePickerMode.day,
                        //       //   firstDate: DateTime(2015),
                        //       //   lastDate: DateTime(2101),
                        //       //   initialDate: null,
                        //       //   );
                        //       // if (picked != null)
                        //       //   setState(() {
                        //       //     selectedDate = picked;
                        //       //     _dateController.text = DateFormat.yMd().format(selectedDate);
                        //       //   });
                        //       // },

                        //       style: TextStyle(fontSize: 40),
                        //       textAlign: TextAlign.center,
                        //       enabled: false,
                        //       keyboardType: TextInputType.datetime,
                        //       controller: TextEditingController(text: "30 เมษายน 2564"),
                        //       // onSaved: (String val) {
                        //       //   _setDate = val;
                        //       // },
                        //       decoration: InputDecoration(
                        //           disabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
                        //           // label: NewMentalEntryPage,
                        //           contentPadding: EdgeInsets.only(top: 0.0)),
                        //     ),
                        //     TextFormField(
                        //       // onTap: () async {

                        //       // },

                        //       style: TextStyle(fontSize: 40),
                        //       textAlign: TextAlign.center,
                        //       enabled: false,
                        //       keyboardType: TextInputType.datetime,
                        //       controller: TextEditingController(text: "22.00น."),
                        //       // onSaved: (String val) {
                        //       //   _setDate = val;
                        //       // },
                        //       decoration: InputDecoration(
                        //           disabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
                        //           // label: NewMentalEntryPage,
                        //           contentPadding: EdgeInsets.only(top: 0.0)),
                        //     ),
                        //   ],
                        // ),
                      ]),
                ),
              )),
        ));
  }
}
