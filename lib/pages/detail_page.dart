import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Map<String, dynamic> products = {};

  Map<String, dynamic> detail = {}; //ตัวแปร รับ JSON จาก Backend

  Future<Map<String, dynamic>>? getDataFuture;
  Future<Map<String, dynamic>> getData(int id) async {
    var response = await http
        .get(Uri.parse('https://api.codingthailand.com/api/course/$id'));
    if (response.statusCode == 200 || response.statusCode == 201) {
      detail = jsonDecode(response.body);
      return detail;
    } else {
      throw Exception('เกิดปัฐหาที่ Server กรุณาลองใหม่');
    }
  }

  @override
  void initState() {
    super.initState();
    products = Get.arguments; //receive data
    getDataFuture = getData(products['id']); //make sure call first times
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(products['title']),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: getDataFuture,
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
                itemBuilder: (ctx, index) {
                  return ListTile(
                    title: Text('${snapshot.data!['data'][index]['ch_title']}'),
                    subtitle:
                        Text('${snapshot.data!['data'][index]['ch_dateadd']}'),
                  );
                },
                separatorBuilder: (ctx, index) {
                  return const Divider();
                },
                itemCount: snapshot.data!['data'].length);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
