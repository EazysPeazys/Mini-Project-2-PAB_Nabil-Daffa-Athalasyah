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
| ![Landing](https://github.com/EazysPeazys/Mini-Project-2-PAB_Nabil-Daffa-Athalasyah/blob/df899944dc05165db6f5918201aef78825dc7d48/Landing%20Page.png) | ![Login](https://github.com/EazysPeazys/Mini-Project-2-PAB_Nabil-Daffa-Athalasyah/blob/df899944dc05165db6f5918201aef78825dc7d48/Login%20Page.png) | ![Register](https://github.com/EazysPeazys/Mini-Project-2-PAB_Nabil-Daffa-Athalasyah/blob/df899944dc05165db6f5918201aef78825dc7d48/Register%20Page.png) |

### Fitur CRUD
| Home (Daftar/List Aset) | Tambah Aset | Edit Aset | Hapus Aset |
| :---: | :---: | :---: | :---: |
| ![Home](https://github.com/EazysPeazys/Mini-Project-2-PAB_Nabil-Daffa-Athalasyah/blob/df899944dc05165db6f5918201aef78825dc7d48/Daftar%20List%20Aset.png) | ![Create](https://github.com/EazysPeazys/Mini-Project-2-PAB_Nabil-Daffa-Athalasyah/blob/df899944dc05165db6f5918201aef78825dc7d48/Tambah%20Aset.png) | ![Edit](https://github.com/EazysPeazys/Mini-Project-2-PAB_Nabil-Daffa-Athalasyah/blob/df899944dc05165db6f5918201aef78825dc7d48/Edit%20Page.png) | ![Delete](https://github.com/EazysPeazys/Mini-Project-2-PAB_Nabil-Daffa-Athalasyah/blob/df899944dc05165db6f5918201aef78825dc7d48/Delete%20Page.png) 

### Tampilan Fitur Lainnya
| **Update Profile** |
| :---: |
| ![UpdateProfile](https://github.com/EazysPeazys/Mini-Project-2-PAB_Nabil-Daffa-Athalasyah/blob/df899944dc05165db6f5918201aef78825dc7d48/Update%20Profile%20Page.png) |

### Tampilan Dark Mode
| **Dark Mode Home** |
| :---: |
| ![DarkHome](https://github.com/EazysPeazys/Mini-Project-2-PAB_Nabil-Daffa-Athalasyah/blob/df899944dc05165db6f5918201aef78825dc7d48/Dark%20Theme.png) |

### Tampilan Light Mode
| **Light Mode Home** |
| :---: |
| ![LightHome](https://github.com/EazysPeazys/Mini-Project-2-PAB_Nabil-Daffa-Athalasyah/blob/df899944dc05165db6f5918201aef78825dc7d48/Light%20Theme.png) |

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
