



import 'dart:convert';

import 'package:dio/dio.dart' as D;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/product.dart';


class ProductController extends GetxController{

  RxList<Product> allProducts = <Product> [].obs;
  D.Dio dio = D.Dio();
  final String baseUrl = "https://dummyjson.com/products";

  Future<void> loadProduct() async {

    D.Response<String> result = await dio.get(baseUrl);

    Map<String,dynamic> feedback = jsonDecode(result.data!);
    List<dynamic> items = feedback["products"];
    items.forEach((element) {
      Product product = Product(element);
      allProducts.add(product);
    });
  }
  Future<bool> addProduct(String name, String description,Product product) async {
    try {
      final response = await dio.post(
        'https://dummyjson.com/products/add',
        data: {
          'title': name,
          'description': description,
        },
      );
      if(response.statusCode == 200){
      final dynamic productJson = response.data;
      final newProduct = Product(productJson);
      allProducts.add(newProduct);
      return true;
      }else{
        // ProductException.
        return false;
      }
    } catch (error) {
      return false;
      // Handle error
    }
  }

  void deleteProduct(BuildContext context, int? productId) {
    // allProducts.removeWhere((product) => product.id == productId);
    Get.defaultDialog(
      title: 'Are you sure you want to delete this product?',
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: () {
              allProducts.removeWhere((product) => product.id == productId);
              Get.back();
            },
            child: Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Future<bool> updateProduct(Product product) async {
    try {
      print('start-------------------${product.id}');
      print('start-------------------${product.title}');
      var response = await dio.put('https://dummyjson.com/products/${product.id}', data: {
        'title': product.title,
        'description': product.description,
      });
      print('start-------------------response');
    if (response.statusCode == 200) {
      print('start-------------------if (response.statusCode == 200)');
      final dynamic productJson = response.data;
      final newProduct = Product(productJson);
      // allProducts.add(newProduct);
      print('any  ${newProduct.title}');
      print('any  ${newProduct.id}');
      print('any  ${newProduct.description}');

      int idd = product.id!;
      print("-------sala------- $idd");
      allProducts[idd] = newProduct;
      allProducts.refresh();
      Get.back();
      return true;
    } else {
      Get.snackbar('Error', 'Failed to update product');
      print('Error updating product');
      return false;
    }
  }catch (error) {
      // حدث خطأ أثناء التواصل مع الملقم
      Get.snackbar('Error', 'An error occurred while updating the product');
      return false;
    }
  }
  @override
  void onInit() {
    loadProduct();
    print("Length is : ${allProducts.length}");
    super.onInit();
  }
}











































