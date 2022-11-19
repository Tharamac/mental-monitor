import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mental_monitor/widgets/menu_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          "วันนี้คุณเป็นยังไงบ้าง",
          // style: GoogleFonts.ibmPlexSansThai(),
        ),
      ),
      drawer: MainMenuDrawerWidget(),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Text(
              "บันทึกของวันนี้",
              style: GoogleFonts.ibmPlexSansThai(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Card(
              color: Colors.blueGrey[200],
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "วันที่ 30 พฤศจิกายน พ.ศ.2565",
                      style: GoogleFonts.ibmPlexSansThai(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "วันนี้ยังไม่ได้บันทึกสถานะ กดเพื่อบันทึกเลย",
                      style: GoogleFonts.ibmPlexSansThai(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              color: Colors.lightBlue[500],
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                              TextSpan(text: 'บันทึกเมื่อ 17:50น.'),
                            ],
                          ),
                        ),
                        // Container(
                        //   padding: EdgeInsets.all(16),
                        //   alignment: Alignment.center,
                        //   decoration: BoxDecoration(color: Colors.green[800], shape: BoxShape.circle),
                        //   child: Text(
                        //     "7",
                        //     style: GoogleFonts.ibmPlexSansThai(
                        //       fontSize: 20,
                        //       fontWeight: FontWeight.w600,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    RichText(
                      textHeightBehavior: TextHeightBehavior(),
                      text: TextSpan(
                        style: GoogleFonts.ibmPlexSansThai(
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          WidgetSpan(child: Icon(Icons.hotel)),
                          TextSpan(text: '  7ชม. 18น.'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
