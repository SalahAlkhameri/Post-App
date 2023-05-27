import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:widespace_project/src/features/auth/controllers/user_controller.dart';
import 'package:widespace_project/src/features/auth/view/profile.dart';
import 'package:widespace_project/src/features/auth/view/sign_up.dart';

import 'firebase_options.dart';
import 'src/features/auth/view/home.dart';

void main() async{
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(UserController());
  runApp(const MyApp());

}

ColorScheme defaultColorScheme = const ColorScheme(
  primary: Color(0xff1a5276),
  // secondary: Color(0xff03DAC6),
  secondary: Color(0xff1a5276),
  surface: Color(0xff181818),
  background: Color(0xff121212),
  error: Color(0xffCF6679),
  onPrimary: Color(0xffffffff),
  onSecondary: Color(0xff000000),
  onSurface: Color(0xffffffff),
  onBackground: Color(0xffffffff),
  onError: Color(0xff000000),
  brightness: Brightness.light,
);


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find();
    final storage = GetStorage();
    userController.darkModeEnabled.value = storage.read('darkModeEnabled') ?? (ThemeMode.system == ThemeMode.dark);
    storage.write("imageStorage", "");

    return GetMaterialApp(
      title: 'WideSpace',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: defaultColorScheme,
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: userController.darkModeEnabled.value ? ThemeMode.dark : ThemeMode.light,
      home: Profile(),
    );
  }
}
