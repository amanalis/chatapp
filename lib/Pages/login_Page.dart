import 'package:chatapp/Components/my_button.dart';
import 'package:chatapp/Components/my_text_field.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({Key? key, this.onTap}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text Controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> signIn() async {
    //get auth service
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInWithEmailandPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                //logo
                const Icon(
                  Icons.message,
                  size: 100,
                ),

                // welcome back message
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Welcome back you've been missed!",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),

                //Email Textfield
                const SizedBox(
                  height: 25,
                ),
                MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false),

                // password textfield
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true),

                // sign in button
                const SizedBox(
                  height: 25,
                ),
                MyButton(
                  text: 'Sign-In',
                  onTap: signIn,
                ),

                // not a member? register now
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Not a member?"),
                    SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Register now!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
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
    );
  }
}
