import 'package:flutter/material.dart';
import 'package:football_shop/screens/menu.dart';
import 'package:football_shop/screens/product_form.dart';
import 'package:football_shop/screens/product_list.dart'; 

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepPurpleAccent,
            ),
            child: Column(
              children: [
                Text(
                  'SoCo',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text(
                  "Your one-stop football needs!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          
          // Halaman utama
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ));
            },
          ),

          // All Products
          ListTile(
            leading: const Icon(Icons.shopping_bag),
            title: const Text('All Products'),
            onTap: () {
              // Navigasi ke halaman list produk (filterUser: false)
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProductListPage(filterUser: false),
                  ));
            },
          ),

          // My Products
          ListTile(
            leading: const Icon(Icons.storefront),
            title: const Text('My Products'),
            onTap: () {
              // Navigasi ke halaman list produk milik user (filterUser: true)
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProductListPage(filterUser: true),
                  ));
            },
          ),

          // Add Product
          ListTile(
            leading: const Icon(Icons.add_shopping_cart),
            title: const Text('Add Product'),
            onTap: () {
              Navigator.push( 
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProductFormPage(),
                  ));
            },
          ),
        ],
      ),
    );
  }
}