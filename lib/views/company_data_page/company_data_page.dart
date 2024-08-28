import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invloce_generator/utils/extensions.dart';

import '../../routes/all_routes.dart';
import '../../utils/globals.dart';

class CompanyDataPage extends StatefulWidget {
  const CompanyDataPage({super.key});

  @override
  State<CompanyDataPage> createState() => _CompanyDataPageState();
}

class _CompanyDataPageState extends State<CompanyDataPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Company Data Page"),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    foregroundImage: Globals.image != null
                        ? FileImage(Globals.image!)
                        : null,
                    child: const Text("Add Logo"),
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
                                  Navigator.of(context).pop(ImageSource.camera);
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
              Form(
                key: formKey,
                child: Container(
                  child: Column(
                    children: [
                      TextFormField(
                        onSaved: (val) => {Globals.cmp_name = val},
                        initialValue: Globals.cmp_name,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please enter Company Name";
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: "Company Name",
                          hintText: "Amazon",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      10.h,
                      TextFormField(
                        onSaved: (val) => {Globals.slogan = val},
                        initialValue: Globals.slogan,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: "Company Slogan",
                          hintText: "Your slogan here",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      10.h,
                      TextFormField(
                        maxLength: 10,
                        onSaved: (val) => {Globals.cmp_contact = val},
                        initialValue: Globals.cmp_contact,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please enter phone number";
                          } else if (val.length < 10) {
                            return "Number must be 10 digits";
                          }
                          return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: "Contact",
                          hintText: "Enter number",
                          prefixIcon: const Icon(Icons.phone),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      10.h,
                      TextFormField(
                        onSaved: (val) => {Globals.address = val},
                        initialValue: Globals.address,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please enter Company Address";
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: "Company Address",
                          hintText: "123, Main Street",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      10.h,
                      ElevatedButton(
                        onPressed: () {
                          bool valid = formKey.currentState!.validate();
                          if (valid) {
                            formKey.currentState!.save();
                            SnackBar snackBar = const SnackBar(
                              content: Text("Details saved successfully... !!"),
                              backgroundColor: Colors.green,
                              behavior: SnackBarBehavior.floating,
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            Navigator.of(context)
                                .pushNamed(AppRoutes.clientData);
                          } else {
                            SnackBar snackBar = const SnackBar(
                              content: Text("Something went wrong...!!"),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        child: const Text("Next"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
