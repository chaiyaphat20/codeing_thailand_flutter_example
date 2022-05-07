import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/images/me.png'),
              ),
              accountName: Text('ยินดีต้อนรับคุณ Art'),
              accountEmail: Text('Art@gmail.com')),
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
