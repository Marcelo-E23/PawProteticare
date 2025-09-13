import 'package:flutter/material.dart';
 
class Login extends StatefulWidget {
  const Login({super.key});
 
  @override
  State<Login> createState() => _LoginState();
}
 
class _LoginState extends State<Login> {
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(child: Icon(Icons.account_circle_sharp, size: 150.0)),
              const Text("LOGIN", style:TextStyle(fontSize: 45)),
              const SizedBox(height:30.0 ,),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Usuario"
                ),
              ),
               const SizedBox(height:30.0 ,),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Senha",
                ),
              ),
              const SizedBox(height:30.0 ,),
              ElevatedButton(onPressed: () {}, child: const Text("Entrar")),
            ],
          ),
      ),
      ),
    );
  }
}
 