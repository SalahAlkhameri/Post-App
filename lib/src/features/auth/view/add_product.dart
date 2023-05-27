

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/product_controller.dart';
import '../models/product.dart';

class AddProduct extends GetView<ProductController> {
  // AddProduct(this.productId, this.title, this.description, {Key? key}) : super(key: key){
  AddProduct({this.productId, this.title, this.description});
  // if (product != null) {
    //   isEditing = true;
    //   idController.text = product.id.toString();
    //   nameController.text = product.title!;
    //   descriptionController.text = product.description!;
    // }
  // }

  final int? productId;
  final String? title;
  final String? description;

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  final idController = TextEditingController();
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    if(productId != null){
      isEditing = true;
      idController.text = productId.toString();
      nameController.text = title!;
      descriptionController.text = description!;
    }
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
          title: Text(isEditing ? 'Edit Product' : 'Add Product'),),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Product Name',
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Product Description',
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    final name = nameController.text;
                    final description = descriptionController.text;
                    final product = Product.f(title: name,description: description,id: productId);
                    if (isEditing) {
                      final id = idController.text;

                      controller.updateProduct(product).then((value){
                          if (value) {
                            nameController.clear();
                            descriptionController.clear();
                            idController.clear();
                            Get.snackbar('تم تعديل المنتج بنجاح', 'Success to update product');
                            Get.back();
                          }else{
                            Get.snackbar(
                                      'Error',
                                      'Failed to update product',
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white,
                                    );
                          }
                      });
                    }else{
                      controller.addProduct(name,description,product).then((result) {
                        print("تم اضافه البيانات");
                        if (result) {
                          nameController.clear();
                          descriptionController.clear();
                          Get.back();
                        } else {
                          Get.snackbar(
                            'لايوجد إتصال بلإنترنت',
                            "",
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        }
                      });
                    }
                  },
                  child: Text(isEditing ? 'Update' : 'Save'),
                ),
              ],
            ),
          ),
    ));
  }
}
