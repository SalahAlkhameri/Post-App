


import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../controllers/product_controller.dart';
import '../models/product.dart';

class UpdateProduct extends GetView<ProductController>{

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  int? id;
  String? title;
  String? desc;
  UpdateProduct(this.id,this.title, this.desc, {super.key});
  // int id = product.id;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Edite Product'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  onChanged: (newValue){
                    title = newValue;
                    print(newValue);
                    print("---------");
                  },
                  controller: TextEditingController(text: title),
                  decoration: InputDecoration(
                    labelText: 'Product Name',
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  onChanged: (newValue){
                    desc = newValue;
                    print(newValue);
                    print("---------");
                  },
                  controller: TextEditingController(text: desc),
                  decoration: InputDecoration(
                    labelText: 'Product Description',
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    print(desc);
                    print(title);
                    // final name = nameController.text;
                    // final description = descriptionController.text;
                    // final product = Product.add(title!,desc!);
                    print("---------------------66");
                    // controller.updateProduct(id ?? 1, product).then((result) {
                    // controller.updateProduct( product).then((result) {
                    //   print("تم اضافه البيانات");
                    //   if (result) {
                    //     nameController.clear();
                    //     descriptionController.clear();
                    //     Get.back();
                    //   } else {
                    //     Get.snackbar(
                    //       'لايوجد إتصال بلإنترنت',
                    //       "",
                    //       backgroundColor: Colors.red,
                    //       colorText: Colors.white,
                    //     );
                    //   }
                    // });
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          ),
        ));
  }

}