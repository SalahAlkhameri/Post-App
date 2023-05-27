
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:widespace_project/src/features/auth/view/sign_up.dart';

import '../controllers/signIn_controller.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _LoginState();
}

class _LoginState extends State<SignIn> {

  String? myString = Get.arguments;
  // String? myEmail = storage.read("emailStorage");
  // String? myString = "salahalkhameri@gmail.com";

  String? email;
  String? password;
  String emailText = 'Email doesn\'t match';
  String passwordText = 'Password doesn\'t match';
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userViewModel = Get.put(SignController());
  final _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          // backgroundColor: Theme.of(context).colorScheme.background,
          body: Obx(() =>LoadingOverlay(
                isLoading: userViewModel.isLoading.value,
                color: Colors.blueAccent,
                child: Center(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Sign in',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                            ),
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [

                                TextFormField(
                                  controller: myString == "" ? emailController : TextEditingController(text: myString),
                                  validator: (value) => value!.isEmpty
                                      ? null
                                      : "Please enter a valid email",
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    hintText: 'Enter your email',
                                    prefixIcon  : const Icon(Icons.email),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    return null;
                                  },
                                  maxLines: 1,
                                  controller: passwordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.lock),
                                    hintText: 'Enter your password',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  height: 20,
                                ),

                                ElevatedButton(
                                  onPressed: () async{
                                    // if (_formKey.currentState!.validate()) {}
                                    if((emailController.text != "" && passwordController.text != "") || (TextEditingController !="" && passwordController.text != "")) {
                                      String? email = emailController.text == "" ? myString : emailController.text;
                                      await userViewModel.signIn(email!,
                                          passwordController.text);
                                      print(passwordController.text);
                                      print(email);
                                      print("emailController.text = "+email);
                                      print("myString = "+myString!);
                                    }else{
                                      Get.snackbar("", "قم بلمئ كل البيانات لتسجيل الدخول",
                                          snackPosition: SnackPosition.BOTTOM,
                                          colorText: Colors.white,backgroundColor: Colors.red);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                                  ),
                                  child: const Text(
                                    'Sign in',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  height: 20,
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('Not registered yet?'),
                                    TextButton(
                                      onPressed: () {
                                        Get.to(SignUP());
                                      },
                                      child: const Text('Create an account'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),),),
    );
  }
}
