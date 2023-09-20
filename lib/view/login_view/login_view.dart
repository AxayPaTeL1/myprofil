import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Login' ,style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25
            )),
            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration:  InputDecoration(labelText: 'Email' ,   border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),),
            ),
            const SizedBox(height: 20),
            Obx(() {
              return TextField(
                obscureText: !controller.passwordVisible.value,
                controller: passwordController,
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
              );
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final username = emailController.text;
                final password = passwordController.text;
                controller.login(username, password);
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
