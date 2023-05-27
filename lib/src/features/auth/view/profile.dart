import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../common_widgets/components.dart';
import '../controllers/user_controller.dart';
import 'update_profile.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final storage = GetStorage();

  UserController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    String? myEmail = storage.read("emailStorage");
    String? myName = storage.read("nameStorage");
    String img = storage.read("imageStorage");
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(), icon: const Icon(LineAwesomeIcons.angle_left)),
        title: const Center(
            child: Text(
          "Profile",
        )),
        actions: [
          IconButton(
          onPressed: controller.changeTheme,
              icon: Obx(() => Icon(controller.icon.value)),)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                InkWell(
                  onTap: (){
                    print(img);
                    print("222-----------22222222222----------");
                    Get.to(() => UpdateProfile());
                  },
                  child: Container(
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black
                      ),
                    ),
                    child:  img.isNotEmpty  ?
                           const CircleAvatar(
                            radius: 50.0,
                            backgroundImage: NetworkImage("img"),
                          ) :
                           Icon(Icons.person ,size: 120,)
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
                      LineAwesomeIcons.alternate_pencil,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              myName!,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              myEmail!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(UpdateProfile());
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
            const SizedBox(
              height: 30,
            ),
            const Divider(),

            //Menu
            ProfileMenuWidget(
              title: "Setting",
              icon: LineAwesomeIcons.cog,
              onPress: () {},
            ),
            ProfileMenuWidget(
              title: "Information",
              icon: LineAwesomeIcons.info,
              onPress: () {},
            ),
            ProfileMenuWidget(
              title: "More App",
              icon: LineAwesomeIcons.google_play,
              onPress: () {},
            ),
            ProfileMenuWidget(
              title: "Share App",
              icon: LineAwesomeIcons.share,
              onPress: () {},
            ),
            ProfileMenuWidget(
              title: "Logout",
              icon: LineAwesomeIcons.alternate_sign_in,
              onPress: () {},
              textColor: Colors.red,
              endIcon: false,
            ),
          ],
        ),
      ),
    );
  }
}
