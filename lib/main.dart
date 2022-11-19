import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MentalMonitor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // fontFamily:
        textTheme: GoogleFonts.ibmPlexSansThaiTextTheme(),
        drawerTheme: DrawerThemeData(elevation: 2, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
        appBarTheme: AppBarTheme(
            toolbarHeight: 70,
            color: Colors.grey[100],
            titleTextStyle: GoogleFonts.ibmPlexSansThai(color: Colors.blue[400], fontSize: 30, fontWeight: FontWeight.bold),
            iconTheme: IconThemeData(color: Colors.blue[400], size: 35),
            actionsIconTheme: IconThemeData(color: Colors.black87),

            /// Elevation is easy and works OK too
            elevation: 2,
            shadowColor: Colors.blue[300]),
      ),
      home: const HomePage(),
    );
  }
}
