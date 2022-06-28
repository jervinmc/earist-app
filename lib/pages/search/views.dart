import 'package:earistapp/pages/config/global.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get_connect.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
class Search extends StatefulWidget {
  const Search({ Key? key }) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
    List tiles = [];
    var building_indicator = '';
    var floor_indicator = '';
    var label_indicator = '';
    static String BASE_URL_CATEGORY = '' + Global.url + '/building/';
    static String BASE_URL = '' + Global.url + '/room';
  TextEditingController _search = new TextEditingController();
   void getData() async {
    var c = 0;
    
    final response1 = await http.get(Uri.parse(BASE_URL+'?search="${_search.text}"'),
        headers: {"Content-Type": "application/json"});
          String jsonsDataString1 = response1.body.toString();
    final _data1 = jsonDecode(jsonsDataString1);
    // print(jsonDecode(_data1[0]));
    final response = await http.get(Uri.parse(BASE_URL_CATEGORY),
        headers: {"Content-Type": "application/json"});
    String jsonsDataString = response.body.toString();
    final _data = jsonDecode(jsonsDataString);
    building_indicator = _data1[0]['building_name'];
   floor_indicator = _data1[0]['floor'];
   label_indicator = jsonDecode(_data1[0]['tiles'])[0]['label'];
   print(label_indicator);
    print(_data1[0]);
    for (var a in _data) {
      tiles.add({"label": c, "column": []});
      for (var i in jsonDecode(a['tiles'])) {
        tiles[c]['column'].add(i);
      }
      c++;
    }
    setState(() {});
    // print(_data);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          backgroundColor:Color(0xff404040),
          title: Text('Search',style:TextStyle(color: Color(0xffffff00))),
        ),
        body: ListView(
          children: [
            _search.text=='' ? Column(
              children: [
                Container(
                  width: 500,
                          padding: EdgeInsets.only(top: 20),
                          child: TextField(
                            controller: _search,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(8.0),enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey, width: 1.5),
                                       borderRadius: BorderRadius.circular(20.0),
                                  ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                  color: Colors.purple, 
                                    width: 5.0),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                filled: true,
                                hintStyle: TextStyle(color: Colors.grey[800]),
                                hintText: "Search",
                                fillColor: Colors.white70),
                          )
                        ),
                         Container(
                          padding: EdgeInsets.only(top: 15),
                          width: 250,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Color(0xff222f3e)),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                        ))),
                            child: Text('Search'),
                            onPressed: () {
                              getData();
                            },
                          ),
                        ),
              ],
            ) : Container(
              height:700,
          
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/NEW_2.png"),
                    fit: BoxFit.cover,
                  ),
                ),
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
                              padding:EdgeInsets.only(left:10),
                              height: 120,
                              width: 145,
                              child: InkWell(
                                onTap: (){
                                   if(b['label']=='') return;
                                  Get.toNamed('/room_searched',arguments: [b['label'].toString(),b['floor'].toString(),floor_indicator,label_indicator]);
                                },
                                child:  Card(
                                  color:Colors.transparent,
                                  elevation: 0,
                                  // color: Color(0xffc6782b),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.white70, width: 0),
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
                                      b['label']==building_indicator ?  Text("*",style: TextStyle(color:Colors.red),) : Text(''),
                                        // Image.network(b['image'].toString(),fit: BoxFit.cover,height:100,width: 100,),

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
        ),
    );
  }
}