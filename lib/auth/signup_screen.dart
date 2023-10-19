// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:newton_breakout_revival/auth/auth_provider.dart';
import 'package:newton_breakout_revival/auth/login_screen.dart';
import 'package:newton_breakout_revival/presentation/views/home_view/home_view.dart';
import 'package:newton_breakout_revival/presentation/views/start/start_view.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Lottie.asset('assets/images/console2.json',
                            width: 150),
                      ),
                      const Column(
                        children: [
                          Text(
                            'Newton',
                            style: TextStyle(
                              fontSize:
                                  25, // You can adjust the font size as needed
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Games',
                            style: TextStyle(
                              fontSize:
                                  25, // You can adjust the font size as needed
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const Text(
                  'SignUp',
                  style: TextStyle(
                    fontSize: 25, // You can adjust the font size as needed
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SignUpForm(),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => const LoginScreen()));
                  },
                  child: const Text.rich(
                    TextSpan(
                        text: 'Already  have an Account? ',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                        children: [
                          TextSpan(
                            text: 'Login',
                            style: TextStyle(color: Colors.blue),
                          )
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();
  final nameController = TextEditingController();

  // final Auth _auth = Auth();
  bool passToggle = true;
  bool confirmPassToggle = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    passController.dispose();
    emailController.dispose();
    confirmPassController.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                label: Text('Name'),
                hintText: 'Name',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter Name';
                } else if (nameController.text.length < 2 ||
                    nameController.text.length > 10) {
                  return 'Name Length should be between 2 to 10 characters';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                label: Text('Email'),
                hintText: 'Email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                bool emailValid =
                    RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                        .hasMatch(value!);
                if (value.isEmpty) {
                  return 'Enter Email';
                } else if (!emailValid) {
                  return 'Enter a Valid Email';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: passController,
              obscureText: passToggle,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.fingerprint),
                label: const Text('Password'),
                hintText: 'Password',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      passToggle = !passToggle;
                    });
                  },
                  icon: Icon(
                      passToggle ? Icons.visibility : Icons.visibility_off),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter Password';
                } else if (passController.text.length < 6) {
                  return 'Password Length should be more than 6 characters';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 30),
            TextFormField(
              controller: confirmPassController,
              obscureText: confirmPassToggle,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.fingerprint),
                label: const Text('Confirm Password'),
                hintText: 'Confirm Password',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      confirmPassToggle = !confirmPassToggle;
                    });
                  },
                  icon: Icon(confirmPassToggle
                      ? Icons.visibility
                      : Icons.visibility_off),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter Confirm Password';
                } else if (confirmPassController.text.toLowerCase() !=
                    passController.text.toLowerCase()) {
                  return 'Password do not match';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: const RoundedRectangleBorder()),
                onPressed: () async {
                  final userProvider =
                      Provider.of<AuthProvider>(context, listen: false);
                  if (formKey.currentState!.validate()) {
                    try {
                      await userProvider.signup(nameController.text,
                          emailController.text, passController.text);

                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => const HomeView(),
                        ),
                      );
                      // ignore: duplicate_ignore
                    } catch (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(seconds: 2),
                          content: Text(
                            error.toString(),
                            style: const TextStyle(fontSize: 20),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
                child: const Text(
                  'SIGNUP',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
