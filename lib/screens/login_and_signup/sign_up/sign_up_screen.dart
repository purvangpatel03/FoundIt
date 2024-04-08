import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foundit/firebase/firebase_helper.dart';
import 'package:foundit/models/user_data.dart';
import 'package:foundit/theme/colors.dart';
import 'package:foundit/widgets/filled_button_widget.dart';
import 'package:foundit/widgets/text_widget.dart';
import 'package:foundit/widgets/textformfield_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  TextWidget(
                    text: 'Sign Up.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: ThemeColor.text,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  TextWidget(
                    text: 'Name',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: ThemeColor.text,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormFieldWidget(
                    controller: nameController,
                    hintText: 'Enter your Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextWidget(
                    text: 'Email',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: ThemeColor.text,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormFieldWidget(
                    controller: emailController,
                    hintText: 'Enter your email address',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email address.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextWidget(
                    text: 'Password',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: ThemeColor.text,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormFieldWidget(
                    controller: passwordController,
                    suffixIcon: const Icon(
                      size: 20,
                      color: Color(0xFFa5b4b8),
                      Icons.visibility_off_outlined,
                    ),
                    hintText: 'Enter your password',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextWidget(
                    text: 'Phone',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: ThemeColor.text,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormFieldWidget(
                    controller: phoneController,
                    hintText: 'Enter your phone number',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        final isDigitsOnly = int.tryParse(value);
                        return isDigitsOnly == null
                            ? 'Input needs to be digits only'
                            : null;
                      }
                      return 'Please enter your phone number.';
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  FilledButtonWidget(
                    backgroundColor: ThemeColor.secondary,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          )
                              .then((value) async {
                            await FirebaseHelper().createUser(
                              UserData(
                                name: nameController.text,
                                email: emailController.text,
                                phoneNo: phoneController.text,
                                uid: value.user!.uid,
                              ),
                            );
                          });
                        } on FirebaseException catch (e) {
                          print(e.message);
                        }
                      }
                    },
                    text: 'Sign up',
                      textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ThemeColor.lightWhite,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextWidget(
                        text: "Already have an account?  ",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: ThemeColor.text,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: TextWidget(
                          text: "Sign In",
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: ThemeColor.tertiary,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
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
