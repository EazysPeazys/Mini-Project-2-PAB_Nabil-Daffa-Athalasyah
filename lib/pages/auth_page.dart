import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'home_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  
  bool _isLogin = true;
  bool _obscurePassword = true;

  Future<void> _handleAuth() async {
    try {
      if (_isLogin) {
        await Supabase.instance.client.auth.signInWithPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      } else {
        await Supabase.instance.client.auth.signUp(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          data: {'display_name': _nameController.text.trim()},
        );
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Registrasi berhasil! Silahkan Login dengan akun Anda.")),
          );
          setState(() => _isLogin = true);
        }
        return;
      }
      if (mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}"), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _isLogin ? "Welcome Back !" : "Create Account", 
                style: const TextStyle(color: Color(0xFFFFD700), fontSize: 32, fontWeight: FontWeight.bold)
              ),
              const SizedBox(height: 40),

              if (!_isLogin) ...[
                TextField(
                  controller: _nameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: "Full Name",
                    labelStyle: TextStyle(color: Colors.white70),
                    prefixIcon: Icon(Icons.person_outline, color: Color(0xFFFFD700)),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFFFD700))),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFFFD700), width: 2)),
                  ),
                ),
                const SizedBox(height: 20),
              ],

              TextField(
                controller: _emailController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.white70),
                  prefixIcon: Icon(Icons.email_outlined, color: Color(0xFFFFD700)),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFFFD700))),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFFFD700), width: 2)),
                ),
              ),
              const SizedBox(height: 20),

              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: const TextStyle(color: Colors.white70),
                  prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFFFFD700)),
                  
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: const Color(0xFFFFD700),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  
                  enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFFFD700))),
                  focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFFFD700), width: 2)),
                ),
              ),

              const SizedBox(height: 50),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFD700),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  onPressed: _handleAuth, 
                  child: Text(_isLogin ? "Login Account" : "Register Account", 
                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16))
                ),
              ),

              const SizedBox(height: 20),
              
              TextButton(
                onPressed: () => setState(() => _isLogin = !_isLogin),
                child: Text(_isLogin ? "Don't have an account? Register here!" : "Already have an account? Login", 
                  style: const TextStyle(color: Colors.white70)),
              )
            ],
          ),
        ),
      ),
    );
  }
}