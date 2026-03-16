# 📈 NRTX Investment Portfolio App System

Selamat datang di repository **NRTX Portfolio App System**, sebuah solusi manajemen portofolio investasi mobile yang modern dan aman. Aplikasi ini dikembangkan menggunakan framework **Flutter** dan **Supabase** sebagai backend untuk membantu pengguna mengelola aset investasi secara real-time.

---

## 👤 Informasi Project

* **Nama**: Nabil Daffa Athalasyah
* **NIM**: 2409116090
* **Kelas**: Sistem Informasi C 2024
* **Mata Kuliah**: Praktikum Pemrograman Aplikasi Bergerak

---

## 📝 Deskripsi Aplikasi & Alur Fitur

NRTX Portfolio App System dirancang untuk mempermudah investor dalam memantau pertumbuhan aset mereka. Aplikasi ini mengintegrasikan **Flutter** dengan **Supabase** secara penuh untuk mengelola siklus hidup data pengguna:

1.  **Landing & Onboarding**: Pengguna disambut dengan halaman Landing sebelum diarahkan ke sistem autentikasi.
2.  **Sistem Autentikasi**: Register dan Login aman menggunakan **Supabase Auth** dengan fitur *toggle password*.
3.  **Manajemen Profil**: Fitur **Update Profile** untuk sinkronisasi data personal ke database.
4.  **Operasi CRUD Aset**: Tambah, Lihat, Edit, dan Hapus data investasi secara dinamis.
5.  **Pengalaman Pengguna**: Mendukung **Light & Dark Mode** dan sistem **Logout** yang aman.

---

## 📸 Dokumentasi Aplikasi

### Halaman Utama & Auth
| Landing Page | Login Page | Register Page |
| :---: | :---: | :---: |
| ![Landing](GANTI_DENGAN_LINK_FOTO) | ![Login](GANTI_DENGAN_LINK_FOTO) | ![Register](GANTI_DENGAN_LINK_FOTO) |

### Fitur CRUD & Profil
| Home (Daftar Aset) | Tambah/Edit Aset | Update Profile |
| :---: | :---: | :---: |
| ![Home](GANTI_DENGAN_LINK_FOTO) | ![Form](GANTI_DENGAN_LINK_FOTO) | ![Profile](GANTI_DENGAN_LINK_FOTO) |

### Tampilan Dark Mode
| **Dark Mode Home** |
| :---: |
| ![DarkHome](GANTI_DENGAN_LINK_FOTO) |

### Tampilan Light Mode
| **Light Mode Home** |
| :---: |
| ![LightHome](GANTI_DENGAN_LINK_FOTO) |

---

## ✨ Fitur Teknis Utama

1. **Autentikasi Aman**: Menggunakan **Supabase Auth** untuk proteksi data pengguna.
2. **Manajemen State**: Menggunakan **GetX** untuk navigasi dan pengelolaan data yang efisien.
3. **Keamanan API Key**: Implementasi **flutter_dotenv** untuk menyembunyikan kredensial sensitif di file `.env`.
4. **UI Interaktif**: Animasi dan transisi antar halaman yang halus.

---

## 🛠️ Widget yang Digunakan

* **Layout Widgets**: `Scaffold`, `Container`, `Column`, `Row`, `Padding`, `SizedBox`, `Expanded`.
* **Input Widgets**: `TextField` (dengan `ObscureText`), `TextFormField`, `IconButton`.
* **Data Display**: `ListView.builder`, `Text`, `Card`, `ListTile`.
* **Navigation & Logic**: `GetMaterialApp`, `Obx`, `Get.to`, `FutureBuilder`.
* **Design & Theme**: `ThemeData` (Dark & Light Mode), `ColorScheme`, `GoogleFonts`.

---

## 🚀 Cara Menjalankan Project

1. Clone repository ini.
2. Pastikan file `.env` sudah terdaftar di bagian `assets` pada `pubspec.yaml`.
3. Jalankan perintah `flutter pub get` di terminal.
4. Jalankan aplikasi dengan `flutter run`.

---

*Project ini dibuat untuk memenuhi tugas Praktikum Pemrograman Aplikasi Bergerak 2026 - Project By Athalasyah Nabil.*
