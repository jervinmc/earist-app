import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class Room extends StatefulWidget {
  dynamic args = Get.arguments;

  @override
  State<Room> createState() => _RoomState(this.args);
}

class _RoomState extends State<Room> {
  //args[0] = building name
  //args[1] = no. floors

   @override
  void initState() {
    super.initState();
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
  final args;
  _RoomState(this.args);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
           backgroundColor:Color(0xff404040),
          title: Text(args[0],style:TextStyle(color: Color(0xffffff00))),
        ),
        body: ListView(
          children: [
            for (int x=0;x<int.parse(args[1]);x++) Container(
              height:100,
              child: InkWell(
                onTap: (){
                  Get.toNamed('/floor',arguments:[args[0].toString(),(x+1).toString()]);
                },
                child: Card(
                elevation: 4,
                // color: Color(0xffc6782b),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white70, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.all(20.0),
                child: Container(
                  // width: 150,
                  // height: 185,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("${x+1}st Floor",style: TextStyle(fontWeight:FontWeight.bold),),
                      // Image.network(b['image'].toString(),fit: BoxFit.cover,height:100,width: 100,),

                      Padding(padding: EdgeInsets.only(bottom: 15))
                    ],
                  ),
                )),
              )
            )
          ],
        ));
  }
}
