



import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductException{

  final String message;
  ProductException(this.message);

  void addError(BuildContext context, String errorMessage){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(errorMessage),
          actions: [
            ElevatedButton(
              child: Text('OK'),
            onPressed: () {
             Get.off(context);
             },
            ),
          ],
        );
      },
    );
  }

  void ShowSucess(){

}


}