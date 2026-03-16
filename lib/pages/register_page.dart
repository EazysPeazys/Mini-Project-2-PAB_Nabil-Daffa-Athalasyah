import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login_page.dart'; 

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final supabase = Supabase.instance.client;
  bool _isLoading = false;

  Future<void> _handleRegister() async {
    if (_nameController.text.isEmpty || _emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Semua kolom harus diisi!"), backgroundColor: Colors.orange),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      final response = await supabase.auth.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        data: {
          'display_name': _nameController.text.trim(),
        },
      );
      
      if (mounted && response.user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Registrasi Berhasil! Silahkan Login dengan akun Anda."), 
            backgroundColor: Colors.green
          ),
        );
        
        Navigator.pushAndRemoveUntil(
          context, 
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false,
        ); 
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Gagal Daftar: ${e.toString()}"), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      appBar: AppBar(
        backgroundColor: Colors.transparent, 
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            const Text(
              "Create Account", 
              style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)
            ),
            const SizedBox(height: 10),
            const Text(
              "Daftar untuk mulai mengelola portofolio investasi pertama Anda!", 
              style: TextStyle(color: Colors.white70, fontSize: 14)
            ),
            const SizedBox(height: 40),
            
            TextField(
              controller: _nameController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: "Full Name", 
                labelStyle: TextStyle(color: Colors.white70),
                prefixIcon: Icon(Icons.person_outline, color: Color(0xFFFFD700)),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
              ),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: _emailController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: "Email", 
                labelStyle: TextStyle(color: Colors.white70),
                prefixIcon: Icon(Icons.email_outlined, color: Color(0xFFFFD700)),
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
                prefixIcon: Icon(Icons.lock_outline, color: Color(0xFFFFD700)),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
              ),
            ),
            const SizedBox(height: 50),

            _isLoading 
              ? const CircularProgressIndicator(color: Color(0xFFFFD700))
              : ElevatedButton(
                  onPressed: _handleRegister,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFD700), 
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  child: const Text(
                    "Register Account",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)
                  ),
                ),
          ],
        ),
      ),
    );
  }
}