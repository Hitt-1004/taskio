import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../services/authentication.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool isVisible = true;
  var color = 0xFFFFFFFF;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Welcome Back!", style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold
          ),),
          const Text("Log in your account & Manage your task"),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.mail_outlined)),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value!.isEmpty || !value.contains('@')) {
                return 'Invalid email';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock_outline_rounded),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
                icon: Icon(
                  !isVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.black,
                ),
              ),
            ),
            obscureText: isVisible,
            validator: (value) {
              if (value!.isEmpty || value.length < 6) {
                return 'Password must be at least 6 characters long';
              }
              return null;
            },
          ),
          const SizedBox(height: 10,),
          ElevatedButton(
            onPressed: () async {
              color = 0xFF6146C6;
              setState(() {
              });
              final String email = _emailController.text.trim();
              final String password = _passwordController.text.trim();
              print(email + password);
              bool success = await Provider.of<AuthProvider>(context, listen: false).signIn(email, password);
              if(success){
                Fluttertoast.showToast(
                    msg: 'LogIn Successful',
                    gravity: ToastGravity.BOTTOM,
                    toastLength: Toast.LENGTH_SHORT,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0);
                Navigator.pushReplacementNamed(context, '/home');
              }
              else{
                Fluttertoast.showToast(
                    msg: 'There was an error logging in, \nPlease check the details and try again.',
                    gravity: ToastGravity.BOTTOM,
                    toastLength: Toast.LENGTH_SHORT,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color?>(Color(color)),
                minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                maximumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
            ),
            child: const Text('Sign In', style: TextStyle(color: Colors.black),),
          ),
        ],
      ),
    );
  }
}
