Tugas 7: Elemen Dasar Flutter
1. Jelaskan apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget.
    Jawaban:
    Widget Tree adalah representasi hierarkis dari seluruh UI. Di Flutter, segalanya adalah widget, yang disusun dalam struktur pohon. Hubungan Parent-Child (Induk-Anak) adalah inti dari widget tree:
    Parent (Induk): Widget yang mengandung widget lain.
    Child (Anak): Widget yang terkandung di dalam parent.
    Parent mengontrol layout dan properti child-nya. 
    Contoh: Column (parent) memerintahkan semua children di dalamnya untuk berbaris secara vertikal.

2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.
    Jawaban:
    - MaterialApp: Widget root yang membungkus aplikasi, menyediakan navigasi, tema, dan standar Material Design.
    - MyApp: Widget custom (StatelessWidget) yang menjadi root aplikasi, yang tugasnya memanggil MaterialAp.
    - MyHomePage: Widget custom (StatelessWidget) yang mewakili halaman utama.
    - StatelessWidget: Tipe widget dasar yang tidak memiliki state (data internal) yang bisa berubah.
    - Scaffold: Menyediakan struktur dasar halaman yang standar (misal: appBar dan body).
    - AppBar: bagian atas halaman yang menampilkan judul.
    - Text: Menampilkan tulisan.
    - Column: Menyusun children secara vertikal.
    - Row: Menyusun children secara horizontal.
    - GridView: Menyusun children dalam format grid (kotak-kotak).
    - InfoCard: Widget custom untuk menampilkan kartu info (NPM, Nama, Kelas).
    - ItemCard: Widget custom untuk menampilkan tombol fungsional dalam bentuk kartu.
    - Card: Widget visual dari Material Design yang menampilkan kotak dengan bayangan dan sudut membulat.
    - Material: Widget yang menyediakan "permukaan" Material, diperlukan agar InkWell berfungsi.
    - InkWell: Membuat child-nya (widget di dalamnya) dapat ditekan dan memberi efek.
    - Icon: Menampilkan sebuah ikon.
    - ScaffoldMessenger: Sebuah controller yang digunakan untuk mengelola dan menampilkan SnackBar.
    - SnackBar: Notifikasi singkat yang muncul di bagian bawah layar.
    - Padding: Memberi jarak di sekeliling child-nya.
    - SizedBox: Membuat kotak kosong dengan ukuran tertentu, biasanya untuk memberi jarak antar widget.
    - Center: Membuat child-nya berada di posisi tengah.
    - Container: Kotak serbaguna yang bisa diatur ukuran, padding, warna, dan properti lainnya.
    - MediaQuery: Digunakan untuk mendapatkan informasi tentang layar untuk membuat layout yang responsif.

3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini sering digunakan sebagai widget root.
    Jawaban:
    Fungsi MaterialApp adalah sebagai widget pembungkus (wrapper) tingkat tinggi yang menyediakan fungsionalitas dan standar Desain Material. Beberapa fungsi utamanya:
    - Menyediakan ThemeData (skema warna, font) untuk seluruh aplikasi.
    - Menyediakan sistem navigasi (Navigator) untuk berpindah antar halaman.
    - Menentukan home (halaman utama) aplikasi.
    MaterialApp hampir selalu digunakan sebagai root karena widget Material lain (seperti Scaffold, AppBar, Card) membutuhkan MaterialApp sebagai leluhur (ancestor) di dalam widget tree. Widget-widget tersebut perlu "mencari" data tema dan Navigator dari MaterialApp agar dapat berfungsi dengan benar.

4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan kamu memilih salah satunya?
    Jawaban:
    StatelessWidget:
    - Widget yang statis dan immutable (tidak dapat berubah).
    - Tidak memiliki state (data internal) yang bisa berubah.
    - Tampilannya hanya bergantung pada data yang diterima saat widget dibuat (melalui constructor).
    - Digunakan saat UI tidak perlu berubah secara internal (misal: Icon, Text, atau InfoCard).

    StatefulWidget:
    - Widget yang dinamis.
    - Memiliki state (data internal) yang dapat berubah selama widget itu hidup.
    - Menggunakan objek State terpisah untuk menyimpan data tersebut.
    - Menggunakan fungsi setState() untuk memberi tahu Flutter agar membangun ulang (menggambar ulang) UI dengan data yang baru.
    - Digunakan saat UI perlu berubah berdasarkan interaksi pengguna, contohnya mengisi form atau checkbox, atau data yang berubah seiring waktu (contohnya animasi).

5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build?
    Jawaban:
    BuildContext adalah "lokasi" atau "alamat" sebuah widget di dalam widget tree. Ini bukan widget itu sendiri, melainkan handle (pegangan) yang memberi tahu widget di mana posisinya di antara widget-widget lain. Setiap widget menerima BuildContext dalam metode build-nya. BuildContext sangat penting karena digunakan untuk menemukan widget leluhur (ancestor). Di dalam metode build, context digunakan dengan pola Widget.of(context) untuk mendapatkan data dari leluhur. Contohnya adalah ScaffoldMessenger.of(context).showSnackBar(...); Kode ini berarti "Menggunakan context ini, cari ke atas pohon dan temukan ScaffoldMessenger terdekat, lalu gunakan itu untuk menampilkan SnackBar". Tanpa context, ItemCard tidak akan tahu di mana ScaffoldMessenger berada.

6. Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".
    Jawaban:
    Hot Reload:
    - Menyuntikkan file kode Dart yang baru ke dalam Dart Virtual Machine (VM) yang sedang berjalan.
    - Sangat cepat (biasanya < 1 detik).
    - State (status) aplikasi tetap terjaga. Jika sedang mengisi form di halaman ketiga, form itu akan tetap terisi. Hanya metode build() yang dijalankan ulang.
    - Dipakai untuk perubahan UI, layout, teks, dan warna.

    Hot Restart:
    - Membuang Dart VM yang ada dan membuat yang baru. Membangun ulang seluruh aplikasi dari awal.
    - Lebih lambat dari hot reload.
    - State aplikasi hilang. Aplikasi kembali ke halaman utama, seolah baru dibuka.
    - Dipakai saat perubahan kode terlalu besar untuk hot reload (misal: mengubah state global, constructor widget, atau dependencies).

Tugas 8: Flutter Navigation, Layouts, Forms, and Input Elements
1. Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement() pada Flutter. Dalam kasus apa sebaiknya masing-masing digunakan pada aplikasi Football Shop kamu?
    Jawaban:
    - Navigator.push(context, ...) push bekerja seperti menumpuk kartu. Saat Anda memanggil push, halaman (Route) baru akan diletakkan di atas halaman saat ini dalam sebuah tumpukan (stack) navigasi. Halaman lama masih ada di bawahnya, dan pengguna bisa menekan tombol "Back" (panah kembali di AppBar atau gestur swipe) untuk kembali ke halaman sebelumnya.
    - Navigator.pushReplacement(context, ...) pushReplacement bekerja dengan mengganti halaman saat ini di dalam tumpukan. Halaman lama akan dibuang (di-dispose) dan halaman baru akan mengambil tempatnya. Karena halaman lama sudah tidak ada, pengguna tidak bisa menekan tombol "Back" untuk kembali.

    Kapan digunakan di Football Shop:
    - Navigator.push() digunakan saat pengguna menekan tombol "Create Product" dari halaman utama (menu.dart). Pengguna pasti ingin kembali ke Halaman Utama setelah menyimpan atau membatalkan pengisian form. push() menyediakan fungsionalitas "kembali" ini secara otomatis.
    - Navigator.pushReplacement() digunakan saat pengguna bernavigasi menggunakan Drawer. Jika pengguna ada di "Home", lalu membuka Drawer dan memilih "Add Product", kita mengganti halaman tersebut. Ini mencegah tumpukan navigasi yang aneh di mana pengguna bisa kembali dari "Home" ke "Add Product" lalu ke "Home" lagi (Home -> Add Product -> Home). pushReplacement menjaga tumpukan navigasi tetap bersih.

2. Bagaimana kamu memanfaatkan hierarchy widget seperti Scaffold, AppBar, dan Drawer untuk membangun struktur halaman yang konsisten di seluruh aplikasi?
    Jawaban:
    - Scaffold: Ini adalah "kerangka" atau cetakan dasar untuk setiap halaman. Ia menyediakan "slot" standar untuk elemen-elemen umum seperti appBar (di atas), body (di tengah), dan drawer (di samping). Dengan menggunakan Scaffold di menu.dart dan product_form.dart, kita memastikan kedua halaman memiliki struktur tata letak yang sama.
    - AppBar: Dengan menempatkan AppBar di dalam slot appBar milik Scaffold, kita menjamin bahwa header aplikasi selalu muncul di lokasi yang sama (di atas) dengan gaya yang konsisten di setiap halaman.
    - Drawer: Ini adalah kunci konsistensi navigasi. Kita membuat satu widget custom (left_drawer.dart) yang berisi semua tautan navigasi. Kemudian, kita menggunakan ulang widget LeftDrawer yang sama persis ini di properti drawer pada Scaffold di menu.dart dan product_form.dart. Ini menjamin bahwa menu navigasi di seluruh aplikasi identik.

3. Dalam konteks desain antarmuka, apa kelebihan menggunakan layout widget seperti Padding, SingleChildScrollView, dan ListView saat menampilkan elemen-elemen form? Berikan contoh penggunaannya dari aplikasi kamu.
    Jawaban:
    - Padding:
    Kelebihan: Tanpa Padding, elemen form (seperti TextFormField) akan menempel di tepi layar dan menempel satu sama lain, membuat antarmuka terlihat sempit, berantakan, dan sulit digunakan.
    Contoh di Aplikasi: Di product_form.dart, setiap TextFormField (untuk Nama, Harga, Deskripsi) dibungkus dengan Padding(padding: const EdgeInsets.all(8.0), ...) agar ada jarak yang rapi antar field input.

    - SingleChildScrollView:
    Kelebihan: Saat pengguna mengetik di TextFormField, keyboard virtual akan muncul dan memakan ruang layar. Tanpa scrolling, field yang ada di bagian bawah form (seperti tombol "Save") akan tertutup oleh keyboard dan tidak bisa diakses, yang menyebabkan Pixel Overflow Error (peringatan garis-garis kuning-hitam). SingleChildScrollView membungkus form dan secara otomatis memungkinkan pengguna untuk scroll saat kontennya melebihi ukuran layar.
    Contoh di Aplikasi: Di product_form.dart, Form membungkus SingleChildScrollView, yang kemudian membungkus Column berisi semua elemen form.

    - ListView:
    Kelebihan: Mirip dengan Column + SingleChildScrollView, ListView secara default sudah scrollable. ListView sangat efisien untuk menampilkan daftar item yang panjang atau dinamis.
    Contoh di Aplikasi: ListView adalah widget yang sempurna untuk digunakan di dalam LeftDrawer. Ia menampilkan daftar opsi menu ("Home", "Add Product") secara vertikal, dan jika nanti opsinya bertambah banyak, ia akan otomatis bisa di-scroll.
    
4. Bagaimana kamu menyesuaikan warna tema agar aplikasi Football Shop memiliki identitas visual yang konsisten dengan brand toko?
    Jawaban:
    Penyesuaian warna tema dilakukan secara terpusat di satu tempat, yaitu di file main.dart di dalam widget MaterialApp. Kita menggunakan properti theme dan mengisinya dengan ThemeData(). Di dalam ThemeData, kita menentukan colorScheme. Widget Material Flutter (seperti AppBar, DrawerHeader, ElevatedButton) dirancang untuk secara otomatis mencari dan menggunakan warna dari colorScheme ini. AppBar di menu.dart secara otomatis berwarna ungu. Ini bukan karena kita mengaturnya secara manual di menu.dart (meskipun bisa), tetapi karena AppBar secara default mengambil warna colorScheme.primary dari ThemeData yang kita definisikan di main.dart. Ini memastikan setiap AppBar baru yang kita buat akan memiliki warna brand yang konsisten tanpa perlu menyalin kode warna berulang kali.

Tugas 9: Integrasi Layanan Web Django dengan Aplikasi Flutter
Mengapa Model Dart Diperlukan saat Mengambil/Mengirim Data JSON?
Model Dart (seperti kelas Product) sangat diperlukan karena Dart adalah bahasa yang ketat terhadap tipe data. Dengan model, kita memastikan validasi tipe dan null-safety di sisi klien.

Tanpa model, kita hanya bekerja dengan Map<String, dynamic>, yang rentan menyebabkan runtime errors jika terjadi ketidaksesuaian tipe data dari JSON (misalnya, Django mengirim "249000.00" yang seharusnya berupa int).

Konsekuensinya: Kode sulit dipelihara (maintainability), karena kita harus melakukan casting dan null check manual yang berulang, dan perubahan kecil pada struktur JSON dari backend akan menyebabkan crash pada runtime.

Fungsi Package http dan CookieRequest
Package http: Berfungsi sebagai driver atau alat dasar untuk melakukan permintaan HTTP (GET, POST) secara stateless (tidak menyimpan sesi).

CookieRequest (dari pbp_django_auth): Merupakan wrapper di atas http yang berfungsi secara stateful. Peran utamanya adalah secara otomatis menyimpan cookie sesi (sessionid) yang diterima dari Django setelah login dan melampirkannya pada setiap permintaan terautentikasi berikutnya.

Alasan Instance CookieRequest Dibagikan ke Semua Komponen
Instance CookieRequest perlu dibagikan ke seluruh komponen aplikasi Flutter (diatur pada main.dart menggunakan Provider) untuk memastikan session persistence.

Sesi login harus diperoleh satu kali. Jika tidak dibagi, setiap halaman akan memiliki sesi berbeda, menyebabkan cookie sesi hilang saat navigasi. Hilangnya sesi membuat Django melihat user sebagai AnonymousUser, sehingga request untuk membuat produk gagal dengan error 500.

Konfigurasi Konektivitas Flutter dan Django
Konfigurasi ini diperlukan untuk mengatasi pembatasan jaringan dan keamanan yang ketat selama development dan deployment:

10.0.2.2 di ALLOWED_HOSTS: Diperlukan karena di Android Emulator, localhost merujuk pada emulator itu sendiri. 10.0.2.2 adalah IP khusus untuk mengakses mesin host (tempat Django berjalan). Tanpa ini, koneksi dari emulator akan ditolak.

CORS, CORS_ALLOW_CREDENTIALS, dan SameSite/Secure: Wajib karena Flutter berjalan di origin yang berbeda dari Django. Tanpa CORS yang diizinkan, request diblokir. Tanpa CORS_ALLOW_CREDENTIALS, cookie sesi tidak dikirimkan, menyebabkan kegagalan autentikasi permanen.

Izin Akses Internet di Android: Aplikasi Android secara default tidak memiliki izin jaringan. Izin ini harus ditambahkan di AndroidManifest.xml agar koneksi HTTP dapat dilakukan.

Mekanisme Pengiriman Data (Input hingga Tampilan)
Input (Flutter): User mengisi data di ProductFormPage. Data divalidasi, lalu dienkode ke JSON string menggunakan jsonEncode().

POST (Flutter ke Django): request.postJson() mengirim JSON ke endpoint /create-flutter/. Cookie sesi terlampir otomatis.

Penyimpanan (Django): Django memverifikasi user, mengurai JSON (json.loads), membuat objek Product baru, dan menyimpannya ke database. Django merespons {"status": "success"}.

Tampilan (Django ke Flutter): Halaman ProductListPage memanggil request.get('/json/'). Django mengambil data dari DB, men-serialisasinya menjadi JSON.

Parsing & Render (Flutter): Product.fromJson mengurai JSON (dengan logika untuk mengatasi inkonsistensi tipe data harga/tanggal). Data kemudian ditampilkan di ListView.builder melalui widget ProductCard.

Mekanisme Autentikasi (Login, Register, Logout)
Register: Flutter mengirim kredensial ke /auth/register/ melalui request.postJson(). Django membuat akun baru.

Login: Flutter mengirim kredensial ke /auth/login/ melalui request.login(). Django memverifikasi kredensial.

Session Creation: Jika berhasil, Django membuat session ID dan mengirimkannya kembali melalui header Set-Cookie. CookieRequest Flutter menyimpan cookie ini.

Autentikasi Berhasil: Flutter mendeteksi request.loggedIn dan menavigasi ke MyHomePage.

Akses Sesi: Setiap request selanjutnya (misalnya, postJson saat create product) akan otomatis melampirkan cookie sesi ini di header, sehingga Django dapat mengenali user tersebut dan mengizinkan operasi terautentikasi (bukan AnonymousUser).

Logout: request.logout() dipanggil ke /auth/logout/. Django menghapus sesi di server dan browser menghapus cookie, mengakhiri sesi.

Implementasi Checklist Secara Step-by-Step
Setup Dasar & Model: Mengkonfigurasi main.dart dengan Provider dan CookieRequest. Membuat Product Model Dart dengan penanganan null safety dan penyesuaian tipe data (int untuk harga, String untuk tanggal).

Backend JSON & Auth: Membuat JSON Views (/auth/login/, /create-flutter/) di Django. Mengkonfigurasi settings.py untuk CORS, Session, dan Cookie yang ramah development.

Implementasi Form & POST: Membuat ProductFormPage dengan state lokal dan implementasi request.postJson(). URL koneksi di backend dan frontend difiksasi agar konsisten menggunakan http://localhost:8000.

Pengujian Otentikasi: Melakukan full cycle (Run, Login, Post) untuk memastikan AnonymousUser error hilang dan request terautentikasi.

Data Retrieval: Membuat ProductListPage dan ProductCard dengan FutureBuilder untuk memanggil request.get('/json/').

Debugging Tampilan: Mengatasi runtime errors pada Model Dart (harga dari String ke Int, tanggal dari String ke DateTime/String) agar data tampil, dan mengimplementasikan Proxy Image untuk mengatasi masalah CORS pada URL thumbnail.