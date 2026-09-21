# Dokumentasi Proyek: LaundryFull (Aplikasi Laundry Offline)

Dokumentasi ini mencakup spesifikasi teknis, arsitektur, teknologi, skema basis data, rincian fitur, serta algoritma pembangunan dari awal untuk aplikasi **LaundryFull**.

---

## 1. Ringkasan Proyek & Tech Stack

**LaundryFull** adalah aplikasi manajemen operasional *laundry* berbasis Flutter yang berjalan **100% offline** tanpa memerlukan koneksi internet. Aplikasi ini dirancang menggunakan **Layered Architecture** dengan **Cubit (`flutter_bloc`)** sebagai pengelola *state*, serta **SQLite (`sqflite`)** untuk penyimpanan data lokal.

### Arsitektur Aplikasi
* **Pola:** Layered Architecture (UI -> Cubit -> Repository -> DatabaseHelper -> Cubit -> UI).
* **Mode Operasional:** *Pure Offline Storage* (SQLite + `SharedPreferences`).


### Dependency / Paket yang Digunakan

| Kategori | Nama Package | Versi | Kegunaan Utama |
| :--- | :--- | :--- | :--- |
| **State Management** | `flutter_bloc` | `^9.1.1` | Mengimplementasikan pola Cubit |
| | `equatable` | `^2.0.8` | Perbandingan nilai state untuk efisiensi rebuild |
| **Database & Storage** | `sqflite` | `^2.4.2` | Database relasional lokal (SQLite) |
| | `path` | `^1.9.1` | Penanganan path file dan database |
| | `shared_preferences` | `^2.5.4` | Penyimpanan sesi login dan flag onboarding |
| **Autentikasi & Keamanan**| `crypto` | `^3.0.6` | Hashing kata sandi (SHA/salt) |
| **Pencetakan / Thermal** | `print_bluetooth_thermal` | `^1.1.9` | Koneksi printer termal Bluetooth |
| | `esc_pos_utils_plus` | `^2.0.3` | Generator perintah byte ESC/POS |
| **Izin Sistem** | `permission_handler` | `^12.0.1` | Request izin Bluetooth dan penyimpanan lokal |
| **Share & Eksport** | `share_plus` | `^12.0.1` | Berbagi struk/laporan dalam bentuk teks atau file |
| | `excel` | `^4.0.6` | Generator dokumen spreadsheet laporan (XLSX) |
| **Integrasi Eksternal** | `url_launcher` | `^6.3.2` | Deep link untuk integrasi langsung ke WhatsApp |
| **Tampilan & UI** | `google_fonts` | `^7.0.2` | Tipografi menggunakan font Poppins |
| | `fl_chart` | `^1.1.1` | Grafik visualisasi laporan transaksi |
| | `cupertino_icons` | `^1.0.8` | Set ikon standar iOS/Cupertino |
| **Utilities** | `intl` | `^0.20.2` | Format tanggal, waktu, dan mata uang |
| | `uuid` | `^4.5.2` | Pembuatan ID unik acak |
| | `path_provider` | `^2.1.5` | Mengakses direktori penyimpanan lokal perangkat |
| **Tools Pengembang** | `flutter_launcher_icons` | `^0.14.3` | Membuat ikon aplikasi secara otomatis |
| | `change_app_package_name`| `^1.5.0` | Mengubah nama *package* aplikasi |
| | `flutter_lints` | `^6.0.0` | Aturan analisis dan kualitas kode Dart |

---

## 2. Struktur Folder Proyek

Proyek ini terorganisir di dalam folder `lib/` dengan pembagian layer yang jelas:

```text
lib/
├── main.dart                   # Inisialisasi DB, SharedPreferences, & MultiBlocProvider
├── core/                       # Komponen Lintas-Fitur (Cross-cutting)
│   ├── constants/              # App constants, warna, kredensial bawaan
│   ├── exceptions/             # Custom exception handling (database_exception.dart)
│   ├── services/               # export_service, laundry_print, printer_service, session_service, whatsapp_service
│   ├── theme/                  # app_theme.dart (Warna, Tipografi, Spacing, Radius)
│   └── utils/                  # Currency, Date, Invoice Generator, Password Helper
├── data/                       # Layer Akses Data
│   ├── database/               # database_helper.dart (Singleton, Skema, Migrasi, Seeding)
│   ├── models/                 # AppSetting, Customer, Order, OrderItem, Payment, Service, User
│   └── repositories/           # Repositori untuk tiap entitas (Auth, Customer, Order, Payment, Report, Service, Settings, User)
├── logic/                      # Pengelola State (Cubit)
│   └── cubits/                 # Folder Cubit per fitur (*_cubit.dart & *_state.dart)
└── presentation/               # Layer Tampilan / UI
    ├── screens/                # Auth, Customers, Dashboard, Orders, Reports, Services, Settings, Onboarding, MainScreen
    └── widgets/                # CustomButton, CustomCard, CustomTextField, OrderCard, StatusBadge


       ┌──────────────┐
       │    users     │
       └──────┬───────┘
              │ (created_by)
              ▼
       ┌──────────────┐          ┌──────────────┐
       │   customers  │          │   services   │
       └──────┬───────┘          └──────┬───────┘
              │ (customer_id)           │
              ▼                         │
       ┌──────────────┐                 │
       │    orders    │                 │
       └──────┬───────┘                 │
              │                         │
      ┌───────┴────────┐                │
      │ (order_id)     │ (order_id)     │ (service_id)
      ▼                ▼                │
┌───────────┐    ┌─────────────┐        │
│ payments  │    │ order_items │ <──────┘
└───────────┘    └─────────────┘

Rincian Tabel
users

id (TEXT, PK)

username (TEXT, UNIQUE)

password_hash (TEXT)

name (TEXT)

role (TEXT: 'owner' | 'kasir')

is_active (INTEGER: 0 | 1)

customers

id (TEXT, PK)

name (TEXT)

phone (TEXT, UNIQUE)

address (TEXT)

notes (TEXT)

total_orders (INTEGER)

total_spent (REAL)

last_order_date (TEXT)

services

id (TEXT, PK)

name (TEXT)

unit (TEXT: 'kg' | 'pcs')

price (REAL)

duration_days (INTEGER)

is_active (INTEGER: 0 | 1)

orders

id (TEXT, PK)

invoice_no (TEXT, UNIQUE)

customer_id (TEXT, FK -> customers.id ON DELETE SET NULL)

customer_name (TEXT)

customer_phone (TEXT)

order_date (TEXT)

due_date (TEXT)

status (TEXT)

total_items (INTEGER)

total_weight (REAL)

total_price (REAL)

paid (REAL)

notes (TEXT)

created_by (TEXT, FK -> users.id)

order_items

id (TEXT, PK)

order_id (TEXT, FK -> orders.id ON DELETE CASCADE)

service_id (TEXT, FK -> services.id)

service_name (TEXT)

quantity (REAL)

unit (TEXT)

price_per_unit (REAL)

subtotal (REAL)

payments

id (TEXT, PK)

order_id (TEXT, FK -> orders.id ON DELETE CASCADE)

amount (REAL)

change (REAL)

payment_date (TEXT)

payment_method (TEXT)

received_by (TEXT, FK -> users.id)

app_settings

key (TEXT, PK)

value (TEXT)

4. Fitur Utama Aplikasi
A. Autentikasi & RBAC (Role-Based Access Control)
Login Multi-Role: Membedakan hak akses antara Owner dan Kasir.

Proteksi Akses UI: Kasir tidak memiliki akses ke halaman Laporan Keuangan, Manajemen User, dan Pengaturan Sistem.

Manajemen User: Penambahan/pengubahan akun pegawai (khusus Owner) dengan soft delete (is_active).

B. Transaksi & Order Management
Auto-Generated Invoice: Format nomor nota otomatis (LNDR-YYMMDD-NNNN) yang direset setiap harinya.

Multi-Item Order: Pembelian beberapa jenis layanan sekaligus (kiloan/satuan) dalam satu pesanan.

Sistem DP & Pelunasan: Pencatatan riwayat pembayaran bertahap beserta hitungan kembalian otomatis.

Pelacakan Status Pesanan: Alur perubahan status transaksi dari Baru, Proses, Selesai, hingga Diambil.

C. Pencetakan Struk Thermal Bluetooth
Koneksi Bluetooth: Pemindaian dan pencetakan langsung ke printer termal (ukuran kertas 58mm / 32 karakter).

Format ESC/POS: Generasi data byte struk langsung dari aplikasi tanpa memerlukan aplikasi third-party.

D. Integrasi WhatsApp
Kirim Struk Otomatis: Mengubah nomor telepon (misal: 08... -> 628...) dan membuka aplikasi WhatsApp secara langsung menggunakan deep link beserta draf format struk pesanan.

E. Manajemen Pelanggan & Layanan
Statistik Otomatis Pelanggan: Otomatis memperbarui akumulasi total_orders, total_spent, dan last_order_date setiap kali transaksi dibuat.

Manajemen Layanan: Pengaturan harga/satuan dengan proteksi soft delete agar histori transaksi lama tidak rusak.

F. Laporan Keuangan & Grafik
Grafik Transaksi: Visualisasi pendapatan harian, mingguan, bulanan, dan kustom menggunakan fl_chart.

Export Data: Menghasilkan dokumen laporan berbentuk file Excel (.xlsx) atau CSV yang siap dibagikan.

5. Algoritma Urutan Pembangunan Aplikasi (Step-by-Step)
FASE 0: Setup Proyek & Dependencies
   │
FASE 1: Fondasi (Core, DB, Models, Utils)
   │
FASE 1.5: Autentikasi & RBAC
   │
FASE 2: Manajemen Layanan (Services)
   │
FASE 3: Order Management & Transaksi
   │
FASE 4: Manajemen Pelanggan (Customer)
   │
FASE 5: Modul Printer Bluetooth Termal
   │
FASE 6: Integrasi WhatsApp Deep-Link
   │
FASE 7: Modul Laporan & Visualisasi Grafik
   │
FASE 8: Pengaturan, Navigasi Dinamis, & Polish
   │
FASE 9: Pengujian (Testing) & Finalisasi Demo
FASE 0 — Setup Proyek
Inisialisasi proyek baru dengan Flutter SDK (>=3.10.1).

Daftarkan semua dependencies pada pubspec.yaml.

Buat direktori core/, data/, logic/, presentation/, dan direktori assets/.

FASE 1 — Fondasi Sistem
Konstanta & Tema: Deklarasikan nilai default aplikasi pada app_constants.dart serta konfigurasi app_theme.dart (Google Fonts Poppins, palet warna, radius UI).

Database Helper: Buat singleton database_helper.dart untuk inisialisasi 7 tabel SQLite, pembuatan index, dan pengisian data awal (seeding owner default & layanan bawaan).

Model Data: Definisikan model (Order, Customer, User, dll.) beserta fungsi toMap(), fromMap(), copyWith(), serta turunan Equatable.

Utility Helpers: Buat utilitas pembuatan hash password (crypto), penformat mata uang (intl), pemformat tanggal, serta generator nomor nota otomatis (invoice_generator.dart).

FASE 1.5 — Autentikasi & RBAC
Implementasi auth_repository.dart dan session_service.dart (SharedPreferences).

Buat AuthCubit untuk menangani status autentikasi (Unauthenticated, Authenticated).

Bangun login_screen.dart dan sertakan fitur manajemen user khusus untuk role Owner.

Terapkan logika penyembunyian menu UI berdasarkan role pengguna saat ini (UserRole).

FASE 2 — Manajemen Layanan
Implementasi service_repository.dart untuk query CRUD data layanan.

Buat ServiceCubit untuk mendistribusikan state daftar layanan ke UI.

Bangun tampilan service_list_screen.dart dan service_form_screen.dart.

FASE 3 — Order Management (Core Modul)
Buat order_repository.dart, payment_repository.dart, dan settings_repository.dart.

Implementasikan OrderCubit untuk memproses pembuatan pesanan baru, kalkulasi harga, pembaruan status, dan penambahan pembayaran.

Buat reusable widgets: status_badge.dart, order_card.dart, custom_text_field.dart.

Bangun layar UI: dashboard_screen.dart, order_list_screen.dart, order_form_screen.dart (multi-item), dan order_detail_screen.dart.

FASE 4 — Manajemen Pelanggan
Hubungkan pencatatan pesanan ke entitas customer_id.

Buat customer_repository.dart dengan kueri otomatis untuk memperbarui akumulasi statistik transaksi pelanggan.

Implementasikan CustomerCubit dan buat modul tampilan pelanggan (customer_list_screen.dart, customer_detail_screen.dart).

Buat export_service.dart untuk mengeksport data pelanggan ke format CSV/Excel.

FASE 5 — Modul Printer Bluetooth
Buat printer_service.dart dan laundry_print.dart untuk menghasilkan deretan byte ESC/POS (kertas 58mm).

Buat PrinterCubit untuk mengelola pencarian perangkat, koneksi, serta proses cetak.

Konfigurasi AndroidManifest.xml untuk izin Bluetooth dan implementasikan permintaan izin runtime via permission_handler.

Sediakan antarmuka printer_settings_screen.dart.

FASE 6 — Integrasi WhatsApp
Buat whatsapp_service.dart untuk memformat nomor HP dan membangun draf pesan teks pesanan.

Hubungkan fungsi url_launcher untuk membuka tautan https://wa.me/....

Sediakan tombol tindakan "Share WA" pada order_detail_screen.dart.

FASE 7 — Laporan & Grafik
Buat report_repository.dart untuk memproses kueri agregasi transaksi harian, mingguan, bulanan, dan rentang tanggal kustom.

Buat ReportCubit dan tampilkan statistik visual menggunakan fl_chart pada report_screen.dart.

Integrasikan fungsi export laporan ke format Excel via export_service.dart.

FASE 8 — Pengaturan, Navigasi, & Polish
Buat SettingsCubit dan settings_screen.dart (pengaturan profil usaha, format nota, dan informasi sistem).

Konfigurasi main.dart dengan MultiBlocProvider serta alur pengecekan status awal (OnboardingScreen -> LoginScreen -> MainScreen).

Buat main_screen.dart dengan BottomNavigationBar dinamis yang menyesuaikan role akun.

Lakukan pemolesan UI (loading indicator, dialog konfirmasi, penanganan state kosong, validasi form).

FASE 9 — Testing & Finalisasi
Lakukan seeding data simulasi untuk menguji skenario beban data.

Uji alur kerja utama aplikasi dari awal hingga akhir (end-to-end):
Login -> Buat Pesanan -> Bayar DP -> Cetak Struk -> Kirim WA -> Selesaikan Pesanan -> Cek Laporan

Lakukan pengujian batasan hak akses antara akun Kasir dan Owner.