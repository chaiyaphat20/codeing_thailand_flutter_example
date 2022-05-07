import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app1/controllers/profile_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.purple[100],
      child: ListView(
        children: [
          GetX<ProfileController>(
              init: ProfileController(),
              builder: (_) {
                return UserAccountsDrawerHeader(
                  currentAccountPicture: const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/me.png'),
                  ),
                  accountName: Text('ยินดีต้อนรับ ${_.profile['name']}'),
                  accountEmail:
                      Text('${_.profile['email']} ID: ${_.profile['id']}'),
                );
              }),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('หน้าหลัก'),
            onTap: () {
              Get.offNamedUntil('/home', (route) => false);
            },
          ),
          ListTile(
            leading: const Icon(Icons.production_quantity_limits),
            title: const Text('สิ้นค้า'),
            onTap: () {
              Get.offNamedUntil('/products', (route) => false);
            },
          )
        ],
      ),
    );
  }
}
