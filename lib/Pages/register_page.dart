//import 'package:chatapp/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Components/my_button.dart';
import '../Components/my_text_field.dart';
import '../services/auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({Key? key, this.onTap}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text Controller
  final confirmpasswordController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUp() async {
    if (passwordController.text != confirmpasswordController.text) {
      SnackBar(
        content: Text("Passwords do not match!"),
      );
      return;
    }

    //get auth service
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signUpWithEmailandPassword(
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

                // account setup message
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Let's create an account!",
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

                // Confirm password textfield
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                    controller: confirmpasswordController,
                    hintText: 'Confirm Password',
                    obscureText: true),

                // sign in button
                const SizedBox(
                  height: 25,
                ),
                MyButton(
                  text: 'Sign-Up',
                  onTap: signUp,
                ),

                // not a member? register now
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Log-In!",
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
