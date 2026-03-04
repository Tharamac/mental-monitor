import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainMenuDrawerWidget extends StatelessWidget {
  const MainMenuDrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 26, 150, 251),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: FittedBox(
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomRight,
              child: Text(
                'ทยายสาญุก\nสานพำยบาสั้น',
                style: GoogleFonts.ibmPlexSansThai(fontWeight: FontWeight.w700, height: 1.5),
                textAlign: TextAlign.right,
              ),
            ),
          ),
        ),
        // ),
        SizedBox(
          height: 16,
        ),
        Container(
          color: Colors.blue[100],
          padding: const EdgeInsets.only(left: 20.0, top: 12, bottom: 4),
          child: Text(
            "เมนูหลัก",
            style: GoogleFonts.ibmPlexSansThai(
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        Expanded(
          flex: 3,
          child: ListView(
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              TextButton.icon(
                  onPressed: () {},
                  style: TextButton.styleFrom(alignment: Alignment.centerLeft, minimumSize: Size(200, 60), backgroundColor: Colors.blue[50], padding: EdgeInsets.symmetric(horizontal: 20)),
                  icon: Icon(Icons.email),
                  label: Text(
                    "ส่งข้อมูลไปที่อีเมล์",
                    style: GoogleFonts.ibmPlexSansThai(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
              TextButton.icon(
                  onPressed: () {},
                  style: TextButton.styleFrom(alignment: Alignment.centerLeft, minimumSize: Size(200, 60), backgroundColor: Colors.blue[50], padding: EdgeInsets.symmetric(horizontal: 20)),
                  icon: Icon(Icons.backup),
                  label: Text(
                    "สำรองข้อมูล",
                    style: GoogleFonts.ibmPlexSansThai(fontSize: 24, fontWeight: FontWeight.w600),
                  )),
              TextButton.icon(
                  onPressed: () {},
                  style: TextButton.styleFrom(alignment: Alignment.centerLeft, minimumSize: Size(200, 60), backgroundColor: Colors.blue[50], padding: EdgeInsets.symmetric(horizontal: 20)),
                  icon: Icon(Icons.settings),
                  label: Text(
                    "การตั้งค่า",
                    style: GoogleFonts.ibmPlexSansThai(fontSize: 24, fontWeight: FontWeight.w600),
                  )),
            ],
          ),
        ),
      ]),
    );
  }
}
