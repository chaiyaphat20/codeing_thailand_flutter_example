import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app1/models/product_model.dart';
import 'package:flutter_app1/widgets/menu.dart';
import 'package:get/get.dart';

//api
import 'dart:convert'; //ไว้ encode และ decode JSON จาก JSON เป็น dart และ dart เป้น JSON
import 'package:http/http.dart' as http; //like axios

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  //api
  List<Data> data = [];
  bool isLoading = true;

  Future<void> getData() async {
    try {
      var response = await http
          .get(Uri.parse('https://api.codingthailand.com/api/course'));
      // print(response.body);  response.body จะเป็น string
      if (response.statusCode == 200 || response.statusCode == 201) {
        var product = Products.fromJson(
            jsonDecode(response.body)); //ต้องแปลงจาก string เป้น Map ก่อน
        setState(() {
          data = product.data;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        //error 400,404,401,500
      }
    } catch (err) {
      print('Caught error: $err');
    }
  }
  //api

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Menu(),
      appBar: AppBar(
        title: const Text("สินค้า"),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
              itemBuilder: (ctx, index) {
                return ListTile(
                  onTap: () {
                    Get.toNamed('/detail', arguments: {
                      'id': data[index].id,
                      'title': data[index].title,
                    });
                  },
                  leading: ConstrainedBox(
                    constraints: const BoxConstraints(
                        minHeight: 80,
                        maxHeight: 80,
                        maxWidth: 80,
                        minWidth: 80),
                    child: Image.network(
                      data[index].picture,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(data[index].title),
                  subtitle: Text(data[index].detail),
                  trailing: Chip(label: Text("${data[index].view}")),
                );
              },
              separatorBuilder: (ctx, index) => const Divider(),
              itemCount: data.length),
    );
  }
}
