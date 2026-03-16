import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/investment.dart';

class FormPage extends StatefulWidget {
  final Investment? investment;
  const FormPage({super.key, this.investment});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _amountCtrl = TextEditingController();
  String? _selectedCat;

  final List<String> categories = [
    'Deposito', 'Reksa Dana', 'Obligasi', 'Emas', 'Saham', 'Crypto', 'Property'
  ];

  @override
  void initState() {
    super.initState();
    if (widget.investment != null) {
      _nameCtrl.text = widget.investment!.instrumentName;
      _amountCtrl.text = widget.investment!.amount.toString();
      _selectedCat = widget.investment!.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0D1B2A), Color(0xFF1B263B)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(25),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Text(
                        widget.investment == null ? 'Tambah Aset' : 'Edit Aset',
                        style: const TextStyle(
                          color: Color(0xFFFFD700),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),

                  _buildGlassInput(
                    child: DropdownButtonFormField<String>(
                      dropdownColor: const Color(0xFF1B263B),
                      value: _selectedCat,
                      items: categories.map((e) => DropdownMenuItem(
                        value: e, 
                        child: Text(e, style: const TextStyle(color: Colors.white))
                      )).toList(),
                      onChanged: (v) => setState(() => _selectedCat = v),
                      decoration: const InputDecoration(
                        labelText: "Pilih Kategori",
                        labelStyle: TextStyle(color: Colors.white70),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.category, color: Color(0xFFFFD700)),
                      ),
                      validator: (v) => v == null ? "Pilih kategori aset" : null,
                    ),
                  ),
                  const SizedBox(height: 20),

                  _buildGlassInput(
                    child: TextFormField(
                      controller: _nameCtrl,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: "Nama Aset",
                        labelStyle: TextStyle(color: Colors.white70),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.edit, color: Color(0xFFFFD700)),
                      ),
                      validator: (v) => v!.isEmpty ? "Nama aset tidak boleh kosong" : null,
                    ),
                  ),
                  const SizedBox(height: 20),

                  _buildGlassInput(
                    child: TextFormField(
                      controller: _amountCtrl,
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        labelText: "Nominal (Rp)",
                        labelStyle: TextStyle(color: Colors.white70),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.payments, color: Color(0xFFFFD700)),
                        prefixText: "Rp ",
                        prefixStyle: TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold),
                      ),
                      validator: (v) => v!.isEmpty ? "Nominal tidak boleh kosong" : null,
                    ),
                  ),
                  const SizedBox(height: 50),

                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFD700),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        elevation: 10,
                      ),
                      onPressed: _submitData,
                      child: Text(
                        widget.investment == null ? "Simpan Aset" : "Simpan Perubahan",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGlassInput({required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white10),
      ),
      child: child,
    );
  }

  void _submitData() {
    if (_formKey.currentState!.validate() && _selectedCat != null) {
      final assetData = Investment(
        id: widget.investment?.id, 
        instrumentName: _nameCtrl.text,
        amount: int.parse(_amountCtrl.text),
        category: _selectedCat!,
      );
      
      Navigator.pop(context, assetData);
    }
  }
}