import 'package:mental_monitor/model/user.dart';

import 'model/daily_record.dart';

DateTime dayShift(int numOfDays) =>
    DateTime.now().subtract(Duration(days: numOfDays));

final mockUserData = User(name: "makuji", records: [
  DailyRecord(
      recordDate: dayShift(9),
      moodLevel: 7,
      howWasYourDay: "ดูเกี๊ยว",
      sleepTime: const Duration(hours: 6, minutes: 34)),
  DailyRecord(
      recordDate: dayShift(0),
      moodLevel: 6,
      howWasYourDay: "ดูเจ๊ปลาทอง",
      sleepTime: const Duration(hours: 6, minutes: 33)),
  DailyRecord(
      recordDate: dayShift(3),
      moodLevel: 5,
      howWasYourDay: "ดูพัสดีเมื่อไรชีจะกลับมา",
      sleepTime: const Duration(hours: 6, minutes: 32)),
  DailyRecord(
      recordDate: dayShift(2),
      moodLevel: 4,
      howWasYourDay: "ดูเฟย์",
      sleepTime: const Duration(hours: 6, minutes: 31)),
  DailyRecord(
      recordDate: dayShift(5),
      moodLevel: 3,
      howWasYourDay: "ดูไคออน",
      sleepTime: const Duration(hours: 6, minutes: 30)),
  DailyRecord(
      recordDate: dayShift(4),
      moodLevel: 2,
      howWasYourDay: "ดูนายอาร์ม",
      sleepTime: const Duration(hours: 6, minutes: 29)),
  DailyRecord(
      recordDate: dayShift(7),
      moodLevel: 1,
      howWasYourDay: "ดูพี่เอก",
      sleepTime: const Duration(hours: 6, minutes: 28)),
  DailyRecord(
      recordDate: dayShift(6),
      moodLevel: 8,
      howWasYourDay: "ดูพี่ตัง",
      sleepTime: const Duration(hours: 6, minutes: 34)),
  DailyRecord(
      recordDate: dayShift(8),
      moodLevel: 9,
      howWasYourDay: "ดูชาร์กแท้ง",
      sleepTime: const Duration(hours: 6, minutes: 27)),
  DailyRecord(
      recordDate: dayShift(10),
      moodLevel: 10,
      howWasYourDay: "ดูพรีิวิวละมุด",
      sleepTime: const Duration(hours: 6, minutes: 27)),
]);
