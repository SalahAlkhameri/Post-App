


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:widespace_project/src/features/auth/view/profile.dart';
import '../../../common_widgets/components.dart';
import '../../../constants/sizes.dart';
import '../controllers/user_controller.dart';
import '../models/user_model.dart';

class UpdateProfile extends StatelessWidget {
  UpdateProfile({Key? key}) : super(key: key);

  String? myString = Get.arguments;
  String? photo = null;

  final storage = GetStorage();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    // final controller = Get.find();
    UserController controller = Get.find();
    String email = storage.read("emailStorage");
    String? myimage = storage.read("imageStorage");
    // String myimage = "https://w0.peakpx.com/wallpaper/456/570/HD-wallpaper-big-smile-big-black-yellow-smile-abstract.jpg";
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () =>
                Get.back()
              , icon: const Icon(LineAwesomeIcons.angle_left)),
          title: const Center(
              child: Text(
                "Update Profile",
              )),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: FutureBuilder(
              future: controller.getUserDetailes(email),
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.done){
                  if(snapshot.hasData){
                    UserModel userModel = snapshot.data as UserModel;

                    //Controllers
                    final email = TextEditingController(text: userModel.gmail);
                    final password = TextEditingController(text: userModel.password);
                    final name = TextEditingController(text: userModel.name);
                    final phoneNo = TextEditingController(text: userModel.phone);

                    return Column(
                      children: [
                        InkWell(
                          onTap: (){
                            controller.uploadPic(context);
                            // Get.to(Profile());
                          },
                          child: Stack(
                            children: [
                              Container(
                                height: 130,
                                width: 130,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.black
                                  ),
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Obx(() =>  controller.imageFile.value != null ?
                                    // photo != null ?
                                    Image.file(
                                      controller.imageFile.value!,
                                      fit: BoxFit.fill,
                                    )
                                    // Image.network(
                                    //   "https://w0.peakpx.com/wallpaper/456/570/HD-wallpaper-big-smile-big-black-yellow-smile-abstract.jpg",
                                    //   fit: BoxFit.fill,
                                    // )
                                          : Icon(Icons.person ,size: 120,)),
                                  // child:  myimage! != null ?
                                  //     Image.network(myimage)
                                  //  : Icon(Icons.person ,size: 120,),

                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: const Color(0xff1a5276),
                                  ),
                                  child: const Icon(
                                    LineAwesomeIcons.camera,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Form(
                            child: Column(
                              children: [
                                DefaultTextForm(
                                  controller: name,
                                  icon: LineAwesomeIcons.user,
                                  label: 'Full Name',
                                ),
                                const SizedBox(height: tFormHeight - 20),
                                DefaultTextForm(
                                  controller: email,
                                  icon: LineAwesomeIcons.envelope_1,
                                  label: 'E-Mail',
                                ),
                                const SizedBox(height: tFormHeight - 20),
                                DefaultTextForm(
                                  controller: phoneNo,
                                  icon: LineAwesomeIcons.phone,
                                  label: 'Phone No',
                                ),
                                const SizedBox(height: tFormHeight - 20),
                                DefaultTextForm(
                                  controller: password,
                                  icon: LineAwesomeIcons.fingerprint,
                                  label: 'Password',
                                ),
                              ],
                            )
                        ),
                        const SizedBox(height: tFormHeight - 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              // Get.to(UpdateProfile());
                              // controller.getUserrDetails("non@non");
                              var connectivityResult = await Connectivity().checkConnectivity();
                              // final connectivityResult await(Connectivity().checkConnectivity());

                              if (connectivityResult != ConnectivityResult.none) {
                                final userData = UserModel(
                                  gmail: email.text.trim(),
                                  name: name.text.trim(),
                                  phone: phoneNo.text.trim(),
                                  password: password.text.trim(),
                                );
                                await controller.updateUserRecord(userData);
                                await controller.saveImageUrl();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('تم التحديث'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('لا يوجد اتصال بالإنترنت'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }

                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff1a5276),
                                side: BorderSide.none,
                                shape: const StadiumBorder()),
                            child: const Text(
                              "Edite Profile",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    );
                  }else if(snapshot.hasError){
                    print(snapshot.error.toString());
                    print("---------------------------");
                    return Center(child: Text(snapshot.error.toString()),);
                  }else{
                    return const Center(child: Text("Something went wrong"));
                  }


                }else{
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )
            // child:
          ),
        ),
      ),
    );
  }
}


















