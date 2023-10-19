// ignore_for_file: use_build_context_synchronously, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:newton_breakout_revival/presentation/views/auth/login_screen.dart';
import 'package:newton_breakout_revival/presentation/views/auth/sign_up_provider.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  void dispose() {
    super.dispose();
    formfield = null;
  }

  GlobalKey<FormState>? formfield = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool data = false;
        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    data = true;
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Yes'),
                ),
              ],
              content: const Text('Are you sure you want to exit?'),
            );
          },
        );
        if (data) {
          SystemNavigator.pop();
        }

        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: Container(
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/leaderboard-bg.png"),
                  fit: BoxFit.fill),
            ),
            child: SingleChildScrollView(
              child: Consumer<SignUpProvider>(builder: (context, provider, _) {
                return Container(
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
                                    color: Colors.white,
                                    fontFamily: 'Minecraft',
                                    fontSize:
                                        25, // You can adjust the font size as needed
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Games',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Minecraft',
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
                        'Sign up',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Minecraft',
                          fontSize:
                              25, // You can adjust the font size as needed
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Form(
                        key: formfield!,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: provider.nameController,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(color: Colors.white),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  'Name',
                                  style: TextStyle(color: Colors.white),
                                ),
                                labelStyle: TextStyle(color: Colors.white),
                                hintText: 'Name',
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: Color.fromARGB(174, 65, 35, 29),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Name';
                                } else if (provider.nameController.text.length <
                                        2 ||
                                    provider.nameController.text.length > 10) {
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
                              controller: provider.emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(color: Colors.white),
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  'Email',
                                  style: TextStyle(color: Colors.white),
                                ),
                                labelStyle: TextStyle(color: Colors.white),
                                hintText: 'Email',
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: Color.fromARGB(174, 65, 35, 29),
                              ),
                              validator: (value) {
                                bool emailValid = RegExp(
                                        r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
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
                              controller: provider.passController,
                              obscureText: provider.passToggle,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintStyle: const TextStyle(color: Colors.white),
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ),
                                filled: true,
                                labelStyle:
                                    const TextStyle(color: Colors.white),
                                fillColor:
                                    const Color.fromARGB(174, 65, 35, 29),
                                label: const Text('Password'),
                                hintText: 'Password',
                                border: const OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    provider.passToggle = !provider.passToggle;
                                    provider.notifyListeners();
                                  },
                                  icon: Icon(
                                    provider.passToggle
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Password';
                                } else if (provider.passController.text.length <
                                    6) {
                                  return 'Password Length should be more than 6 characters';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(height: 30),
                            TextFormField(
                              controller: provider.confirmPassController,
                              style: const TextStyle(color: Colors.white),
                              obscureText: provider.confirmPassToggle,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ),
                                filled: true,
                                hintStyle: const TextStyle(color: Colors.white),
                                labelStyle:
                                    const TextStyle(color: Colors.white),
                                fillColor:
                                    const Color.fromARGB(174, 65, 35, 29),
                                label: const Text('Confirm Password'),
                                hintText: 'Confirm Password',
                                border: const OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    provider.confirmPassToggle =
                                        !provider.confirmPassToggle;
                                    provider.notifyListeners();
                                  },
                                  icon: Icon(
                                    provider.confirmPassToggle
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Confirm Password';
                                } else if (provider.confirmPassController.text
                                        .toLowerCase() !=
                                    provider.passController.text
                                        .toLowerCase()) {
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
                                  if (formfield!.currentState!.validate()) {
                                    provider.signup(context);
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
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => const LoginScreen()));
                        },
                        child: const Text.rich(
                          TextSpan(
                              text: 'Already  have an Account? ',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                              children: [
                                TextSpan(
                                  text: 'Login',
                                  style: TextStyle(color: Colors.white),
                                )
                              ]),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable

