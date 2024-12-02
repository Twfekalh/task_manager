import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/core/utils/app_images_url.dart';
import 'package:task_manager/core/utils/app_string.dart';
import 'package:task_manager/features/auth/presentation/bloc/log_in_bloc/log_in_bloc.dart'; // تأكد من استيراد الـ LogInBloc
import 'package:task_manager/core/widgets/custom_text_field.dart';
import 'package:task_manager/core/widgets/rounded_button.dart';
import 'package:task_manager/core/theme/app_color.dart';

import '../../../../../core/utils/vaildation_rules.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginViewBody> {
  final _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _usernameController =
      TextEditingController(); // تم تعديل الاسم هنا ليكون username
  final TextEditingController _passwordController = TextEditingController();
  bool isPasswordVisible = false;

  @override
  void dispose() {
    _usernameController.dispose(); // تم تعديل هنا ليتوافق مع username
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
                  // Username Field: تم تعديل الاسم من Email إلى Username
                  CustomTextFormField(
                    controller:
                        _usernameController, // تم تغيير الـ controller هنا ليكون usernameController
                    validator: (val) {
                      if (val!.isEmpty) {
                        return AppString.required;
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text, // تغير إلى text بدل email
                    obscureText: false,
                    hintText: AppString
                        .user, // تم تعديل النص هنا ليكون Username بدلاً من Email
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
                        // Triggering the LogInBloc
                        BlocProvider.of<LogInBloc>(context).add(
                          LoginButtonPressed(
                            username: _usernameController
                                .text, // تعديل هنا ليأخذ الـ username بدلاً من email
                            password: _passwordController.text,
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  // BlocConsumer to handle different states
                  BlocConsumer<LogInBloc, LogInState>(
                    // لا يوجد تغيير هنا، هو للتعامل مع الحالات المختلفة
                    listener: (context, state) {
                      if (state is LogInFailure) {
                        // Show error message on failure
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.errorMessage)),
                        );
                      } else if (state is LogInSuccess) {
                        // Navigate to another screen or show success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Logged In Successfully!")),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is LogInLoading) {
                        return const CircularProgressIndicator();
                      }
                      return Container();
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
