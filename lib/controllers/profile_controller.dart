import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  RxMap<dynamic, dynamic> profile = {}.obs;

  Future<void> getProfile() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    profile.value = jsonDecode(pref.getString('profile')!);
  }

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }
}
