
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:widespace_project/src/features/auth/view/signin.dart';
import '../controllers/user_controller.dart';

class SignUP extends StatefulWidget {
  const SignUP({Key? key}) : super(key: key);

  @override
  State<SignUP> createState() => _AddUserState();
}

class _AddUserState extends State<SignUP> {

  final nameController = TextEditingController();
  final gmailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final userViewModel = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Theme.of(context).colorScheme.background,
        body: Obx(() => LoadingOverlay(
          isLoading: userViewModel.isLoading.value,
          child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 const Text(
                    'Sign up',
                    style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  Form(
                    key: _formKey,
                    child: Column(
                      children: [

                        TextFormField(
                          controller: nameController,
                          validator: (value) => value!.isEmpty
                              ? null
                              : "Please enter a valid email",
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: 'First name',
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        TextFormField(
                          controller: gmailController,
                          validator: (value) => value!.isEmpty
                              ? null
                              : "Please enter a valid email",
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Enter your email',
                            prefixIcon: const Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          maxLines: 1,
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            hintText: 'Enter your password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),

                        SizedBox(height: 20,),


                        ElevatedButton(
                          onPressed: () {
                            // if (_formKey.currentState!.validate()) {}
                            if(nameController.text != "" && gmailController.text != "" && passwordController.text != "")
                            {
                              userViewModel.addUser(
                                  nameController.text,
                                  gmailController.text,
                                  passwordController.text
                              );

                            }else{
                              Get.snackbar("Form validation", "Please fill all the field and try again",
                                  colorText: Colors.white,backgroundColor: Colors.red);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                          ),
                          child: const Text(
                            'Sign up',
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
                            const Text('Already registered?'),
                            TextButton(
                              onPressed: () {
                                Get.to(SignIn());
                              },
                              child: const Text('Sign in'),
                            ),
                          ],
                        )

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),),
        )),
      ),
    );
  }
}














