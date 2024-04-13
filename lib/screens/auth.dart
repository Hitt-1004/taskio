import 'package:flutter/material.dart';
import 'package:task_manager/components/signIn_form.dart';
import 'package:task_manager/components/signUp_form.dart';

class auth extends StatefulWidget {
  auth({super.key, required this.page});
  int page;
  @override
  State<auth> createState() => _authState(page);
}

class _authState extends State<auth> {
int page;
_authState(this.page);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset('assets/logo.png', width: 40, height: 40),
              const SizedBox(width: 8,),
              const Text("taskio", style: TextStyle(
                  color: Color(0xFF6146C6),
                  fontWeight: FontWeight.bold
              ),),
            ],
          )
      ),
      body: SingleChildScrollView(
        child: page == 0? SignUpForm() : const SignInForm(),
      ),
    );
  }
}
