import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Text("คุณชื่อ"),
        TextFormField(),
        Text("นามสกุล"),
        TextFormField(),
        ElevatedButton(onPressed: () {}, child: Text("เริ่มใช้งาน")),
        Divider(),
        ElevatedButton(onPressed: () {}, child: Text("ดึงข้อมูลผู้ใช้เก่า"))
      ],
    ));
  }
}
