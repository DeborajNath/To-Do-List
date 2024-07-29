import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:task_management/Data/Constants/colors.dart';
import 'package:task_management/Data/Components/custom_text_form_field.dart';
import 'package:task_management/Data/Constants/routes.dart';
import 'package:task_management/Screens/loginModule/login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen>
    with WidgetsBindingObserver {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isKeyboardVisible = false;
  double imageHeight = 400;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    setState(() {
      isKeyboardVisible = bottomInset > 0.0;
      imageHeight = isKeyboardVisible ? 200 : 400;
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: imageHeight,
                      child: Image.asset(
                        "assets/images/registrationScreen.jpg",
                      ),
                    ),
                    const Gap(30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextFormField(
                              controller: nameController,
                              labelText: "Enter your name",
                              prefixIcon: Icon(
                                Icons.person,
                                color: blue,
                              ),
                            ),
                            const Gap(20),
                            CustomTextFormField(
                              controller: emailController,
                              labelText: "Enter your email",
                              prefixIcon: Icon(
                                Icons.mail,
                                color: blue,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                final emailRegExp = RegExp(
                                  r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
                                );
                                if (!emailRegExp.hasMatch(value)) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                            ),
                            const Gap(20),
                            CustomTextFormField(
                              controller: passwordController,
                              obscureText: _obscureText,
                              labelText: "Create your password",
                              prefixIcon: Icon(
                                Icons.lock,
                                color: blue,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.blue,
                                ),
                                onPressed: _togglePasswordVisibility,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters long';
                                }
                                return null;
                              },
                            ),
                            const Gap(20),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 40),
                                backgroundColor: blue,
                              ),
                              onPressed: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {}
                              },
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                  color: white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  Future.microtask(() {
                    RoutingService.gotoWithoutBack(
                        context, const LoginScreen());
                  });
                },
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      color: grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: "Already have an account?",
                        style: TextStyle(
                          color: black,
                        ),
                      ),
                      TextSpan(
                        text: " Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}
