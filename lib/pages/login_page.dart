import 'package:flutter/material.dart';
import 'package:status_alert/status_alert.dart';

import '../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey();

  String? username;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: _buildUI(),
      ),
    );
  }

  Widget _buildUI() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _title(),
          _login(),
        ],
      ),
    );
  }

  Widget _title() {
    return Image.asset("images/Logo-Secret-Recipe.png");
  }

  Widget _login() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.90,
      height: MediaQuery.sizeOf(context).height * 0.30,
      child: Form(
          key: _loginFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextFormField(
                initialValue: 'emilys',
                onSaved: (value) {
                  setState(() {
                    username = value;
                  });
                }, //this gets called when we save the using the save button
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter a username";
                  }
                  // return null;
                },
                decoration: const InputDecoration(hintText: "Username"),
              ),
              TextFormField(
                initialValue: 'emilyspass',
                onSaved: (value) {
                  setState(() {
                    password = value;
                  });
                },
                obscureText: true,
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return "Enter a valid password";
                  }
                },
                decoration: const InputDecoration(hintText: "Password"),
              ),
              _loginButton(),
            ],
          )),
    );
  }

  Widget _loginButton() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepOrange,
        ),
        onPressed: () async {
          if (_loginFormKey.currentState?.validate() ?? false) {
            _loginFormKey.currentState?.save();
            bool result = await AuthService().login(username!, password!);
            if (mounted) {
              if (result) {
                Navigator.pushReplacementNamed(context, '/home_page');
              } else {
                StatusAlert.show(context,
                    duration: const Duration(seconds: 2),
                    title: 'Login Failed',
                    subtitle: 'Please, try again',
                    configuration: const IconConfiguration(icon: Icons.error),
                    maxWidth: 260);
              }
            }
          }
        },
        child: const Text(
          "Login",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}
