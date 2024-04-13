import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/authentication.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    ImageProvider getImage() {
      return const AssetImage('assets/profile.png');
    }

    return Scaffold(
      appBar: AppBar(title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Profile'),
          IconButton(onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/onboard', (route) => false);
            }, icon: const Icon(Icons.logout_outlined))
        ],
      ),),
      body: Center(
        child: user == null
        ? const CircularProgressIndicator(color: Color(0xFF6146C6),)
        : Column(
          children: [
            CircleAvatar(
                radius: 80,
                foregroundImage: getImage(),
            ),
            const SizedBox(height: 8,),
            Text(user.name),
            const SizedBox(height: 4,),
            Text(user.email, style: TextStyle(color: Colors.grey[600]),),
          ],
        ),
      ),
    );
  }
}
