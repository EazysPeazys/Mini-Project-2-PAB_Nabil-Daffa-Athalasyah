# 📈 NRTX Investment Portfolio App System

Selamat datang di repository **NRTX Portfolio App System**, sebuah solusi manajemen portofolio investasi mobile yang modern dan aman. Aplikasi ini dikembangkan menggunakan framework **Flutter** dan **Supabase** sebagai backend untuk membantu pengguna mengelola aset investasi secara real-time.

---

## 👤 Informasi Project
* **Nama**: Nabil Daffa Athalasyah
* **NIM**: 2409116090
* **Kelas**: Sistem Informasi C 2024
* **Mata Kuliah**: Praktikum Pemrograman Aplikasi Bergerak

---

## 📝 Deskripsi Aplikasi
NRTX Portfolio App System dirancang untuk mempermudah investor dalam memantau pertumbuhan aset mereka. Dengan antarmuka yang bersih dan performa yang responsif, aplikasi ini menjadi alat bantu yang andal dalam pengambilan keputusan finansial. Aplikasi ini mendukung fitur keamanan tingkat tinggi dan manajemen data yang dinamis.

---

## ✨ Fitur Utama Aplikasi
1. **Autentikasi Pengguna**: Sistem pendaftaran akun baru dan login yang aman menggunakan **Supabase Auth**.
2. **Integrasi Database (CRUD)**:
   * **Create**: Menambahkan data aset investasi baru ke dalam database.
   * **Read**: Menampilkan daftar seluruh aset yang tersimpan secara dinamis.
   * **Update**: Memperbarui informasi aset investasi yang sudah ada.
   * **Delete**: Menghapus data aset dari portofolio.
3. **Manajemen State**: Menggunakan **GetX** untuk pengelolaan state dan navigasi yang efisien.
4. **Keamanan API Key**: Implementasi **flutter_dotenv** untuk menyembunyikan kredensial sensitif di file `.env`.
5. **UI Interaktif**: Fitur *toggle* (mata) untuk menyembunyikan/menampilkan password pada halaman login.

---

## 🛠️ Widget yang Digunakan
Aplikasi ini memanfaatkan berbagai widget Flutter untuk membangun UI yang responsif dan fungsional:

* **Layout Widgets**: `Scaffold`, `Container`, `Column`, `Row`, `Padding`, `SizedBox`, `Expanded`.
* **Input Widgets**: `TextField` (dengan `ObscureText`), `TextFormField`, `IconButton`.
* **Data Display**: `ListView.builder`, `Text`, `Card`, `ListTile`.
* **Navigation & Logic**: `GetMaterialApp`, `Obx`, `Get.to`, `FutureBuilder`.
* **Design & Theme**: `ThemeData` (Dark & Light Mode), `ColorScheme`, `GoogleFonts`.

---

## 🚀 Cara Menjalankan Project
1. Clone repository ini.
2. Pastikan file `.env` sudah terdaftar di `assets` pada `pubspec.yaml`.
3. Jalankan perintah `flutter pub get` di terminal.
4. Jalankan aplikasi dengan `flutter run`.

---

*Project ini dibuat untuk memenuhi tugas Praktikum Pemrograman Aplikasi Bergerak 2026.*
