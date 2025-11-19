import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:football_shop/screens/menu.dart';
import 'package:football_shop/screens/product_list.dart'; 
import 'package:football_shop/widgets/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart'; 
import 'package:provider/provider.dart'; 

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  
  // Variabel input user
  String _name = "";
  int _price = 0;
  String _description = "";
  String _thumbnail = ""; 
  String _category = "Jersey"; 
  bool _isFeatured = false; 
  
  final List<String> _categories = [
    'Jersey',
    'Shoes',
    'Equipment',
    'Accessories',
    'Clothes',
  ];

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>(); 

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Add New Product Form',
          ),
        ),
        backgroundColor: Colors.deepPurple, 
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(), 
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Input Name
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Product Name", labelText: "Product Name", border: OutlineInputBorder(),
                    ),
                    onChanged: (String? value) { setState(() { _name = value!; }); },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) return "Name cannot be empty!";
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Price", labelText: "Price", border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (String? value) { setState(() { _price = int.tryParse(value!) ?? 0; }); },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) return "Price cannot be empty!";
                      if (int.tryParse(value) == null) return "Must be a number!";
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Description", labelText: "Description", border: OutlineInputBorder(),
                    ),
                    onChanged: (String? value) { setState(() { _description = value!; }); },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) return "Description cannot be empty!";
                      return null;
                    },
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Thumbnail URL", labelText: "Thumbnail URL",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (String? value) { setState(() { _thumbnail = value!; }); },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: "Category", border: OutlineInputBorder()),
                    value: _category,
                    items: _categories.map((cat) => DropdownMenuItem(value: cat, child: Text(cat))).toList(),
                    onChanged: (String? newValue) { setState(() { _category = newValue!; }); },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SwitchListTile(
                    title: const Text("Mark as Hot Item"),
                    value: _isFeatured,
                    onChanged: (bool value) { setState(() { _isFeatured = value; }); },
                  ),
                ),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.indigo)),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                            // Kirim ke Django menggunakan postJson
                            final response = await request.postJson(
                                "http://localhost:8000/create-flutter/", 
                                jsonEncode({
                                    "name": _name,
                                    "price": _price.toString(),
                                    "description": _description,
                                    "category": _category,
                                    "stock": 0, 
                                    "thumbnail": _thumbnail,
                                    "is_hot": _isFeatured,
                                }),
                            );
                            
                            if (context.mounted) {
                                if (response['status'] == 'success') {
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                        content: Text("Produk berhasil disimpan!"),
                                    ));
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => MyHomePage()),
                                    );
                                } else {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        content: Text("Gagal: ${response['message']}"),
                                    ));
                                }
                            }
                        }
                      },
                      child: const Text("Save", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}