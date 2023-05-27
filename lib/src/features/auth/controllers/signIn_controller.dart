

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/home.dart';

class SignController extends GetxController{

  var isLoading = false.obs;

  Future<void> signIn(String email, String password) async {
    isLoading.value = true;
    try {
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('users')
          .where('gmail', isEqualTo: email)
          .where('password', isEqualTo: password)
          .limit(1)
          .get();

      if (result.docs.isNotEmpty) {
        isLoading.value = false;
        print('تم تسجيل الدخول بنجاح. $email');
        Get.snackbar("",
            "تم تسجيل الدخول بنجاح.",
            colorText: Colors.white, backgroundColor: Colors.green);
        Get.offAll(Home());
      } else {
        isLoading.value = false;
        Get.snackbar("",
            "البريد الإلكتروني أو كلمة المرور غير صحيحة.",
            colorText: Colors.white, backgroundColor: Colors.red);
        print('البريد الإلكتروني أو كلمة المرور غير صحيحة.');
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("",
          "لايوجد إتصال بلإنترنت",
          colorText: Colors.white, backgroundColor: Colors.red);
      print(e);
    }
  }


}