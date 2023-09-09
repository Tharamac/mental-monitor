import 'package:dartz/dartz.dart' hide State;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_monitor/blocs/user/user_bloc.dart';
import 'package:mental_monitor/pages/home_page.dart';
import 'package:mental_monitor/widgets/line_chart_widget.dart';
import 'package:mental_monitor/widgets/zoomable_chart.dart';

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
                        // context
                        //     .read<UserSessionBloc>()
                        //     .add(RegisterUserEvent(controller.text));
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (builder) => HomePage(
                                currentUserData: left(controller.text))));
                      },
                      child: Text("เริ่มใช้งาน")),
                ),
              ],
            )),
      ),
    );
  }
}
