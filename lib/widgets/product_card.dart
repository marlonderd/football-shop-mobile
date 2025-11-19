import 'package:flutter/material.dart';
import 'package:football_shop/models/product.dart'; // Pastikan import model Product Anda benar

class ProductCard extends StatelessWidget {
  final Product product;
  
  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Bagian Gambar (Thumbnail) - Menggunakan Proxy Django
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                // URL Proxy untuk mengatasi CORS di Chrome
                'http://localhost:8000/proxy-image/?url=${Uri.encodeComponent(product.thumbnail ?? "")}',
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: const Center(child: Icon(Icons.broken_image, size: 50)),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 2. Bagian Judul
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // 3. Bagian Harga
            Text(
              "Rp ${product.price}",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
              ),
            ),
            const SizedBox(height: 8),

            // 4. Bagian Deskripsi (Preview)
            Text(
              product.description,
              maxLines: 2, // Batasi hanya 2 baris
              overflow: TextOverflow.ellipsis, // Tambahkan "..." jika kepanjangan
              style: const TextStyle(color: Colors.grey),
            ),
            
            // 5. Indikator Hot Item (Jika ada)
            if (product.isHot)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: const [
                    Icon(Icons.local_fire_department, color: Colors.red, size: 20),
                    SizedBox(width: 4),
                    Text("Hot Item", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}