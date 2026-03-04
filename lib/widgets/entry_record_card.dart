import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

class EntryRecordCard extends StatelessWidget {
  const EntryRecordCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlue[500],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  textHeightBehavior: TextHeightBehavior(),
                  text: TextSpan(
                    style: GoogleFonts.ibmPlexSansThai(
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(text: 'วันที่ 30 พฤศจิกายน พ.ศ.2565\n'),
                      TextSpan(text: 'บันทึกเมื่อ 17:50น.\n'),
                      WidgetSpan(
                          child: Icon(
                        Icons.hotel,
                        size: 14,
                      )),
                      TextSpan(text: '  7ชม. 18น.'),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "ระดับอารมณ์",
                      style: GoogleFonts.ibmPlexSansThai(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "7",
                      style: GoogleFonts.ibmPlexSansThai(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Colors.lightBlue[200],
                    borderRadius: BorderRadius.circular(6)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Transform.rotate(
                        angle: pi, child: Icon(Icons.format_quote)),
                    Text(
                      "วันนี้ผมได้ดูชาร์แก้งอีกวัน มันสุดจะ amazing ไปเยย วันนี้เจ้่าชายไลฟ์ด้วยก็ดีไปใหญ่เลย",
                    ),
                    Icon(Icons.format_quote)
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
