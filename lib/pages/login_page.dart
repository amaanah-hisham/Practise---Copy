import 'package:flutter/material.dart';
import 'package:practise/components/my_button.dart';
import 'package:practise/components/my_textfield.dart';
import 'package:flutter/services.dart';
import 'package:practise/components/styled_text_field.dart';
import 'package:practise/pages/register_page.dart';

import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                  const SizedBox(height: 140),
                  Image.asset(
                    'lib/images/logo.png',
                    height: 100,
                  ),
                  const SizedBox(height: 50),
                  Text(
                    'Welcome Back!',
                    style: TextStyle(
                      color: Colors.brown[900],
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 25),
                  StyledTextField(
                    controller: _emailController,
                    hintText: 'Email Address',
                    obscureText: false,
                    onChanged: (value) {
                      setState(() {});
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  StyledTextField(
                    controller: _passwordController,
                    hintText: 'Password',
                    obscureText: true,
                    onChanged: (value) {
                      setState(() {});
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  if (errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Text(
                          errorMessage,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.brown[900]),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: 360,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () async {
                        final email = _emailController.text;
                        final password = _passwordController.text;
                        try {
                          final user = await _auth.signInWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                          if (user != null) {
                            Navigator.pushNamed(context, '/homepage');
                          }
                        } catch (ex) {
                          setState(() {
                            errorMessage = "Invalid Email or Password";
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35),
                        ),
                        elevation: 5,
                        shadowColor: Colors.black,
                        backgroundColor: Colors.brown[900],
                      ),
                      child: Text(
                        "Log In",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member?',
                        style: TextStyle(color: Colors.brown[900]),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/registerpage');
                        },
                        child: const Text(
                          'Register now',
                          style: TextStyle(
                            color: Colors.brown,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
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

