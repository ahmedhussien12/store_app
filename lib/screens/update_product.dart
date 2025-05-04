import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../models/product_model.dart';
import '../services/update_product.dart';
import '../widgets/custom_buttom.dart';
import '../widgets/custom_text_field.dart';

class UpdateProduct extends StatefulWidget {
  UpdateProduct({super.key});

  static const String id = 'updateProduct';

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  String? productName, desc, image;

  String? price;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    ProductModel product =
        ModalRoute.of(context)!.settings.arguments  as ProductModel;
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Update Product',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          scrolledUnderElevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextField(
                hintText: 'Product Name',
                onChanged: (data) {
                  productName = data;
                },
              ),
              SizedBox(height: 10),
              CustomTextField(
                hintText: 'Product Price',
                inputType: TextInputType.number,
                onChanged: (data) {
                  price = data;
                },
              ),
              SizedBox(height: 10),
              CustomTextField(
                hintText: 'Product Description',
                onChanged: (data) {
                  desc = data;
                },
              ),
              SizedBox(height: 10),
              CustomTextField(
                hintText: 'Product Image',
                onChanged: (data) {
                  image = data;
                },
              ),
              SizedBox(height: 70),
              CustomButon(
                text: 'Update',
                onTap: () async {
                  isLoading = true;

                  setState(() {});
                  try {
                   await updateProduct(product);
                    print('success');
                  } catch (e) {
                    print(e.toString());
                  }
                  isLoading = false;
                  setState(() {});
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> updateProduct(ProductModel product)async{
   await UpdateProductService().updateProduct(
        title: productName == null ? product.title : productName!,
        price: price == null ? product.price.toString() : price!,
        desc: desc == null ? product.description : desc!,
        image: image == null ? product.image : image!,
        category: product.category,
          id: product.id);
  }
}
