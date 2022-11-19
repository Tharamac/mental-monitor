import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

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
      drawer: Drawer(
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 26, 150, 251),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: FittedBox(
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomRight,
                child: Text(
                  'ทยายสาญุก\nสานพำยบาสั้น',
                  style: GoogleFonts.ibmPlexSansThai(fontWeight: FontWeight.w700, height: 1.5),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
          ),
          // ),
          SizedBox(
            height: 16,
          ),
          Container(
            color: Colors.blue[100],
            padding: const EdgeInsets.only(left: 20.0, top: 12, bottom: 4),
            child: Text(
              "เมนูหลัก",
              style: GoogleFonts.ibmPlexSansThai(
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          // Divider(
          //   height: 7,
          //   thickness: 7,
          //   color: Colors.white,
          // ),
          Expanded(
            flex: 3,
            child: ListView(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                TextButton.icon(
                    onPressed: () {},
                    style: TextButton.styleFrom(alignment: Alignment.centerLeft, minimumSize: Size(200, 60), backgroundColor: Colors.blue[50], padding: EdgeInsets.symmetric(horizontal: 20)),
                    icon: Icon(Icons.email),
                    label: Text(
                      "ส่งข้อมูลไปที่อีเมล์",
                      style: GoogleFonts.ibmPlexSansThai(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                TextButton.icon(
                    onPressed: () {},
                    style: TextButton.styleFrom(alignment: Alignment.centerLeft, minimumSize: Size(200, 60), backgroundColor: Colors.blue[50], padding: EdgeInsets.symmetric(horizontal: 20)),
                    icon: Icon(Icons.backup),
                    label: Text(
                      "สำรองข้อมูล",
                      style: GoogleFonts.ibmPlexSansThai(fontSize: 24, fontWeight: FontWeight.w600),
                    )),
                TextButton.icon(
                    onPressed: () {},
                    style: TextButton.styleFrom(alignment: Alignment.centerLeft, minimumSize: Size(200, 60), backgroundColor: Colors.blue[50], padding: EdgeInsets.symmetric(horizontal: 20)),
                    icon: Icon(Icons.settings),
                    label: Text(
                      "การตั้งค่า",
                      style: GoogleFonts.ibmPlexSansThai(fontSize: 24, fontWeight: FontWeight.w600),
                    )),
              ],
            ),
          ),
        ]),
      ),

      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
