
import 'package:chatapp/Pages/login_Page.dart';
import 'package:chatapp/Pages/register_page.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({Key? key}) : super(key: key);

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  //initially Login Page
  bool showLoginPage = true;

  //toggle between pages login and register
  void togglePages(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage){
      return LoginPage(onTap: togglePages,);
    }
    else{
      return RegisterPage(onTap: togglePages,);
    }
  }
}
