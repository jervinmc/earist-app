import 'package:earistapp/pages/config/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get_connect.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class Floor extends StatefulWidget {
  dynamic args = Get.arguments;

  @override
  State<Floor> createState() => _FloorState(this.args);
}

class _FloorState extends State<Floor> {
  @override
  List tiles = [];
  final args;
  _FloorState(this.args);
  static String BASE_URL_CATEGORY = '' + Global.url + '/room-building';

  void getData() async {
    var c = 0;
    final response = await http.get(
        Uri.parse(
            BASE_URL_CATEGORY + '?building_name=${args[0]}&floor=${args[1]}'),
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
  void initState() {
    super.initState();
    getData();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  // dispose() {
  //   SystemChrome.setPreferredOrientations([
  //     DeviceOrientation.landscapeRight,
  //     DeviceOrientation.landscapeLeft,
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.portraitDown,
  //   ]);
  //   super.dispose();
  // }

  List text = ['', '', '', '', '', ''];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff404040),
          title: Text("Building - ${args[0]}, Floor - ${args[1]}",
              style: TextStyle(color: Color(0xffffff00))),
        ),
        body: ListView(
          children: [
            Container(
                child: Column(
              children: [
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
                                  onTap: () {
                                    Get.toNamed('/room', arguments: [
                                      b['label'].toString(),
                                      b['floor'].toString()
                                    ]);
                                  },
                                  child: Card(
                                      elevation: 4,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text("${b['label']}"),
                                            // Image.network(b['image'].toString(),fit: BoxFit.cover,height:100,width: 100,),

                                            Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 15))
                                          ],
                                        ),
                                      )),
                                )),
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
