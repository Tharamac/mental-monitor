import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mental_monitor/blocs/user/user_bloc.dart';
import 'package:mental_monitor/pages/new_entries_page.dart';
import 'package:mental_monitor/util.dart';
import 'package:mental_monitor/widgets/menu_drawer.dart';

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
  @override
  void initState() {
    widget.currentUserData.fold((newUser) {
      context.read<UserSessionBloc>().add(RegisterUserEvent(newUser));
    }, (existingUser) {
      context.read<UserSessionBloc>().add(ImportExistingUserEvent(existingUser));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime(
        DateTime.now().year + 543, DateTime.now().month, DateTime.now().day);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          "วันนี้คุณเป็นยังไงบ้าง",
          // style: GoogleFonts.ibmPlexSansThai(),
        ),
      ),
      drawer: MainMenuDrawerWidget(),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Text(
                "บันทึกของวันนี้",
                style: GoogleFonts.ibmPlexSansThai(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(
                flex: 3,
                child: Card(
                  color: Colors.blueGrey[200],
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          formatDateInThai(DateTime.now()),
                          style: GoogleFonts.ibmPlexSansThai(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.all(4),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.blueGrey[400],
                                borderRadius: BorderRadius.circular(6)),
                            child: Text(
                              "วันนี้ยังไม่ได้บันทึกเรื่องราว กดเพื่อบันทึกเลย",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.ibmPlexSansThai(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextButton.icon(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blueGrey[200]),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (builder) => NewMentalEntryPage()));
                          },
                          icon: Icon(Icons.add, color: Colors.black),
                          label: Text(
                            "เพิ่มบันทึกของวันนี้",
                            style: GoogleFonts.ibmPlexSansThai(
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "บันทึกที่ผ่านมา",
                style: GoogleFonts.ibmPlexSansThai(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(
                  flex: 7,
                  child: ListView(
                    children: [
                      EntryRecordCard(),
                      EntryRecordCard(),
                      EntryRecordCard(),
                      EntryRecordCard(),
                      EntryRecordCard(),
                      EntryRecordCard(),
                      EntryRecordCard(),
                    ],
                  ))
            ],
          ),
        ),
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

