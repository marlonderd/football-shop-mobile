import 'package:flutter/material.dart';

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