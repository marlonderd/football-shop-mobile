import 'package:flutter/material.dart';

// Model data untuk setiap item yang akan ditampilkan di grid homepage
class ItemHomepage {
  final String name; // Nama item
  final IconData icon; // Ikon yang akan ditampilkan untuk item
  final Color color;  // Warna latar belakang untuk kartu item

  // Constructor untuk menginisialisasi properti item
  ItemHomepage(this.name, this.icon, this.color);
}

// Widget utama untuk halaman beranda (homepage), bersifat StatelessWidget
class MyHomePage extends StatelessWidget {
  // Constructor untuk MyHomePage
  MyHomePage({super.key});

  // Variabel final untuk menyimpan data informasi pengguna.
  final String nama = "Marlond Leanderd Batara";
  final String npm = "2406496201"; 
  final String kelas = "E"; 

  // Daftar (List) yang berisi data untuk setiap ItemHomepage.
  // Data ini akan digunakan untuk membuat ItemCard di GridView.
  final List<ItemHomepage> items = [
    ItemHomepage(
        "All Products", Icons.shopping_bag, Colors.blue), // Item pertama
    ItemHomepage(
        "My Products", Icons.storefront, Colors.green), // Item kedua
    ItemHomepage("Create Product", Icons.add_shopping_cart, Colors.red), // Item ketiga
  ];

  // Metode build yang dipanggil oleh Flutter untuk merender UI
  @override
  Widget build(BuildContext context) {
    // Scaffold menyediakan struktur dasar halaman (AppBar, body, dll)
    return Scaffold(
      // AppBar di bagian atas layar
      appBar: AppBar(
        // Judul AppBar
        title: const Text(
          'Football Shop',
          // Memberi gaya pada teks judul (putih dan tebal)
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        // Mengatur warna latar belakang AppBar sesuai tema
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      // Konten utama halaman, diberi padding agar tidak menempel di tepi
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // Column menyusun widget-widget di dalamnya secara vertikal
        child: Column(
          // Rata tengah secara horizontal untuk anak-anak Column
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Row menyusun InfoCard secara horizontal
            Row(
              // Menyebarkan InfoCard secara merata di dalam Row
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Memanggil widget InfoCard yang sudah dibuat
                InfoCard(title: 'NPM', content: npm),
                InfoCard(title: 'Name', content: nama),
                InfoCard(title: 'Class', content: kelas),
              ],
            ),

            // Memberi jarak vertikal sebesar 16 piksel
            const SizedBox(height: 16.0),

            // Center digunakan untuk menengahkan Column di bawahnya
            Center(
              child: Column(
                children: [
                  // Teks sambutan dengan padding di atasnya
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Text(
                      'Selamat datang di Football Shop',
                      // Memberi gaya pada teks sambutan
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),

                  // GridView untuk menampilkan item-item dalam 3 kolom
                  GridView.count(
                    primary: true,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10, // Jarak horizontal antar item
                    mainAxisSpacing: 10,  // Jarak vertikal antar item
                    crossAxisCount: 3,    // Jumlah kolom
                    shrinkWrap: true,     // Membuat GridView seukuran kontennya
                    // Menggunakan .map() untuk mengubah List<ItemHomepage> (data) menjadi List<Widget> (ItemCard)
                    children: items.map((ItemHomepage item) {
                      return ItemCard(item);
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget custom (reusable) untuk kartu informasi (NPM, Nama, Kelas)
class InfoCard extends StatelessWidget {
  final String title;  // Judul kartu
  final String content;// Isi kartu

  // Constructor yang mewajibkan title dan content
  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    // Card adalah widget Material dengan bayangan dan sudut membulat
    return Card(
      elevation: 2.0, // Ketinggian bayangan
      child: Container(
        // Mengatur lebar kartu secara responsif
        width: MediaQuery.of(context).size.width / 3.5,
        padding: const EdgeInsets.all(16.0),
        // Menyusun judul dan isi secara vertikal
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0), // Jarak antara judul dan isi
            Text(content),
          ],
        ),
      ),
    );
  }
}

// Widget custom (reusable) untuk tombol-tombol di grid
class ItemCard extends StatelessWidget {
  // Menerima satu objek ItemHomepage yang berisi data untuk kartu ini
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    // Material digunakan sebagai dasar kartu untuk mengatur warna dan bentuk
    return Material(
      // Mengambil warna dari data item yang diterima
      color: item.color,
      // Membuat sudut kartu melengkung
      borderRadius: BorderRadius.circular(12),
      // InkWell membuat kartu dapat ditekan dan memberi efek ripple
      child: InkWell(
        // Aksi yang dijalankan saat kartu ditekan
        onTap: () {
          // Menampilkan SnackBar (notifikasi) di bagian bawah layar
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar() // Menyembunyikan SnackBar sebelumnya (jika ada)
            ..showSnackBar(
                SnackBar(content: Text("Kamu telah menekan tombol ${item.name}")));
        },
        // Container untuk mengatur padding dan konten di dalam kartu
        child: Container(
          padding: const EdgeInsets.all(8),
          // Menengahkan konten di dalam Container
          child: Center(
            // Menyusun Ikon dan Teks secara vertikal
            child: Column(
              // Menengahkan Ikon dan Teks di tengah kartu
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)), // Jarak kecil
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}