import 'package:flutter/material.dart';
import 'package:flutter_delivery/auth/auth.dart';
import 'package:flutter_delivery/auth/register.dart';
import 'package:flutter_delivery/widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 30.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 40.0,
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
                "Welcome Back",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Sign in to continue",
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
                  labelText: 'Email',
                  controller: _emailController,
                  icon: Icons.mail),
              CustomTextFormField(
                  labelText: 'Password',
                  controller: _passwordController,
                  icon: Icons.lock),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Forgot password?",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 55,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (() async {
                    var emailInput = _emailController.text;
                    var passwordInput = _passwordController.text;
                    await context
                        .read<AuthFunc>()
                        .login('truck@gmail.com', 'password');
                  }),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: ((context) {
                        return Register();
                      })));
                    },
                    child: const Text(
                      "Register",
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
