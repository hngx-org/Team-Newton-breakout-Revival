import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:newton_breakout_revival/auth/login_screen.dart';

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
                  // if (formKey.currentState!.validate()) {
                  //   final result = await _auth.createUserWithEmailAndPassword(
                  //       emailController.text, passController.text);
                  //   if (result) {
                  //     // ignore: use_build_context_synchronously
                  //     Navigator.of(context).pushReplacement(MaterialPageRoute(
                  //         builder: (_) => const MyHomePage(title: 'homepage')));
                  //   } else {
                  //     // ignore: use_build_context_synchronously
                  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  //       duration: Duration(seconds: 2),
                  //       content:
                  //           Text("unable to sign up please try again later"),
                  //     ));
                  //   }
                  // }
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
