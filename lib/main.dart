import 'package:earistapp/pages/floor/views.dart';
import 'package:earistapp/pages/home/views.dart';
import 'package:earistapp/pages/room/views.dart';
import 'package:earistapp/pages/search/views.dart';
import 'package:earistapp/pages/search_floor/views.dart';
import 'package:earistapp/pages/search_room/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() async{
 
 WidgetsFlutterBinding.ensureInitialized();
  
      runApp(new MyApp());
 
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
     SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
//ensures portrait at all times. you can override this if necessary
      ]);
    return GetMaterialApp(
      title: 'Flutter',
      theme: ThemeData(
      ),
      getPages: [
        GetPage(name: "/starting", page:()=>Home()),
        GetPage(name: "/room", page:()=>Room()),
        GetPage(name: "/floor", page:()=>Floor()),
        GetPage(name: "/search", page:()=>Search()),
        GetPage(name: "/room_searched", page:()=>SearchFloor()),
        GetPage(name: "/search_room", page:()=>SearchRoom()),
        
        // GetPage(name: "/mappages", page:()=>TestMapPolyline()),
        // GetPage(name: "/signup", page:()=>SignUp()),
        // GetPage(name: "/profile", page:()=>Profile()),
        // GetPage(name: "/resetPassword", page:()=>ResetPassword()),
        // GetPage(name: "/receiptList", page:()=>receiptList()),
        // GetPage(name: "/receipt", page:()=>receipt()),
        // GetPage(name: "/products", page:()=>Products()),
        // GetPage(name: "/cart", page:()=>Cart()),
        // GetPage(name: "/favorites", page:()=>Favorites()),
        // GetPage(name: "/product_details", page:()=>ProductDetails()),
      ],
      initialRoute: "/starting",
    );
  }
}
