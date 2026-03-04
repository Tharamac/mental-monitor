import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_monitor/blocs/user/user_bloc.dart';
import 'package:mental_monitor/pages/home_page.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({Key? key}) : super(key: key);
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.all(16),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("กรอกชื่อเล่น"),
                TextField(
                  controller: controller,
                ),
                SizedBox(
                  height: 12,
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        print(controller.text);
                        // context
                        //     .read<UserBloc>()
                        //     .add(RegisterUserEvent(controller.text));

                        // Navigator.of(context).push(MaterialPageRoute(builder: (builder) => HomePage()));
                      },
                      child: Text("เริ่มใช้งาน")),
                ),
                Divider(),
                Center(
                    child: TextButton(
                        onPressed: () {}, child: Text("ดึงข้อมูลผู้ใช้เก่า")))
              ],
            )),
      ),
    );
  }
}
