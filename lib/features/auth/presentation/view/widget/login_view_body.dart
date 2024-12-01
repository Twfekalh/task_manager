import 'package:flutter/material.dart';
import 'package:task_manager/core/utils/app_images_url.dart';
import 'package:task_manager/core/utils/app_string.dart';

import '../../../../../core/theme/app_color.dart';
import '../../../../../core/utils/vaildation_rules.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/rounded_button.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginViewBody> {
  final _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Form(
              key: _loginFormKey,
              child: Column(
                children: [
                  // Logo
                  Image.asset(
                    AppImagesUrl.logo,
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(height: 16),
                  // Email Field
                  CustomTextFormField(
                    controller: _emailController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return AppString.required;
                      } else if (!ValidationRules.emailValidation
                          .hasMatch(val)) {
                        return AppString.provideValidEmail;
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    hintText: AppString.email,
                    suffix: null,
                  ),
                  const SizedBox(height: 10),
                  // Password Field
                  CustomTextFormField(
                    controller: _passwordController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return AppString.required;
                      }
                      return null;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !isPasswordVisible,
                    hintText: AppString.password,
                    suffix: InkWell(
                      onTap: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      child: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColor.greyColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Login Button
                  RoundedElevatedButton(
                    buttonText: AppString.login,
                    onPressed: () {
                      if (_loginFormKey.currentState!.validate()) {
                        // Handle login logic here
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
