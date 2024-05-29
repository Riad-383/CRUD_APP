import 'dart:convert';

import 'package:curd_app/product_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({super.key, required this.product});
  final Product product;

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  bool loading = false;
  final TextEditingController _productCode_ctrl = TextEditingController();
  final TextEditingController _name_ctrl = TextEditingController();
  final TextEditingController _unitprice_ctrl = TextEditingController();
  final TextEditingController _quantity_ctrl = TextEditingController();
  final TextEditingController _totalprice_ctrl = TextEditingController();
  final TextEditingController _image_ctrl = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    _productCode_ctrl.text = widget.product.productCode;
    _name_ctrl.text = widget.product.productName;
    _unitprice_ctrl.text = widget.product.unitPrice;
    _quantity_ctrl.text = widget.product.quantity;
    _image_ctrl.text = widget.product.image;
    _totalprice_ctrl.text = widget.product.totalPrice;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Product Screen'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _name_ctrl,
                  decoration: InputDecoration(
                    hintText: "Name",
                    label: Text('Name'),
                  ),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please Enter a name';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _productCode_ctrl,
                  decoration: InputDecoration(
                    hintText: "Product code",
                    label: Text('Product code'),
                  ),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please Enter Product code';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _unitprice_ctrl,
                  decoration: InputDecoration(
                    hintText: "Unit price",
                    label: Text('Unit price'),
                  ),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please Enter unit price';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _quantity_ctrl,
                  decoration: InputDecoration(
                    hintText: "Quantity",
                    label: Text('Quantity'),
                  ),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please Enter quantity';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _totalprice_ctrl,
                  decoration: InputDecoration(
                    hintText: "Total price",
                    label: Text('Total price'),
                  ),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please Enter total price';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _image_ctrl,
                  decoration: InputDecoration(
                    hintText: "Image",
                    label: Text('Image'),
                  ),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please Enter a image';
                    } else {
                      return null;
                    }
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {}
                      updateProductList();
                    },
                    child: loading == true
                        ? CircularProgressIndicator()
                        : Text("Update Product"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateProductList() async {
    loading = true;
    setState(() {});
    var inputdata = {
      'Img': _image_ctrl.text,
      'ProductCode': _productCode_ctrl.text,
      'ProductName': _name_ctrl.text,
      'Qty': _quantity_ctrl.text,
      'TotalPrice': _totalprice_ctrl.text,
      'UnitPrice': _unitprice_ctrl.text,
    };

    final String updateProductUrl =
        "https://crud.teamrabbil.com/api/v1/UpdateProduct/${widget.product.id}";
    Uri uri = Uri.parse(updateProductUrl);
    Response response = await post(uri,
        body: jsonEncode(inputdata),
        headers: {'content-type': 'json/productData'});
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green, content: Text('New Product Updated')));
      Navigator.pop(context ,true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text('Something wrong..! Add product failed..!')));
    }
    loading = false;
    setState(() {});
  }
}
