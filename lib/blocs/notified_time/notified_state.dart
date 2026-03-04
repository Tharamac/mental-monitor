import 'package:flutter/material.dart';

abstract class NotifiedTimeState {
  late final TimeOfDay notifiedTime;
  @override
  NotifiedTimeState(this.notifiedTime);
}

class NotifiedTimeInitState extends NotifiedTimeState {
  NotifiedTimeInitState() : super(TimeOfDay(hour: 19, minute: 00));
}

class NotifiedTimeSetState extends NotifiedTimeState {
  NotifiedTimeSetState(TimeOfDay time) : super(time);
}
