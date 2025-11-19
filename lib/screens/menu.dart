import 'package:flutter/material.dart';
import 'package:football_shop/widgets/info_card.dart';
import 'package:football_shop/widgets/item_card.dart';
import 'package:football_shop/widgets/left_drawer.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final String nama = "Marlond Leanderd Batara";
  final String npm = "2406496201"; 
  final String kelas = "E"; 

  final List<ItemHomepage> items = [
    ItemHomepage("All Products", Icons.shopping_bag, Colors.blue),
    ItemHomepage("My Products", Icons.storefront, Colors.green), // Tombol Baru
    ItemHomepage("Create Product", Icons.add_shopping_cart, Colors.red),
    ItemHomepage("Logout", Icons.logout, Colors.orange), // Tombol Baru
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Soccer Commerce',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: const LeftDrawer(),
      // Tambahkan SingleChildScrollView di sini agar menu bisa discroll
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InfoCard(title: 'NPM', content: npm),
                  InfoCard(title: 'Name', content: nama),
                  InfoCard(title: 'Class', content: kelas),
                ],
              ),
              const SizedBox(height: 16.0),
              Center(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: Text(
                        'Selamat datang di SoCo',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                    ),
                    GridView.count(
                      primary: true,
                      padding: const EdgeInsets.all(20),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 3,
                      shrinkWrap: true,
                      // Agar gridview tidak scroll sendiri (ikut scroll parent)
                      physics: const NeverScrollableScrollPhysics(), 
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
      ),
    );
  }
}