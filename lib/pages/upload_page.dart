import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  Map<String, dynamic> imagePath = {};

  @override
  void initState() {
    super.initState();
    imagePath = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload"),
      ),
      body: Image.file(
        File(imagePath['path']),
        fit: BoxFit.fill,
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //convert image to base64
          final bytes = await File(imagePath['path']).readAsBytes();
          var base64Image = base64Encode(bytes);

          //upload to server
          try {
            var url = Uri.parse('https://api.codingthailand.local/api/upload');
            var response = await http.post(
              url,
              headers: {'Content-Type': 'application/json'},
              body: json
                  .encode({'picture': 'data:image/jpeg;base64,' + base64Image}),
            );
            if (response.statusCode == 200) {
              var feedback = jsonDecode(response.body);
              Get.snackbar('${feedback['data']['message']}',
                  '${feedback['data']['url']}',
                  backgroundColor: Colors.green);
              print(feedback['data']['url']);
              Future.delayed(const Duration(seconds: 3), () {
                Get.back(closeOverlays: true);
              });
            } else {
              print("Upload Fail");
            }
          } catch (e) {
            print("$e");
          }
        },
        child: const Icon(Icons.upload),
      ),
    );
  }
}
