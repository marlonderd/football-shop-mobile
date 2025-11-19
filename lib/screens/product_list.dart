import 'package:flutter/material.dart';
import 'package:football_shop/models/product.dart'; // Pastikan import model Product benar
import 'package:football_shop/widgets/left_drawer.dart';
import 'package:football_shop/widgets/product_card.dart'; // Pastikan import widget card benar
import 'package:football_shop/screens/product_detail.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatefulWidget {
  final bool filterUser;
  const ProductListPage({super.key, this.filterUser = false});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  Future<List<Product>> fetchProduct(CookieRequest request) async {
    String endpoint = widget.filterUser 
        ? 'http://localhost:8000/json-user/' 
        : 'http://localhost:8000/json/';
    
    final response = await request.get(endpoint);

    // Decoding JSON
    List<Product> listProduct = [];
    for (var d in response) {
      if (d != null) {
        listProduct.add(Product.fromJson(d));
      }
    }
    return listProduct;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.filterUser ? 'My Products' : 'All Products'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: fetchProduct(request),
        builder: (context, AsyncSnapshot snapshot) {
          // 1. Cek apakah sedang loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } 
          // 2. Cek apakah terjadi Error (INI YANG PENTING)
          else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 50),
                  const SizedBox(height: 10),
                  Text("Terjadi Kesalahan: ${snapshot.error}", 
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ),
            );
          } 
          // 3. Cek apakah data kosong
          else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Belum ada data produk.',
                style: TextStyle(fontSize: 20, color: Color(0xff59A5D8)),
              ),
            );
          } 
          // 4. Jika semua aman, tampilkan data
          else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) {
                final product = snapshot.data![index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(product: product),
                      ),
                    );
                  },
                  child: ProductCard(product: product),
                );
              },
            );
          }
        },
      ),
    );
  }
}