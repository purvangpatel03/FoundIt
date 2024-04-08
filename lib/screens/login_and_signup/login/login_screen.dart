import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foundit/firebase/firebase_helper.dart';
import 'package:foundit/models/user_data.dart';
import 'package:foundit/screens/login_and_signup/sign_up/sign_up_screen.dart';
import 'package:foundit/theme/colors.dart';
import 'package:foundit/widgets/filled_button_widget.dart';
import 'package:foundit/widgets/text_widget.dart';
import 'package:foundit/widgets/textformfield_widget.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
                    height: 42,
                  ),
                  TextWidget(
                    text: 'Log In.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: ThemeColor.text,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(
                    height: 42,
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
                        return 'Please enter email address.';
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
                  Row(
                    children: [
                      const Spacer(),
                      TextWidget(
                        text: 'Forgot Password?',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: ThemeColor.tertiary,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  FilledButtonWidget(
                    text:'Log in',
                    backgroundColor: ThemeColor.secondary,
                    textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ThemeColor.lightWhite,
                      fontWeight: FontWeight.w600,
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                        } on FirebaseException catch (e) {
                          if (e.code == 'user-not-found') {

                          } else if (e.code == 'wrong-password') {

                          }
                        }
                      }
                    },
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  TextWidget(
                    text: 'OR SIGN IN WITH',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: ThemeColor.text,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  IconButton(
                    onPressed: () async {
                      try {
                        var newUser = await signInWithGoogle();
                        if (newUser.additionalUserInfo!.isNewUser &&
                            newUser.user != null) {
                          await FirebaseHelper().createUser(
                            UserData(
                                name: newUser.user!.displayName!,
                                email: newUser.user!.email!,
                                phoneNo: newUser.user?.phoneNumber,
                                photoURL: newUser.user?.photoURL,
                                uid: newUser.user!.uid),
                          );
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    style: const ButtonStyle(
                      shape: MaterialStatePropertyAll<CircleBorder>(
                        CircleBorder(),
                      ),
                    ),
                    icon: Image.asset(
                      height: 28,
                      width: 28,
                      'assets/images/login_and_signup/google.png',
                    ),
                  ),
                  const SizedBox(
                    height: 42,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextWidget(
                        text: "Don't have an account?  ",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: ThemeColor.text,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ),
                          );
                        },
                        child: TextWidget(
                          text: "Sign up",
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

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication?.idToken,
      accessToken: googleSignInAuthentication?.accessToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
