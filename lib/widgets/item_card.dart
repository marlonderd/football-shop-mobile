import 'package:flutter/material.dart';
import 'package:football_shop/screens/product_form.dart';

class ItemHomepage {
  final String name; // Nama item
  final IconData icon; // Ikon yang akan ditampilkan untuk item
  final Color color;  // Warna latar belakang untuk kartu item

  // Constructor untuk menginisialisasi properti item
  ItemHomepage(this.name, this.icon, this.color);
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
          if (item.name == "Create Product") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProductFormPage()));
          }
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