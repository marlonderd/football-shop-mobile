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