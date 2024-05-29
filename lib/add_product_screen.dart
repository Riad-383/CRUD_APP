import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _name_ctrl = TextEditingController();
  final TextEditingController _productcode_ctrl = TextEditingController();
  final TextEditingController _unitprice_ctrl = TextEditingController();
  final TextEditingController _quantity_ctrl = TextEditingController();
  final TextEditingController _totalprice_ctrl = TextEditingController();
  final TextEditingController _image_ctrl = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product Screen'),
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
                  controller: _productcode_ctrl,
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
                      addProduct();
                    },
                    child: loading == true
                        ? CircularProgressIndicator.adaptive()
                        : Text("Add"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addProduct() async {
    loading = true;
    setState(() {});
    Map<String, dynamic> inputdata = {
      'Img': _image_ctrl.text.trim(),
      'ProductCode': _productcode_ctrl.text.trim(),
      'ProductName': _name_ctrl.text.trim(),
      'Qty': _quantity_ctrl.text.trim(),
      'TotalPrice': _totalprice_ctrl.text.trim(),
      'UnitPrice': _unitprice_ctrl.text.trim(),
    };
    String addProductUrl = "https://crud.teamrabbil.com/api/v1/CreateProduct";

    Uri uri = Uri.parse(addProductUrl);
    Response response = await post(uri,
        body: jsonEncode(inputdata),
        headers: {'content-type': 'application/json'});
    loading = false;
    setState(() {});

    if (response.statusCode == 200) {
      _name_ctrl.clear();
      _image_ctrl.clear();
      _productcode_ctrl.clear();

      _quantity_ctrl.clear();
      _totalprice_ctrl.clear();
      _unitprice_ctrl.clear();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green, content: Text('New Product Added')));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red, content: Text('Something wrong..! Add product failed..!')));
    }
    print(response.body);
    print(response.statusCode);
    print(response.headers);
  }

  @override
  void dispose() {
    _name_ctrl.dispose();
    _productcode_ctrl.dispose();
    _image_ctrl.dispose();
    _quantity_ctrl.dispose();
    _totalprice_ctrl.dispose();
    _unitprice_ctrl.dispose();
    super.dispose();
  }
}
