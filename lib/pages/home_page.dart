import 'package:flutter/material.dart';
import 'package:flutter_app1/controllers/profile_controller.dart';
import 'package:flutter_app1/widgets/menu.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('token');
    await pref.remove('profile');
    Get.offNamedUntil('/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    var _or = MediaQuery.of(context).orientation;
    return Scaffold(
        drawer: const Menu(),
        appBar: AppBar(
          title: Image.asset(
            'assets/images/cct_logo.png',
            height: 40,
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  logout();
                },
                icon: const Icon(Icons.exit_to_app_rounded))
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: Column(
              children: [
                GetX<ProfileController>(
                  init: ProfileController(),
                  builder: (_) {
                    return (Text("สวัสดี นาย ${_.profile['name']} "));
                  },
                ),
                GetX<ProfileController>(
                  init: ProfileController(),
                  builder: (_) {
                    return (Text("Role: ${_.profile['role']} "));
                  },
                ),
              ],
            )),
            Expanded(
              flex: 9,
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: _or == Orientation.portrait ? 2 : 3,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Get.toNamed('/about');
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.person,
                          size: 70,
                        ),
                        Text('เกี่ยวกับเรา')
                      ],
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.purple[100])),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Get.toNamed('/news');
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.newspaper,
                          size: 70,
                        ),
                        Text('ข่าวสาร')
                      ],
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.purple[100])),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Get.toNamed('/camera');
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.camera,
                          size: 70,
                        ),
                        Text('ถ่ายรูป')
                      ],
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.purple[100])),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Get.toNamed('/map');
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.map,
                          size: 70,
                        ),
                        Text('แผนที่')
                      ],
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.purple[100])),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
//https://github.com/jonataslaw/getx/blob/master/documentation/en_US/route_management.md
