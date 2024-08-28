import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invloce_generator/utils/extensions.dart';

import '../../../../routes/all_routes.dart';
import '../../../../utils/globals.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<Map> allproduct = [
    {},
  ];
  void savedata() {
    Globals.invoice.addAll(
      [
        {
          "logo": Globals.image,
          "cmp_name": Globals.cmp_name,
          "cmp_contact": Globals.cmp_contact,
          "address": Globals.address,
          "customer_name": Globals.name,
          "customer_contact": Globals.contact,
          "items": List.from(Globals.products)
        }
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Product Page"),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).popAndPushNamed(AppRoutes.homepage);
            },
            icon: const Icon(Icons.home),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: allproduct
                  .map(
                    (e) => Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextFormField(
                            onChanged: (val) => {e['name'] = val},
                            initialValue: e['name'],
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter Product Name";
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: "Product Name",
                              hintText: "Enter Product Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          10.h,
                          TextFormField(
                            onChanged: (val) => {e['qty'] = val},
                            initialValue: e['qty'],
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter Product Quantity";
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              labelText: "Product Quantity",
                              hintText: "1/2/3..",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          10.h,
                          TextFormField(
                            onChanged: (val) => {e['price'] = val},
                            initialValue: e['price'],
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter Product Price";
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              labelText: "Product Price",
                              hintText: "Enter Product Price",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          10.h,
                          ElevatedButton.icon(
                            onPressed: () {
                              allproduct.removeAt(allproduct.indexOf(e));
                              setState(() {});
                            },
                            label: const Text("Remove"),
                            icon: const Icon(Icons.remove),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () {
              allproduct.add({});
              setState(() {});
            },
            child: const Icon(Icons.add),
          ),
          10.w,
          FloatingActionButton.extended(
            onPressed: () {
              bool valid = formKey.currentState!.validate();
              if (valid) {
                formKey.currentState!.save();
                savedata();
                SnackBar snackBar = const SnackBar(
                  content: Text("Details saved successfully... !!"),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                );

                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Navigator.of(context).pushNamed(AppRoutes.pdfPage);
              } else {
                SnackBar snackBar = const SnackBar(
                  content: Text("Something went wrong...!!"),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
              Globals.products.clear();
              Globals.products = allproduct;
              Navigator.of(context).pushNamed(AppRoutes.pdfPage);
            },
            icon: const Icon(Icons.picture_as_pdf),
            label: const Text("PDF"),
          ),
        ],
      ),
    );
  }
}
