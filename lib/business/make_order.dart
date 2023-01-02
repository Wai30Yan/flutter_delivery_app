import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_delivery/widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';

import '../auth/auth.dart';
import '../models/dummy.dart';

class MakeOrder extends StatefulWidget {
  MakeOrder({Key? key}) : super(key: key);

  @override
  State<MakeOrder> createState() => _MakeOrderState();
}

class _MakeOrderState extends State<MakeOrder> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController itemController = TextEditingController();

  var db = FirebaseFirestore.instance;
  bool approval = true;
  bool accepted = false;

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthFunc>().userModel;
    final userRef =
        FirebaseFirestore.instance.collection('business_owners').doc(user!.id);


    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    GestureDetector(
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.green,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              CustomTextFormField(
                  labelText: 'Enter Name', controller: nameController),
              CustomTextFormField(
                  labelText: 'Enter Phone Number', controller: phoneController),
              CustomTextFormField(
                  labelText: 'Enter Delivery Address',
                  controller: addressController),
              CustomTextFormField(
                  labelText: 'Enter Delivery Item', controller: itemController),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Approved as admin?'),
                    Switch(
                      value: approval,
                      onChanged: ((value) {
                        setState(() {
                          approval = value;
                          debugPrint(approval.toString());
                        });
                      }),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  var data = <String, dynamic>{
                    /**
                     *   this input must be changed according 
                     *   to firebase data model, I left this 
                     *   like this for now cuz it's still in development stage
                     */
                    // "name": nameController.text,
                    // "phone": phoneController.text,
                    // "address": addressController.text,
                    // "order": itemController.text,
                    // "approved": approval,
                    // "accepted": accepted,
                    // "truck_owner_id": null,
                  };
                  for (var k in data.keys) {
                    if (data[k] == "") {
                      final snackBar =
                          SnackBar(content: Text("$k cannot be empty"));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                    }
                  }
                },
                child: const Text('Create Order'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
