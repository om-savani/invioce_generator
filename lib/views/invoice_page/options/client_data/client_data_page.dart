import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invloce_generator/utils/extensions.dart';

import '../../../../routes/all_routes.dart';
import '../../../../utils/globals.dart';

class ClientDataPage extends StatefulWidget {
  const ClientDataPage({super.key});

  @override
  State<ClientDataPage> createState() => _ClientDataPageState();
}

class _ClientDataPageState extends State<ClientDataPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Client Data Page"),
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
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      onSaved: (val) => {Globals.name = val},
                      initialValue: Globals.name,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please enter Client Name";
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: "Client Name",
                        hintText: "Enter Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    10.h,
                    TextFormField(
                      maxLength: 10,
                      onSaved: (val) => {(Globals.contact = val)},
                      initialValue: Globals.contact,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please enter phone number";
                        } else if (val.length < 10) {
                          return "Number must be 10 digits";
                        }
                        return null;
                      },
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                    ElevatedButton(
                      onPressed: () {
                        bool valid = formKey.currentState!.validate();
                        if (valid) {
                          formKey.currentState!.save();
                          Globals.invoice
                              .map((e) => e['client_name'] = Globals.name);
                          SnackBar snackBar = const SnackBar(
                            content: Text("Details saved successfully... !!"),
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Navigator.of(context)
                              .pushNamed(AppRoutes.productdata);
                        } else {
                          SnackBar snackBar = const SnackBar(
                            content: Text("Something went wrong...!!"),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: const Text("Next"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
