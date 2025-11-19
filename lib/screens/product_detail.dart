import 'package:flutter/material.dart';
import 'package:football_shop/models/product.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Gambar Utama (Full Width) - Menggunakan Proxy
            Image.network(
              'http://localhost:8000/proxy-image/?url=${Uri.encodeComponent(product.thumbnail ?? "")}',
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 300,
                color: Colors.grey[300],
                child: const Center(child: Icon(Icons.broken_image, size: 100)),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 2. Nama Produk
                  Text(
                    product.name,
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  // 3. Harga & Kategori
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Rp ${product.price}",
                        style: TextStyle(fontSize: 22, color: Colors.green[800], fontWeight: FontWeight.bold),
                      ),
                      Chip(
                        label: Text(product.category),
                        backgroundColor: Colors.deepPurple[50],
                      ),
                    ],
                  ),
                  const Divider(height: 30),

                  // 4. Deskripsi Lengkap
                  const Text(
                    "Description:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                    textAlign: TextAlign.justify,
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // 5. Info Tambahan (Stok, dll)
                  Row(
                    children: [
                      const Icon(Icons.inventory_2_outlined, size: 20, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text("Stock: ${product.stock}", style: const TextStyle(fontSize: 16)),
                    ],
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