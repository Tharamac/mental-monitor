import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mental_monitor/constant/palette.dart';

class NewMentalEntryPage extends StatefulWidget {
  const NewMentalEntryPage({Key? key}) : super(key: key);

  @override
  State<NewMentalEntryPage> createState() => _NewMentalEntryPageState();
}

class _NewMentalEntryPageState extends State<NewMentalEntryPage> {
  double _currentSliderValue = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text("วันนี้คุณเป็นยังไงบ้าง",
              style: GoogleFonts.ibmPlexSansThai(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
          actions: [
            TextButton(
                onPressed: () {},
                child: Text("บันทึก",
                    style: GoogleFonts.ibmPlexSansThai(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ))),
          ],
        ),
        body: SafeArea(
          child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                  TextFormField(
                    readOnly: true,
                    controller: TextEditingController(text: "30 เมษายน 2564"),
                    maxLines: 1,
                    decoration: InputDecoration(
                      // contentPadding: EdgeInsets.all(8),
                      label: Text("วันที่"),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.blueGrey), //<-- SEE HERE
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.blueGrey), //<-- SEE HERE
                      ),
                    ),
                  ),
                  // Text("30 เมษายน 2565"),
                  Divider(),
                  Text(
                    "คะแนนอารมณ์วันนี้",
                    style: GoogleFonts.ibmPlexSansThai(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text("(1 คือ อารมณ์โดยรวมแย่มาก, 10 คือ อารมณ์โดยรวมดีมาก)"),
                  // Row(
                  //     children: emotionSliderPalette.asMap().entries.map((entry) {
                  //   int idx = entry.key;
                  //   Color? val = entry.value;

                  //   return Expanded(
                  //       child: Container(
                  //     color: val,
                  //     child: Text((idx + 1).toString()),
                  //     height: 30,
                  //   ));
                  // }).toList()),
                  SliderTheme(
                    data: SliderThemeData(
                      showValueIndicator: ShowValueIndicator.always,
                      valueIndicatorTextStyle: GoogleFonts.ibmPlexSansThai(fontWeight: FontWeight.bold, color: emotionSliderPalette[_currentSliderValue.toInt() - 1]),
                      trackHeight: 10,
                    ),
                    child: Slider(
                      value: _currentSliderValue,
                      max: 10,
                      min: 1,
                      divisions: 9,
                      mouseCursor: MouseCursor.defer,
                      // activeColor: Colors.grey,
                      // inactiveColor: Colors.black,
                      thumbColor: emotionSliderPalette[_currentSliderValue.toInt() - 1],
                      label: _currentSliderValue.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValue = value;
                        });
                      },
                    ),
                  ),

                  TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(12),
                      label: Text("วันนี้รู้สึกอย่างไรบ้าง :"),
                      alignLabelWithHint: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.blueGrey), //<-- SEE HERE
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.blueGrey), //<-- SEE HERE
                      ),
                    ),
                    maxLines: 8,
                  ),
                  Divider(),
                  Text(
                    "ข้อมูลการนอน",
                    style: GoogleFonts.ibmPlexSansThai(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "เวลานอนรวม 8ชม. 10นาที",
                    style: GoogleFonts.ibmPlexSansThai(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.nights_stay_rounded,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          // style: TextStyle(fontSize: 40),
                          // textAlign: TextAlign.center,
                          // enabled: false,
                          keyboardType: TextInputType.datetime,
                          controller: TextEditingController(text: "22.00น."),
                          // onSaved: (String val) {
                          //   _setDate = val;
                          // },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(12),
                            label: Text("เวลาเข้านอนเมื่อวาน"),
                            alignLabelWithHint: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2, color: Colors.blueGrey), //<-- SEE HERE
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2, color: Colors.blueGrey), //<-- SEE HERE
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   width: 16,
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.wb_sunny_rounded),
                      ),
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          // onTap: () async {

                          // },
                          // style: TextStyle(fontSize: ),
                          // textAlign: TextAlign.center,
                          // enabled: false,
                          keyboardType: TextInputType.datetime,
                          controller: TextEditingController(text: "6.00น."),
                          // onSaved: (String val) {
                          //   _setDate = val;
                          // },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(12),
                            label: Text("เวลาตื่นวันนี้"),
                            alignLabelWithHint: true,
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2, color: Colors.blueGrey), //<-- SEE HERE
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2, color: Colors.blueGrey), //<-- SEE HERE
                            ),
                          ),
                        ),
                      ),
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
              )),
        ));
  }
}
