import 'package:flutter/material.dart';
import 'package:flutter_app1/pages/about_page.dart';
import 'package:flutter_app1/pages/camera_page.dart';
import 'package:flutter_app1/pages/detail_page.dart';
import 'package:flutter_app1/pages/home_page.dart';
import 'package:flutter_app1/pages/login_page.dart';
import 'package:flutter_app1/pages/map_page.dart';
import 'package:flutter_app1/pages/news_page.dart';
import 'package:flutter_app1/pages/products_page.dart';
import 'package:flutter_app1/pages/website_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? token;

Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //ถ้าเขียน code ที่ main ต้องชัวร์ว่า initialize
  await dotenv.load(fileName: ".env"); //call env
  SharedPreferences prep = await SharedPreferences.getInstance();

  token = prep.getString('token');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        canvasColor: Colors.pink[100],
        textTheme: const TextTheme(
          headline4: TextStyle(color: Color.fromARGB(255, 80, 223, 41)),
        ),
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,

      //setup route
      initialRoute: '/first',
      getPages: [
        GetPage(
            name: '/first',
            page: () => token == null ? const LoginPage() : const HomePage()),
        GetPage(name: '/login', page: () => const LoginPage()),
        GetPage(
            name: '/home',
            page: () => const HomePage(),
            transition: Transition.noTransition),
        GetPage(name: '/about', page: () => const AboutPage()),
        GetPage(name: '/products', page: () => const ProductPage()),
        GetPage(
          name: '/detail',
          page: () => const DetailPage(),
        ),
        GetPage(
          name: '/news',
          page: () => const NewsPage(),
        ),
        GetPage(
          name: '/website',
          page: () => const WebsitePage(),
        ),
        GetPage(
          name: '/camera',
          page: () => const CameraPage(),
        ),
        GetPage(
          name: '/map',
          page: () => const MapPage(),
        ),
      ],
    );
  }
}
