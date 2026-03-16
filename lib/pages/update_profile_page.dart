import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final supabase = Supabase.instance.client;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final metadata = supabase.auth.currentUser?.userMetadata;
    if (metadata != null) {
      _nameController.text = metadata['display_name'] ?? "";
      _phoneController.text = metadata['phone_number'] ?? "";
      _addressController.text = metadata['address'] ?? "";
    }
  }

  Future<void> _updateProfile() async {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Nama tidak boleh kosong!"), backgroundColor: Colors.orange),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      await supabase.auth.updateUser(
        UserAttributes(
          data: {
            'display_name': _nameController.text.trim(),
            'phone_number': _phoneController.text.trim(),
            'address': _addressController.text.trim(),
          },
        ),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profil Berhasil Diperbarui!"), backgroundColor: Colors.green),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Gagal Update: $e"), backgroundColor: Colors.red),
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
        title: const Text("Update Profile", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildTextField(
              controller: _nameController,
              label: "Nama Lengkap",
              icon: Icons.person_outline,
            ),
            const SizedBox(height: 20),

            _buildTextField(
              controller: _phoneController,
              label: "Nomor Telepon",
              icon: Icons.phone_android_outlined,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),

            _buildTextField(
              controller: _addressController,
              label: "Alamat",
              icon: Icons.location_on_outlined,
              maxLines: 3,
            ),
            const SizedBox(height: 35),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _updateProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFD700),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  elevation: 5,
                ),
                child: _isLoading 
                  ? const CircularProgressIndicator(color: Colors.black)
                  : const Text(
                      "Simpan Perubahan", 
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFFFFD700)),
        prefixIcon: Icon(icon, color: const Color(0xFFFFD700)),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white24),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFFFD700), width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
      ),
    );
  }
}