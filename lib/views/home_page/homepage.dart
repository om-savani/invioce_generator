import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invloce_generator/utils/extensions.dart';
import 'package:intl/intl.dart';
import '../../routes/all_routes.dart';
import '../../utils/globals.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (Globals.date != null) {
      dateController.text = DateFormat.yMd().format(Globals.date!);
    }
  }

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: Globals.date ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != Globals.date) {
      setState(() {
        Globals.date = picked;
        dateController.text = DateFormat.yMd().format(Globals.date!);
      });
    }
  }

  void _addProduct() {
    setState(() {
      Globals.products.add({
        'name': '',
        'price': '',
        'quantity': '',
      });
    });
  }

  void _removeProduct(int index) {
    setState(() {
      Globals.products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Invoice Generator"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          foregroundImage: Globals.image != null
                              ? FileImage(Globals.image!)
                              : null,
                          child: const Text("Add Photo"),
                          radius: 70,
                          backgroundColor: Colors.grey.shade300,
                        ),
                        FloatingActionButton.small(
                          onPressed: () async {
                            final ImagePicker imagePicker = ImagePicker();
                            final source = await showDialog<ImageSource>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Choose Image Source"),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      child: const Icon(
                                        CupertinoIcons.camera,
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(ImageSource.camera);
                                      },
                                    ),
                                    ElevatedButton(
                                      child: const Icon(
                                        CupertinoIcons.photo,
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(ImageSource.gallery);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );

                            if (source != null) {
                              final XFile? file =
                                  await imagePicker.pickImage(source: source);
                              if (file != null) {
                                setState(() {
                                  Globals.image = File(file.path);
                                });
                              }
                            }
                          },
                          child: const Icon(Icons.add),
                        ),
                      ],
                    ),
                    20.h,
                    TextFormField(
                      onSaved: (val) => Globals.inv_num = val,
                      initialValue: Globals.inv_num,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please enter Invoice Number";
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: "Invoice Number",
                        hintText: "001",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    10.h,
                    TextFormField(
                      onSaved: (val) => Globals.name = val,
                      initialValue: Globals.name,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please enter Customer Name";
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: "Customer Name",
                        hintText: "Enter name",
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    10.h,
                    TextFormField(
                      controller: dateController,
                      readOnly: true,
                      onTap: () => _selectDate(context),
                      decoration: InputDecoration(
                        labelText: "Invoice Date",
                        hintText: "Select date",
                        prefixIcon: const Icon(Icons.calendar_today),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    20.h,
                    ElevatedButton(
                      onPressed: _addProduct,
                      child: const Text("Add Product"),
                    ),
                    const SizedBox(height: 10),
                    ...Globals.products.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, dynamic> product = entry.value;
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        child: Column(
                          children: [
                            TextFormField(
                              initialValue: product['name'],
                              onSaved: (val) => product['name'] = val ?? '',
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Please enter Product Name";
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: "Product Name",
                                hintText: "Enter product name",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              initialValue: product['price'],
                              onSaved: (val) => product['price'] = val ?? '',
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Please enter Price";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: "Price",
                                hintText: "Enter price",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              initialValue: product['quantity'],
                              onSaved: (val) => product['quantity'] = val ?? '',
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Please enter Quantity";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                labelText: "Quantity",
                                hintText: "Enter quantity",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () => _removeProduct(index),
                              child: const Text("Remove Product"),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          print(Globals.products);
                        }
                      },
                      child: const Text("Submit"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.pdfPage);
        },
        icon: const Icon(Icons.picture_as_pdf_outlined),
        label: const Text("Generate PDF"),
      ),
    );
  }
}
