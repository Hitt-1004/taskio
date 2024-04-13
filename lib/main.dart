import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/screens/Home.dart';
import 'package:task_manager/screens/calendar.dart';
import 'package:task_manager/screens/onboard.dart';
import 'package:task_manager/screens/auth.dart';
import 'package:task_manager/screens/profile.dart';
import 'package:task_manager/screens/project.dart';
import 'package:task_manager/services/authentication.dart';
import 'package:task_manager/services/tasks.dart';

void main() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task Manager',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.black)
          ),
          useMaterial3: true,
        ),
        home: const onboard(),
        routes: {
          '/onboard': (context) => const onboard(),
          '/signup': (context) => auth(page: 0,),
          '/login': (context) => auth(page: 1),
          '/home': (context) => const Home(),
          '/projects': (context) => const projects(),
          '/profile': (context) => const profile(),
          '/calendar': (context) => CalendarPage()
        },
      ),
    );
  }
}

