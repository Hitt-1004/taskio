import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../services/authentication.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isVisible = true;
  var color = 0xFFFFFFFF;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Sign Up", style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.black,
          ),textAlign: TextAlign.left,),
          const SizedBox(height: 6),
          const Text("Create an account and manage your tasks", textAlign: TextAlign.left,),
          const SizedBox(height: 12,),
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Name',
            prefixIcon: Icon(Icons.person_outline)),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email',
            prefixIcon: Icon(Icons.mail_outlined)),
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
          const SizedBox(height: 12,),
          ElevatedButton(
            onPressed: () async {
              final String name = _nameController.text.trim();
              final String email = _emailController.text.trim();
              final String password = _passwordController.text.trim();
              color = 0xFF6146C6;
              setState(() {
              });
              bool success = await Provider.of<AuthProvider>(context, listen: false).signUp(name, email, password);
              if(success){
                Fluttertoast.showToast(
                    msg: 'LogIn Successful',
                    gravity: ToastGravity.BOTTOM,
                    toastLength: Toast.LENGTH_SHORT,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0);
                Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
              }
              else{
                Fluttertoast.showToast(
                    msg: 'There was an error in registering details, \nPlease Try  Again.',
                    gravity: ToastGravity.BOTTOM,
                    toastLength: Toast.LENGTH_SHORT,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            },
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                maximumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                backgroundColor: MaterialStateProperty.all<Color?>(Color(color))
            ),
            child: const Text('Sign Up', style: TextStyle(color: Colors.black),),
          ),
        ],
      ),
    );
  }
}
