import 'package:duration/duration.dart';
import 'package:duration/locale.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mental_monitor/constant/palette.dart';
import 'package:mental_monitor/model/daily_record.dart';
import 'dart:math';

import 'package:mental_monitor/pages/new_entries_page.dart';
import 'package:mental_monitor/util.dart';

class EntryRecordCard extends StatelessWidget {
  final DailyRecord record;
  final bool useDefaultColor;

  const EntryRecordCard(
      {Key? key, this.useDefaultColor = false, required this.record})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widgetColor = useDefaultColor
        ? Colors.lightBlue[300]
        : moodSliderPalette1[record.moodLevel - 1];

    return Card(
      color: widgetColor,
      child: Padding(
        padding: const EdgeInsets.only(left: 12, top: 12, right: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'วันที่ ${formatDateInThai(record.recordDate)}',
                      style: GoogleFonts.ibmPlexSansThai(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        // height: 1.4,
                      ),
                    ),
                    Text(
                      'บันทึกเมื่อ ${DateFormat.Hm().format(record.recordDate)}',
                      style: GoogleFonts.ibmPlexSansThai(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        // height: 1.4,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.nights_stay_rounded,
                          size: 14,
                          color: Colors.black,
                        ),
                        Text(
                          (record.sleepTime.inHours == 0)
                              ? ' ไม่ได้นอน'
                              : ' ${record.sleepTime.inHours} ชั่วโมง',
                          style: GoogleFonts.ibmPlexSansThai(
                              fontWeight: FontWeight.w600,
                              // height: 1.4,
                              // decoration: TextDecoration(),
                              color: Colors.black),
                        )
                      ],
                    ),
                  ],
                ),
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
                      record.moodLevel.toString(),
                      style: GoogleFonts.ibmPlexSansThai(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Transform.rotate(
                    angle: pi, child: const Icon(Icons.format_quote))
              ],
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: HSLColor.fromColor(widgetColor!)
                      .withLightness(0.8)
                      .toColor(),
                  // color: widgetColor?.withAlpha(128),
                  borderRadius: BorderRadius.circular(6)),
              child: Text(
                record.howWasYourDay,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(Icons.format_quote),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
