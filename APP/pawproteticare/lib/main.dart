import 'package:flutter/material.dart';
import 'package:pawproteticare/Pages/login.dart';

void main() { 
 runApp(PawProteticare());
}

class PawProteticare extends StatelessWidget {
  const PawProteticare({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
     debugShowCheckedModeBanner: false,
     home: Login(),

    ); // MaterialApp
  }
}