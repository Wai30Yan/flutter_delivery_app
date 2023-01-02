import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_delivery/auth/auth.dart';
import 'package:flutter_delivery/widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

final List<String> userType = <String>["Business Owner", "Truck Owner"];

class _RegisterState extends State<Register> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String? dropdownValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 30.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: (() {
                      Navigator.of(context).pop();
                    }),
                    icon: Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                ],
              ),
              const Icon(
                Icons.person_outline_outlined,
                size: 140,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 13,
              ),
              const Text(
                "Create an account",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Fill required information",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                labelText: 'Name',
                controller: _nameController,
                icon: Icons.person,
              ),
              CustomTextFormField(
                labelText: 'Email',
                controller: _emailController,
                icon: Icons.mail,
              ),
              CustomTextFormField(
                labelText: 'Password',
                controller: _passwordController,
                icon: Icons.lock,
              ),
              CustomTextFormField(
                labelText: 'Confirm Password',
                controller: _confirmPasswordController,
                icon: Icons.lock,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Choose user type: ',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  DropdownButton<String>(
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                    ),
                    value: dropdownValue,
                    icon: Icon(
                      Icons.arrow_downward,
                      color: Theme.of(context).primaryColor,
                    ),
                    items:
                        userType.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              SizedBox(
                height: 55,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (() async {
                    await context
                        .read<AuthFunc>()
                        .signUp(_emailController.text, _passwordController.text)
                        .then((value) {
                      if (value != null) {
                        Map<String, dynamic> user = {
                          "name": _nameController.text,
                          "email": _emailController.text,
                          "account_type": dropdownValue,
                          "id": value.uid,
                        };

                        final db = FirebaseFirestore.instance;
                        db
                            .collection(dropdownValue == "Business Owner" ? "business_owners" : "truck_owners" )
                            .doc(value.uid)
                            .set(user)
                            .then((value) {
                          Navigator.of(context).pushNamed('/');
                        });
                      }
                    });
                  }),
                  child: const Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
