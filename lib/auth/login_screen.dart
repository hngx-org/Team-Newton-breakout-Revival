// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:newton_breakout_revival/auth/auth_provider.dart';
import 'package:newton_breakout_revival/auth/signup_screen.dart';
import 'package:newton_breakout_revival/presentation/views/home_view/home_view.dart';
import 'package:newton_breakout_revival/presentation/views/start/start_view.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
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
                  'Login',
                  style: TextStyle(
                    fontSize: 25, // You can adjust the font size as needed
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const LoginForm(),
                const LoginFooter(),
              ],
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
            style: TextStyle(color: Colors.black, fontSize: 20),
            children: [
              TextSpan(
                text: 'SignUp',
                style: TextStyle(color: Colors.blue),
              )
            ]),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formfield = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  // final Auth _auth = Auth();
  bool passToggle = true;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formfield,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
                label: Text('Email'),
                hintText: 'Email',
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
                  icon: Icon(passToggle
                      ? Icons.visibility_off_outlined
                      : Icons.visibility),
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
                  if (formfield.currentState!.validate()) {
                    try {
                      await userProvider.login(
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
                  'LOGIN',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

void showErrorBottomSheet(BuildContext context, String errorMessage) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return IntrinsicWidth(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Error',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              Text(errorMessage),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'),
              ),
            ],
          ),
        ),
      );
    },
  );
}
