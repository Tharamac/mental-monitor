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
  final bool isToday;
  final bool isRecordedToday;
  final DailyRecord record;
  final bool useDefaultColor;

  const EntryRecordCard(
      {Key? key,
      this.isToday = false,
      this.isRecordedToday = false,
      this.useDefaultColor = false,
      required this.record})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widgetColor = (isToday && !isRecordedToday)
        ? Colors.blueGrey[400]
        : useDefaultColor
            ? Colors.lightBlue[500]
            : emotionSliderPalette2[record.moodLevel - 1];
    print(widgetColor?.withOpacity(0.5));

    return Card(
      color: widgetColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  textHeightBehavior: const TextHeightBehavior(),
                  text: TextSpan(
                    style: GoogleFonts.ibmPlexSansThai(
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(
                          text:
                              'วันที่ ${formatDateInThai(record.recordDate)}\n'),
                      TextSpan(
                          text:
                              'บันทึกเมื่อ ${DateFormat.Hm().format(record.recordDate)}\n'),
                      const WidgetSpan(
                          child: const Icon(
                        Icons.hotel,
                        size: 14,
                      )),
                      TextSpan(
                          text:
                              ' ${prettyDuration(record.sleepTime, locale: DurationLocale.fromLanguageCode('th')!)}'),
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
                      record.moodLevel.toString(),
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
            const SizedBox(
              height: 16,
            ),
            Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: HSLColor.fromColor(widgetColor!)
                        .withLightness(0.7)
                        .toColor(),
                    // color: widgetColor?.withAlpha(128),
                    borderRadius: BorderRadius.circular(6)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Transform.rotate(
                        angle: pi, child: const Icon(Icons.format_quote)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        record.howWasYourDay,
                      ),
                    ),
                    const Icon(Icons.format_quote)
                  ],
                )),
            if (isToday && !isRecordedToday)
              TextButton.icon(
                style: ElevatedButton.styleFrom(primary: Colors.blueGrey[200]),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (builder) => const NewMentalEntryPage()));
                },
                icon: const Icon(Icons.add, color: Colors.black),
                label: Text(
                  "เพิ่มบันทึกของวันนี้",
                  style: GoogleFonts.ibmPlexSansThai(
                      fontWeight: FontWeight.w600, color: Colors.black),
                ),
              ),
            if (isToday && isRecordedToday)
              TextButton.icon(
                style: ElevatedButton.styleFrom(primary: Colors.blueGrey[200]),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (builder) => const NewMentalEntryPage()));
                },
                icon: const Icon(Icons.edit, color: Colors.black),
                label: Text(
                  "แก้ไขบันทึกของวันนี้",
                  style: GoogleFonts.ibmPlexSansThai(
                      fontWeight: FontWeight.w600, color: Colors.black),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
