import 'package:flutter/material.dart';
import 'package:practise/components/my_textfield.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../components/styled_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = FirebaseAuth.instance;

  String errorMessage = '';

  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void signUp() async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());

      if (userCredential.user != null) {
        // to update users display name
        await userCredential.user!.updateDisplayName(
          usernameController.text.trim(),
        );

        // additional info
        await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
          'email': emailController.text.trim(),
          'username': usernameController.text.trim(),
          'mobile': mobileController.text.trim(),
          'address': addressController.text.trim(),
        });


        Navigator.pushReplacementNamed(context, '/login_page');
      }
    } catch (e) {
      // Handle registration errors
      setState(() {
        errorMessage = 'Registration failed: $e';
      });
    }
  }

  void validateForm() {
    setState(() {
      errorMessage = '';
    });

    if (emailController.text.isEmpty) {
      setState(() {
        errorMessage = 'Please enter your email address.';
      });
      return;
    } else if (!emailController.text.contains('@')) {
      setState(() {
        errorMessage = 'Please enter a valid email address.';
      });
      return;
    }

    if (usernameController.text.isEmpty) {
      setState(() {
        errorMessage = 'Please enter your username.';
      });
      return;
    }

    if (mobileController.text.isEmpty) {
      setState(() {
        errorMessage = 'Please enter your mobile number.';
      });
      return;
    } else if (mobileController.text.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(mobileController.text)) {
      setState(() {
        errorMessage = 'Please enter a valid 10-digit mobile number.';
      });
      return;
    }

    if (addressController.text.isEmpty) {
      setState(() {
        errorMessage = 'Please enter your address.';
      });
      return;
    }

    if (passwordController.text.isEmpty) {
      setState(() {
        errorMessage = 'Please enter your password.';
      });
      return;
    } else if (passwordController.text.length < 6) {
      setState(() {
        errorMessage = 'Password must be at least 6 characters long.';
      });
      return;
    }

    if (confirmPasswordController.text.isEmpty) {
      setState(() {
        errorMessage = 'Please confirm your password.';
      });
      return;
    } else if (confirmPasswordController.text != passwordController.text) {
      setState(() {
        errorMessage = 'Passwords do not match.';
      });
      return;
    }

    if (errorMessage.isEmpty) {
      signUp();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  Image.asset(
                    'lib/images/logo.png',
                    height: 100,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Enter Your Details to Sign Up',
                    style: TextStyle(
                      color: Colors.brown[900],
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 25),
                  StyledTextField(
                    controller: emailController,
                    hintText: 'Email Address',
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,

                  ),
                  const SizedBox(height: 10),
                  StyledTextField(
                    controller: usernameController,
                    hintText: 'Username',
                    obscureText: false,

                  ),
                  const SizedBox(height: 10),
                  StyledTextField(
                    controller: mobileController,
                    hintText: 'Mobile Number',
                    obscureText: false,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.digitsOnly,
                    ],

                  ),
                  const SizedBox(height: 10),
                  StyledTextField(
                    controller: addressController,
                    hintText: 'Address',
                    obscureText: false,

                  ),
                  const SizedBox(height: 10),
                  StyledTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,

                  ),
                  const SizedBox(height: 10),
                  StyledTextField(
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password',
                    obscureText: true,
                  ),

                  const SizedBox(height: 25),
                  GestureDetector(
                    onTap: () {
                      validateForm();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                        color: Colors.brown[900],
                        borderRadius: BorderRadius.circular(35),
                      ),
                      height: 60,
                      child: Center(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Text(
                        errorMessage,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

