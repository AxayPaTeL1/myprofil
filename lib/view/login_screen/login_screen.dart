import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myprofile/utils/commen_method.dart';

import 'login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  LoginScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Login' ,style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25
              )),
              const SizedBox(height: 20),
              TextFormField(
                controller: controller.emailController,
                decoration:  buildInputDecorationTextField(labelName: "Email"),

                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a Email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Obx(() {
                return TextFormField(
                  obscureText: !controller.passwordVisible.value,
                  controller: controller.passwordController,
                  decoration: InputDecoration(labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(controller.passwordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          controller.togglePasswordVisibility();
                        },
                      )
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                );
              }),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Obx(() {
                    return Checkbox(
                      value: controller.rememberMe.value,
                      onChanged: (value) {
                        controller.rememberMe.value = value!;
                      },
                    );
                  }),
                  const Text('Remember Me'),
                ],
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(onPressed: (){
                    final username = controller.emailController.text;
                    final password = controller.passwordController.text;

                    if(formKey.currentState!.validate()){
                    controller.login(username, password);
                    }

                  }, child: const Text("Login")))
            ],
          ),
        ),
      ),
    );
  }


}


