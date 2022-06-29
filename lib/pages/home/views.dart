import 'package:earistapp/pages/config/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get_connect.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'dart:ui' as ui;

var buildingLabel ='';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List tiles = [];

  static String BASE_URL_CATEGORY = '' + Global.url + '/building/';

  void getData() async {
    var c = 0;
    final response = await http.get(Uri.parse(BASE_URL_CATEGORY),
        headers: {"Content-Type": "application/json"});
    String jsonsDataString = response.body.toString();
    final _data = jsonDecode(jsonsDataString);
    for (var a in _data) {
      tiles.add({"label": c, "column": []});
      for (var i in jsonDecode(a['tiles'])) {
        tiles[c]['column'].add(i);
      }
      c++;
    }
    print(tiles);
    setState(() {});
    // print(_data);
  }
  @override
  void paint(Canvas canvas, Size size) {
  final p1 = Offset(50, 50);
  final p2 = Offset(250, 150);
  final paint = Paint()
    ..color = Colors.black
    ..strokeWidth = 4;
  canvas.drawLine(p1, p2, paint);
}
  @override
  void initState() {
    super.initState();
    getData();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  List text = ['', '', '', '', '', ''];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor:Color(0xff404040),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('EARIST',style:TextStyle(color: Color(0xffffff00))),
              IconButton(onPressed: (){
                Get.toNamed('/search');
              }, icon: Icon(Icons.search)),
              //     IconButton(onPressed: (){
              //   Get.toNamed('/test');
              // }, icon: Icon(Icons.search))
            ],
          ),
        ),
        body: ListView(
          children: [
            Container(
              padding:EdgeInsets.only(bottom:120),
            height:750,
            width: 750,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/NEW_2.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
              children: [
                CustomPaint( //                       <-- CustomPaint widget
        size: Size(10, 10),
        painter: MyPainter(),
      ),
                for (var i in tiles)
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          for (var b in i['column'])
                            Container(
                              height: 120,
                              width: 145,
                              child: InkWell(
                                onTap: (){
                                  if(b['label']=='') return;
                                  // Navigator.pop(context);
                                  Get.toNamed('/room',arguments: [b['label'].toString(),b['floor'].toString()]);
                                },
                                child:  Card(
                                  color:Colors.transparent,
                                  elevation: 0,
                                  
                                  // color: Color(0xffc6782b),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.white70, width: 1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  margin: EdgeInsets.all(20.0),
                                  child: Container(
                                    // width: 150,
                                    // height: 185,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text("${b['label']}"),
                                        Padding(padding: EdgeInsets.only(top:40)),
                                        // Image.network('https://project12mac.s3.ap-northeast-2.amazonaws.com/${b['image'].toString()}',fit: BoxFit.cover,),

                                        Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 15))
                                      ],
                                    ),
                                  )),
                              )
                            ),
                            Spacer(), 
                        ],
                      ),

                    ],
                  )
              ],
            ))
          ],
        ));
  }
}
class MyPainter extends CustomPainter { //         <-- CustomPainter class
  @override
  void paint(Canvas canvas, Size size) {
  final pointMode = ui.PointMode.polygon;
  // library
  // final points = [
  //   Offset(-320, 550),
  //   Offset(-100, 550),
  //   Offset(-100, 440),
  //  Offset(-100, 440),
  //   Offset(-30, 440),
  //  Offset(-30, 450),
  // ];

  //old science building
  //  final points = [
  //   Offset(-320, 550),
  //   Offset(-295, 550),
  //    Offset(-295, 470),
  // Offset(-205, 470),
  //  Offset(-205, 480),
  // //  Offset(-30, 450),
  // ];


//highschool
  //  final points = [
  //   Offset(-320, 550),
  //   Offset(-295, 550),
  //    Offset(-295, 400),
  //  Offset(-255, 320),
  //    Offset(-240, 320),
  //  Offset(-240, 260),
  //  Offset(-190, 140),
  // ];

  //nudas and regala
  //  final points = [
  //   Offset(-320, 550),
  //   Offset(-295, 550),
  //    Offset(-295, 400),
  //  Offset(-255, 320),
  //    Offset(-240, 320),
  //  Offset(-240, 260),
  //  Offset(-190, 140),
  //  Offset(-90, 180),
  // ];


  //appilado hall
  // final points = [
  //   Offset(-320, 550),
  //   Offset(-295, 550),
  //    Offset(-295, 400),
  //  Offset(-255, 320),
  //    Offset(-240, 320),
  //  Offset(-240, 260),
  //  Offset(-220, 190),
  //  Offset(-230, 190),
  // ];

  //engineering hall
  // final points = [
  //   Offset(-320, 550),
  //   Offset(-295, 550),
  //    Offset(-295, 400),
  //  Offset(-255, 320),
  //    Offset(-240, 320),
  //  Offset(-240, 260),
  //  Offset(-220, 190),
  //  Offset(-230, 190),
  // ];


   // library
  final points = [
    Offset(-320, 550),
    Offset(-100, 550),
    Offset(-100, 440),
   Offset(-100, 440),
    Offset(30, 180),
      Offset(70, 180),
  ];
  
  final paint = Paint()
    ..color = Colors.black
    ..strokeWidth = 4
    ..strokeCap = StrokeCap.round;
  canvas.drawPoints(pointMode, points, paint);
}

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}