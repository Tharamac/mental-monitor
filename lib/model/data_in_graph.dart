import 'package:mental_monitor/model/core/datetime_expansion.dart';

class DataInGraph {
  late final int dayRange;
  late final List<MapEntry<DateTime, int>> processData;

  DataInGraph(Map<DateTime, int> data) {
    if (data.isEmpty) {
      dayRange = 0;
      processData = data.entries.toList();
      return;
    }
    var actualRange =
        DateTime.now().dateOnly.difference(data.keys.first).inDays;
    if (actualRange > 30) {
      dayRange = 30;
      processData = data.entries
          .where((element) =>
              DateTime.now().dateOnly.difference(element.key).inDays < 30)
          .toList();
    } else {
      dayRange = actualRange;
      processData = data.entries.toList();
    }
  }
}
