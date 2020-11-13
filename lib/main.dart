import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hero_of_the_storm/service/db_service.dart';
import 'package:logger/logger.dart';
// import 'package:hive/hive.dart';
// import 'package:path_provider/path_provider.dart';

import 'Pages/tab6.dart';
import 'models/hero.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final appDocumentDirectory = await getApplicationDocumentsDirectory();
  // Hive.init(appDocumentDirectory.path);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Heroes of the storm'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  Future<List<Heroes>> callApiGetHeroes() async {
    var dio = Dio();
    var lg = Logger();
    lg.i('start call hotsAPI.net');
    var resp = await dio.get('http://hotsapi.net/api/v1/heroes');
    List<Heroes> kq = List<Heroes>();
    for (var r in resp.data) {
      var item = Heroes.fromMap(r);
      lg.i('in ra item: ${item.toJson()}');
      kq.add(item);
      DbService().addHeroes(item);
    }
    // print('added 1 hero');
    return kq;
    // return resp.data;
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return MaterialApp(
      home: DefaultTabController(
        length: 6,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.car_rental)),
                Tab(icon: Icon(Icons.trending_neutral)),
                Tab(icon: Icon(Icons.face)),
                Tab(icon: Icon(Icons.gamepad)),
                Tab(icon: Icon(Icons.bike_scooter)),
                Tab(icon: Icon(Icons.train)),
              ],
            ),
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Center(child: Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),)),
          ),
          body: TabBarView(children: [
            Text("tab1"),
            Text("tab2"),
            Text("tab3"),
            Text("tab4"),
            Text("tab5"),
            Tab6(counter: _counter),
          ]),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: () async {
                  // var ppp =
                  await DbService().getFirstHeroInDb();
                  // print('${ppp.name}');
                },
                tooltip: 'GetDB',
                child: Icon(Icons.account_balance_sharp),
              ),
              SizedBox(
                height: 20,
              ),
              FloatingActionButton(
                onPressed: () {
                  _incrementCounter();
                  callApiGetHeroes();
                },
                tooltip: 'Increment',
                child: Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


