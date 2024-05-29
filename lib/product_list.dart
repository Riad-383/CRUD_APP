import 'dart:convert';

import 'package:curd_app/add_product_screen.dart';
import 'package:curd_app/update_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Product_List extends StatefulWidget {
  const Product_List({super.key});

  @override
  State<Product_List> createState() => _Product_ListState();
}

class _Product_ListState extends State<Product_List> {
  bool loading = false;
  List<Product> productList = [];
  @override
  void initState() {
    getProductlist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Product List'),
        ),
        body: loading == true
            ? Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: getProductlist,
                child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: productList.length,
                  itemBuilder: (context, index) {
                    return _buildProductItem(productList[index]);
                  },
                ),
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddProductScreen(),
                ));
          },
          child: Icon(Icons.add),
        ));
  }

  Future<void> getProductlist() async {
    loading = true;
    setState(() {});
    String getproductUrl = "https://crud.teamrabbil.com/api/v1/ReadProduct";
    Uri uri = Uri.parse(getproductUrl);
    Response response = await get(uri);

    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);
      var jsonproductList = decodedData['data'];
      for (Map<String, dynamic> p in jsonproductList) {
        Product product = Product(
            id: p['_id'] ?? 'Unknown',
            productName: p['ProductName'] ?? 'Unknown',
            productCode: p['ProductCode'] ?? 'Unknown',
            unitPrice: p['UnitPrice'] ?? 'Unknown',
            quantity: p['Qty'] ?? 'Unknown',
            totalPrice: p['TotalPrice'] ?? 'Unknown',
            image: p['Img'] ?? 'Unknown');

        productList.add(product);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red, content: Text('Something wrong..!')));
    }
    loading = false;
    setState(() {});
  }

  Widget _buildProductItem(Product product) {
    return ListTile(
      title: Text(product.productName),
      subtitle: Wrap(
        spacing: 16,
        children: [
          Text('Unit price:${product.unitPrice}'),
          Text('Quatity:${product.quantity}'),
          Text('Total price:${product.totalPrice}')
        ],
      ),
      trailing: Wrap(
        children: [
          IconButton(
              onPressed: () async {
                final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateProductScreen(
                        product: product,
                      ),
                    ));
                if (result == true) {
                  getProductlist();
                }
              },
              icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                _showdelteconfirmationdialouge(product.id);
              },
              icon: const Icon(Icons.delete))
        ],
      ),
    );
  }

  void _showdelteconfirmationdialouge(String productID) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete'),
          content: Text('Are you sure you want to delet this..?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('cancel'),
            ),
            TextButton(
              onPressed: () {
                deleteProductlist(productID);
                Navigator.pop(context);
              },
              child: Text('delete'),
            )
          ],
        );
      },
    );
  }

  Future<void> deleteProductlist(String productID) async {
    loading = true;
    setState(() {});

    String deletrProductUrl =
        "https://crud.teamrabbil.com/api/v1/DeleteProduct/$productID";
    Uri uri = Uri.parse(deletrProductUrl);
    Response response = await get(uri);
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      getProductlist();
    } else {
      loading = false;
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red, content: Text('Something wrong..!')));
    }
  }
}

class Product {
  final String id;
  final String productName;
  final String productCode;
  final String unitPrice;
  final String quantity;
  final String totalPrice;
  final String image;

  Product(
      {required this.id,
      required this.productName,
      required this.productCode,
      required this.unitPrice,
      required this.quantity,
      required this.totalPrice,
      required this.image});
}
