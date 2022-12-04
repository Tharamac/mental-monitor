import 'dart:convert';

import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mental_monitor/api/notification_api.dart';
import 'package:mental_monitor/blocs/app_bloc_observer.dart';
import 'package:mental_monitor/blocs/user/user_bloc.dart';
import 'package:mental_monitor/constant/constant.dart';
import 'package:mental_monitor/data_mock.dart';
import 'package:mental_monitor/file_manager.dart';
import 'package:mental_monitor/model/daily_record.dart';
import 'package:mental_monitor/model/user.dart';
import 'package:mental_monitor/pages/welcome_page.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzData;
import 'pages/home_page.dart';

const useMockData = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'th';
  initializeDateFormatting();
  tzData.initializeTimeZones();

  Map<String, dynamic>? currentUserData;
  if (useMockData) {
    // currentUserData = mockUserData.toJson();

    FileManager(fileName: currentUserFile).writedata(jsonEncode(
      mockUserData.toJson(),
    ));
  }
  currentUserData =
      await FileManager(fileName: currentUserFile).readData().then((value) {
    print(value);
    final conv = jsonDecode(value);
    print(conv);
  }, onError: (e) => null);

  await LocalNoticeService().setup();
  // DateTime.parse(currentUserData["notified_time"])
  // todo: load actual setting on home_page
  LocalNoticeService().showDailyNotificationAtTime(
      0,
      "วันนี้เป็นอย่างไรบ้าง",
      "บันทึกเรื่องราววันนี้ได้เลย",
      "notify memo",
      TimeOfDay(hour: 19, minute: 00));

  Bloc.observer = AppBlocObserver();
  runApp(MyApp(
    currentUserData: currentUserData,
  ));
}

class MyApp extends StatelessWidget {
  final Map<String, dynamic>? currentUserData;

  const MyApp({
    Key? key,
    this.currentUserData,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final child = MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MoodMonitor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // fontFamily:
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(12),
          enabledBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(width: 2, color: Colors.blueGrey), //<-- SEE HERE
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Colors.blue), //<-- SEE HERE
          ),
          errorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(width: 2, color: Colors.red.shade300), //<-- SEE HERE
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.red.shade300),
          ),
        ),
        textTheme: GoogleFonts.ibmPlexSansThaiTextTheme(),
        drawerTheme: DrawerThemeData(
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        appBarTheme: AppBarTheme(
            // toolbarHeight: 70,
            color: Colors.grey[100],
            titleTextStyle: GoogleFonts.ibmPlexSansThai(
                color: Colors.blue[400],
                fontSize: 30,
                fontWeight: FontWeight.bold),
            iconTheme: IconThemeData(color: Colors.blue[400], size: 35),
            actionsIconTheme: const IconThemeData(color: Colors.black87),
            elevation: 2,
            shadowColor: Colors.blue[300]),
      ),
      home: currentUserData == null
          ? WelcomePage()
          : HomePage(currentUserData: right(currentUserData!)),
    );
    return MultiBlocProvider(providers: [
      BlocProvider<UserSessionBloc>(
        create: (BuildContext context) => UserSessionBloc(),
      ),
    ], child: child);
  }
}
