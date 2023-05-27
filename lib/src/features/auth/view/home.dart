



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:widespace_project/src/features/auth/view/profile.dart';

import '../controllers/product_controller.dart';
import 'add_product.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WideSpace"),
        actions: [
          IconButton(onPressed: (){
            Get.to( Profile());
          }, icon: const Icon(Icons.account_circle))
        ],
      ),
      body: Obx(()=> productController.allProducts.isNotEmpty ?

          ListView.builder(itemCount: productController.allProducts.length,
          itemBuilder: (context, index) {
            // return Card(
            //   child: Text(productController.allProducts[index].title.toString() ),
            // );
            final product = productController.allProducts[index];
            return Card(
              child: ListTile(
                title: Text(productController.allProducts[index].title.toString()),
                trailing: Wrap(
                  children: [
                    Container(

                      child: IconButton(onPressed: (){
                        print(product.id,);
                        print(product.title);
                        print(product.description);
                        Get.to(() => AddProduct(
                          productId: product.id,
                          title: product.title,
                          description: product.description,
                        ));
                      },
                          icon: Icon(Icons.edit,),),
                    ),
                    IconButton(onPressed: (){
                      productController.deleteProduct(context,product.id);
                    },
                        icon: Icon(Icons.delete,color: Colors.red,)),
                ],
              ),
              ),
            );
          },
          )

          : Center(child: CircularProgressIndicator(),)),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        onPressed: () =>{
        Get.to(() => AddProduct(
        productId: null,
        title: null,
        description: null,
        ))
        },
        child: Container(child: Icon(Icons.add,)),
      ),
    );
  }


}
















