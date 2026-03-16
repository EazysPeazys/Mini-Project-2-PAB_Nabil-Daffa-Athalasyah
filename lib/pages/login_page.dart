import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'home_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final supabase = Supabase.instance.client;

  Future<void> _handleLogin() async {
    try {
      await supabase.auth.signInWithPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
      }
    } on AuthException catch (e) {
      String msg = e.message;
      if (msg.contains("Email not confirmed")) {
        msg = "Error: Konfirmasi email diperlukan atau matikan 'Confirm Email' di Supabase.";
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), backgroundColor: Colors.redAccent));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Welcome Back !", style: TextStyle(color: Color(0xFFFFD700), fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            TextField(
              controller: _emailController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: "Email", 
                labelStyle: TextStyle(color: Colors.white70),
                prefixIcon: Icon(Icons.email, color: Color(0xFFFFD700)),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: "Password", 
                labelStyle: TextStyle(color: Colors.white70),
                prefixIcon: Icon(Icons.lock, color: Color(0xFFFFD700)),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: _handleLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFD700),
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              child: const Text("Login Account", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage())),
              child: const Text("Don't have an account? Register here!", style: TextStyle(color: Colors.white70)),
            ),
          ],
        ),
      ),
    );
  }
}