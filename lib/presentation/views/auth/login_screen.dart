// ignore_for_file: use_build_context_synchronously, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:newton_breakout_revival/presentation/views/auth/login_provider.dart';
import 'package:newton_breakout_revival/presentation/views/auth/signup_screen.dart';
import 'package:newton_breakout_revival/presentation/views/home_view/home_view.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              child: Consumer<LoginProvider>(builder: (context, provider, _) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Center(
                                child: Lottie.asset(
                                    'assets/images/console2.json',
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
                          'Login',
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
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
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
                                  style: const TextStyle(color: Colors.white),
                                  obscureText: provider.passToggle,
                                  decoration: InputDecoration(
                                    hintStyle:
                                        const TextStyle(color: Colors.white),
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
                                        provider.passToggle =
                                            !provider.passToggle;
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
                                    } else if (provider
                                            .passController.text.length <
                                        6) {
                                      return 'Password Length should be more than 6 characters';
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
                                        try {
                                          await provider.login(context);
                                        } catch (error) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              duration:
                                                  const Duration(seconds: 2),
                                              content: Text(
                                                error.toString(),
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              ),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        }
                                      }
                                    },
                                    child: const Text(
                                      'LOGIN',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const LoginFooter(),
                        const SizedBox(
                          height: 30,
                        ),
                        MaterialButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                duration: Duration(seconds: 2),
                                content: Text(
                                  'Continued as Guest',
                                  style: TextStyle(fontSize: 20),
                                ),
                                backgroundColor: Colors.green,
                              ),
                            );
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeView(),
                                ));
                          },
                          child: const Text(
                            'Continue as Guest',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Minecraft',
                              fontSize:
                                  25, // You can adjust the font size as needed
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
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

class LoginFooter extends StatelessWidget {
  const LoginFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => const SignUpScreen()));
      },
      child: const Text.rich(
        TextSpan(
            text: 'Don\'t have an Account? ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Minecraft',
            ),
            children: [
              TextSpan(
                text: 'Sign Up',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Minecraft',
                ),
              )
            ]),
      ),
    );
  }
}
