import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app1/models/login/login_body.dart';
import 'package:flutter_app1/models/login/login_response.dart';
import 'package:flutter_app1/models/profile/profile_response.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String baseUrl = dotenv.get('BASE_URL', fallback: 'Default fallback value');
  final _formKey = GlobalKey<FormBuilderState>();

  Future<void> getProfile(http.Response response) async {
    var dataLogin = LoginResponse.fromJson(jsonDecode(response.body));

    //save token data to sharedPrep
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setString('token', response.body);

    //get profile
    var profileUrl = Uri.parse('$baseUrl/profile');
    var responseProfile = await http.get(profileUrl,
        headers: {'Authorization': 'Bearer ${dataLogin.accessToken}'});
    if (responseProfile.statusCode == 200) {
      var profile =
          GetProfileResponse.fromJson(jsonDecode(responseProfile.body));
      //save profile to  sharedPrep
      await _pref.setString('profile', jsonEncode(profile.data.user));

      //go to home page
      Get.offNamedUntil('/home', (route) => false);
    } else {
      Map<String, dynamic> msgError = json.decode(responseProfile.body);
      Get.snackbar(
        'Error',
        msgError['message'],
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[200],
        icon: const Icon(Icons.error_outline),
      );
    }
  }

  Future<void> login(Map<dynamic, dynamic> fromValue) async {
    try {
      http.Response responseLogin = await http.post(Uri.parse('$baseUrl/login'),
          body: LoginBody(
                  email: fromValue['email'], password: fromValue['password'])
              .toJson());
      if (responseLogin.statusCode == 200) {
        //get Profile and save Shared prep
        getProfile(responseLogin);
      } else {
        Map<String, dynamic> msgError = json.decode(responseLogin.body);
        Get.snackbar('Error', msgError['message'],
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red[200],
            icon: const Icon(Icons.error_outline));
      }
    } catch (e) {
      log('$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomLeft)),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const FlutterLogo(
                    size: 90,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                        child: Column(
                          children: [
                            FormBuilder(
                              key: _formKey,
                              initialValue: const {'email': '', 'password': ''},
                              autovalidateMode: AutovalidateMode.always,
                              child: Column(
                                children: [
                                  FormBuilderTextField(
                                    name: 'email',
                                    maxLines: 1,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      hintText: 'Email',
                                      filled: true,
                                      fillColor: Colors.white70,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(
                                          errorText: 'ป้อนข้อมูล Email ด้วย'),
                                      FormBuilderValidators.email(
                                          errorText: 'กรอก Email ให้ถูก Type')
                                    ]),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  FormBuilderTextField(
                                    name: 'password',
                                    maxLines: 1,
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      hintText: 'Password',
                                      filled: true,
                                      fillColor: Colors.white70,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(
                                          errorText:
                                              'ป้อนข้อมูล Password ด้วย'),
                                      FormBuilderValidators.minLength(3,
                                          errorText:
                                              'Password ต้องไม่นิ้อบกว่า 3 ')
                                    ]),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: MaterialButton(
                                    onPressed: () {
                                      _formKey.currentState!.save();
                                      if (_formKey.currentState!.validate()) {
                                        login(_formKey.currentState!.value);
                                      } else {
                                        // print("validation failed");
                                      }
                                    },
                                    color: Colors.purple,
                                    textColor: Colors.white,
                                    child: const Text(
                                      'เข้าสู่ระบบ',
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: TextButton(
                                        onPressed: () {},
                                        child: Text('ลืมรหัสผ่าน'))),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
