import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

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
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "การแจ้งเตือนการบันทึก",
              style: GoogleFonts.ibmPlexSansThai(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("แอพจะแจ้งเตือนเวลา 19.00น. ของทุกวัน"),
                TextButton(
                  onPressed: () {},
                  child: Text("เปลี่ยนเวลา"),
                )
              ],
            ),
            Divider(),
            Text(
              "สำรองข้อมูล",
              style: GoogleFonts.ibmPlexSansThai(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextButton(onPressed: (() {}), child: Text("สำรองข้อมูลตอนนี้")),
            Divider(),
            Text(
              "ส่งข้อมูลไปที่อีเมล์",
              style: GoogleFonts.ibmPlexSansThai(fontSize: 16, fontWeight: FontWeight.bold),
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
                    // controller: TextEditingController(text: "30 เมษายน 2564"),
                    maxLines: 1,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      // contentPadding: EdgeInsets.all(8),
                      label: Text("อีเมล์แอดเดรส"),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.blueGrey), //<-- SEE HERE
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.blueGrey), //<-- SEE HERE
                      ),
                    ),
                  ),
                ),
                TextButton(onPressed: (() {}), child: Text("ส่ง"))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
