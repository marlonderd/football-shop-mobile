import 'package:flutter/material.dart';
import 'package:football_shop/widgets/info_card.dart';
import 'package:football_shop/widgets/item_card.dart';
import 'package:football_shop/widgets/left_drawer.dart';

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
          'Soccer Commerce',
          // Memberi gaya pada teks judul (putih dan tebal)
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        // Mengatur warna latar belakang AppBar sesuai tema
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: const LeftDrawer(),
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
                      'Selamat datang di SoCo',
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