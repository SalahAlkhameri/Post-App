




import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.blue[100],
        ),
        child: Icon(icon, color: Colors.blue),
      ),
      title: Text(title, style: Theme.of(context).textTheme.bodyLarge?.apply(color: textColor)),
      trailing: endIcon ? Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.grey.withOpacity(0.1),
        ),
        child: const Icon(
          LineAwesomeIcons.angle_right,
          size: 18.0,
          color: Colors.grey,
        ),
      ) : null,
    );
  }
}

class DefaultTextForm extends StatelessWidget {
  DefaultTextForm({
    super.key,
    required this.label,
    required this.icon,
    this.controller,
  });

  final String label;
  TextEditingController? controller;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // initialValue: initVal,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        // floatingLabelStyle: TextStyle(),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}