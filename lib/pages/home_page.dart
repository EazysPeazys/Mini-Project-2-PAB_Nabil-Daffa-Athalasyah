import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/investment.dart';
import 'form_page.dart';
import 'landing_page.dart';
import 'update_profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SupabaseClient supabase = Supabase.instance.client;
  User? user;

  List<Investment> myPortfolio = [];
  bool isLoading = true;
  String selectedFilter = "All";
  final List<String> filters = ['All', 'Deposito', 'Reksa Dana', 'Obligasi', 'Emas', 'Saham', 'Crypto', 'Property'];

  @override
  void initState() {
    super.initState();
    user = supabase.auth.currentUser;
    fetchData();
  }

  String getDisplayName() {
    final metadata = supabase.auth.currentUser?.userMetadata;
    if (metadata != null && metadata.containsKey('display_name')) {
      return metadata['display_name'];
    }
    return user?.email?.split('@')[0] ?? "User";
  }

  Future<void> fetchData() async {
    final currentUser = supabase.auth.currentUser;
    if (currentUser == null) return;
    
    if (mounted) setState(() => isLoading = true);
    try {
      final response = await supabase
          .from('investments')
          .select()
          .eq('user_id', currentUser.id)
          .order('id', ascending: false);
      
      if (mounted) {
        setState(() {
          myPortfolio = (response as List).map((e) => Investment.fromMap(e)).toList();
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Error Fetching: $e");
      if (mounted) setState(() => isLoading = false);
    }
  }

  List<Investment> get filteredData {
    if (selectedFilter == "All") return myPortfolio;
    return myPortfolio.where((item) => item.category == selectedFilter).toList();
  }

  void _openForm({Investment? item}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FormPage(investment: item)),
    );

    if (result != null && result is Investment) {
      _handleSave(result);
    }
  }

  Future<void> _handleSave(Investment asset) async {
    final currentUser = supabase.auth.currentUser;
    if (currentUser == null) return;

    try {
      if (asset.id == null) {
        await supabase.from('investments').insert(asset.toMap(currentUser.id));
      } else {
        await supabase.from('investments').update(asset.toMap(currentUser.id)).eq('id', asset.id!);
      }
      fetchData();
    } catch (e) {
      debugPrint("Error Saving: $e");
    }
  }

  Future<void> _handleDelete(int id) async {
    try {
      await supabase.from('investments').delete().eq('id', id);
      fetchData();
    } catch (e) {
      debugPrint("Error Deleting: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Get.isDarkMode;

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 200), 
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark 
              ? [const Color(0xFF0D1B2A), const Color(0xFF1B263B)] 
              : [Colors.grey[100]!, Colors.white],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PopupMenuButton<String>(
                      offset: const Offset(0, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      color: isDark ? const Color(0xFF1B263B) : Colors.white,
                      onSelected: (value) async {
                        if (value == 'update') {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const UpdateProfilePage()),
                          );
                          setState(() {});
                        }
                      },
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Color(0xFFFFD700),
                            child: Icon(Icons.person, color: Colors.black),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Assalamu'alaikum! Hello,", 
                                style: TextStyle(color: isDark ? Colors.white70 : Colors.black54, fontSize: 12)),
                              Row(
                                children: [
                                  Text(
                                    getDisplayName(),
                                    style: TextStyle(color: isDark ? Colors.white : Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                  Icon(Icons.arrow_drop_down, color: isDark ? Colors.white70 : Colors.black54),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'update',
                          child: Row(
                            children: [
                              Icon(Icons.edit, color: isDark ? Colors.white : Colors.black, size: 20),
                              const SizedBox(width: 10),
                              Text("Update Profile", style: TextStyle(color: isDark ? Colors.white : Colors.black)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode, color: const Color(0xFFFFD700)),
                          onPressed: () {
                            Get.changeThemeMode(isDark ? ThemeMode.light : ThemeMode.dark);
                            setState(() {}); 
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.logout, color: Colors.redAccent),
                          onPressed: () async {
                            bool? confirm = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Konfirmasi Logout"),
                                content: const Text("Apakah anda yakin ingin logout dari aplikasi?"),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context, false),
                                    child: const Text("Batal", style: TextStyle(color: Colors.grey)),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.pop(context, true),
                                    child: const Text("Logout", style: TextStyle(color: Colors.red)),
                                  ),
                                ],
                              ),
                            );

                            if (confirm == true) {
                              await supabase.auth.signOut();
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Akun anda sedang log out, Silahkan login kembali!"),
                                    backgroundColor: Colors.blueAccent,
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LandingPage()));
                              }
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  'NRTX Investment Portfolio App System',
                  style: TextStyle(
                    color: isDark ? const Color(0xFFFFD700) : Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: filters.map((cat) => Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: ChoiceChip(
                      label: Text(cat),
                      selected: selectedFilter == cat,
                      selectedColor: const Color(0xFFFFD700),
                      onSelected: (val) {
                        if (val) setState(() => selectedFilter = cat);
                      },
                    ),
                  )).toList(),
                ),
              ),

              const SizedBox(height: 25),

              Expanded(
                child: isLoading 
                  ? const Center(child: CircularProgressIndicator(color: Color(0xFFFFD700)))
                  : filteredData.isEmpty
                    ? Center(child: Text('Belum ada aset yang terdaftar, \n Klik tombol + untuk menambahkan aset investasi anda', 
                        textAlign: TextAlign.center,
                        style: TextStyle(color: isDark ? Colors.white54 : Colors.black45)))
                    : ListView.builder(
                        itemCount: filteredData.length,
                        itemBuilder: (context, index) {
                          final data = filteredData[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                            color: isDark ? Colors.white.withOpacity(0.05) : Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            child: ListTile(
                              title: Text(data.instrumentName, style: TextStyle(color: isDark ? Colors.white : Colors.black, fontWeight: FontWeight.bold)),
                              subtitle: Text("${data.category} • Rp ${data.amount}", style: TextStyle(color: isDark ? Colors.white70 : Colors.black54)),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
                                onPressed: () async {
                                  bool? confirmDelete = await showDialog<bool>(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text("Hapus Aset"),
                                      content: Text(" Apakah anda yakin ingin menghapus aset: ${data.instrumentName}?"),
                                      actions: [
                                        TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Batal")),
                                        TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Hapus", style: TextStyle(color: Colors.red))),
                                      ],
                                    ),
                                  );
                                  if (confirmDelete == true) _handleDelete(data.id!);
                                },
                              ),
                              onTap: () => _openForm(item: data),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm(),
        backgroundColor: const Color(0xFFFFD700),
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}