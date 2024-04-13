import 'package:flutter/material.dart';

class onboard extends StatefulWidget {
  const onboard({super.key});

  @override
  State<onboard> createState() => _onboardState();
}

class _onboardState extends State<onboard> {
  var lcolor = 0xFFFFFFFF;
  var scolor = 0xFFFFFFFF;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Row(
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
        body: Center(
          child: Column(
            children: [
              Image.asset('assets/home.png', width: 300, height: 300,),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Smart Task Management", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black,
                ),textAlign: TextAlign.left,),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(12, 4, 12, 8),
                child: Text("This smart tool is designed to help you better manage your tasks.", textAlign: TextAlign.left,),
              ),
              const SizedBox(height: 12,),
              ElevatedButton(onPressed: () {
                lcolor = 0xFF6146C6;
                setState(() {});
                Future.delayed(Duration(milliseconds: 100), () {
                  Navigator.pushNamed(context, '/login');
                  lcolor = 0xFFFFFFFF;
                  setState(() {});
                });
              },
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                      maximumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                    backgroundColor: MaterialStateProperty.all<Color?>(Color(lcolor))
                  ),
                  child: const Text('LogIn', style: TextStyle(color: Colors.black,),)),
              const SizedBox(height: 8,),
              ElevatedButton(onPressed: () {
                scolor = 0xFF6146C6;
                setState(() {});
                Future.delayed(Duration(milliseconds: 100), () {
                  Navigator.pushNamed(context, '/signup');
                  scolor = 0xFFFFFFFF;
                  setState(() {});
                });
              },
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                      maximumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                      backgroundColor: MaterialStateProperty.all<Color?>(Color(scolor))
                  ),
                  child: const Text('SignUp', style: TextStyle(color: Colors.black,),))
            ],
          ),
        ),
      )
    );
  }
}
