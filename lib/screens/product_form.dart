import 'package:flutter/material.dart';
import 'package:football_shop/widgets/left_drawer.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  // Kunci global untuk Form
  final _formKey = GlobalKey<FormState>();
  
  // Variabel state untuk menyimpan nilai input
  String _name = "";
  int _price = 0;
  String _description = "";
  String _thumbnail = ""; 
  String _category = "Jersey"; // Nilai default untuk dropdown
  bool _isFeatured = false; // Nilai default untuk switch
  
  // Daftar kategori produk untuk Dropdown
  final List<String> _categories = [
    'Jersey',
    'Shoes',
    'Equipment',
    'Accessories',
  ];

  @override
  Widget build(BuildContext context) {
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
        key: _formKey, // Menggunakan form key
        child: SingleChildScrollView(
          // Agar bisa di-scroll jika form-nya panjang
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Beri padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Input Name
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Product Name",
                      labelText: "Product Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _name = value!;
                      });
                    },
                    // Nama tidak boleh kosong
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Name cannot be empty!";
                      }
                      return null;
                    },
                  ),
                ),

                // Input Price
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Price",
                      labelText: "Price",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    // Input hanya angka
                    keyboardType: TextInputType.number, 
                    onChanged: (String? value) {
                      setState(() {
                        _price = int.tryParse(value!) ?? 0;
                      });
                    },
                    // Harga tidak boleh kosong, harus angka, dan tidak boleh negatif
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Price cannot be empty!";
                      }
                      if (int.tryParse(value) == null) {
                        return "Price must be a number!";
                      }
                      if (int.parse(value) <= 0) {
                        return "Price must be positive!";
                      }
                      return null;
                    },
                  ),
                ),

                // Input Description
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Description",
                      labelText: "Description",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    // Deskripsi bisa multi-line
                    maxLines: 5, 
                    onChanged: (String? value) {
                      setState(() {
                        _description = value!;
                      });
                    },
                    // Deskripsi Tidak boleh kosong
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Description cannot be empty!";
                      }
                      return null;
                    },
                  ),
                ),

                // Input Thumbnail URL
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Thumbnail URL (Optional)",
                      labelText: "Thumbnail URL",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _thumbnail = value!;
                      });
                    },
                    // Opsional, tapi jika diisi harus URL
                    validator: (String? value) {
                      if (value != null &&
                          value.isNotEmpty &&
                          !Uri.parse(value).isAbsolute) {
                        return "Must be a valid URL (e.g., https://...)";
                      }
                      return null;
                    },
                  ),
                ),
                
                // Input Category
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: "Category",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    value: _category, // Nilai yang terpilih
                    items: _categories
                        .map((cat) => DropdownMenuItem(
                              value: cat,
                              child: Text(cat),
                            ))
                        .toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _category = newValue!;
                      });
                    },
                  ),
                ),

                // Input Is Featured (Switch)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SwitchListTile(
                    title: const Text("Mark as Featured Product"),
                    value: _isFeatured,
                    onChanged: (bool value) {
                      setState(() {
                        _isFeatured = value;
                      });
                    },
                  ),
                ),

                // Tombol Save
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.indigo),
                      ),
                      onPressed: () {
                        // Validasi form
                        if (_formKey.currentState!.validate()) {
                          // Tampilkan pop-up jika valid
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title:
                                    const Text('Product saved successfully!'),
                                // Menampilkan data yang diisi
                                content: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Name: $_name'),
                                      Text('Price: $_price'),
                                      Text('Description: $_description'),
                                      Text('Category: $_category'),
                                      Text('Thumbnail: $_thumbnail'),
                                      Text(
                                          'Featured: ${_isFeatured ? "Yes" : "No"}'),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Navigator.pop(context); // Tutup dialog
                                      _formKey.currentState!
                                          .reset(); // Reset form
                                      // Reset state manual untuk non-form field
                                      setState(() {
                                        _category = "Jersey";
                                        _isFeatured = false;
                                      });
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: const Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
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