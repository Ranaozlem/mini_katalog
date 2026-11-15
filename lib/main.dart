
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/product.dart';
import 'pages/product_detail_page.dart';
import 'models/cart.dart';
import 'pages/cart_page.dart';

void main() {
  runApp(const MiniKatalogApp());
}

class MiniKatalogApp extends StatelessWidget {
  const MiniKatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Katalog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),

onGenerateRoute: (settings) {
  if (settings.name == '/product') {
    final product = settings.arguments;

    if (product is Product) {
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => ProductDetailPage(
          product: product,
        ),
      );
    }
  }

  return null;
},




    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final Future<List<Product>> productsFuture;
  String searchQuery = '';
  String selectedCategory = 'Tümü';

  @override
  void initState() {
    super.initState();
    productsFuture = loadProducts();
  }

  Future<List<Product>> loadProducts() async {
    final jsonString = await rootBundle.loadString(
      'assets/data/products.json',
    );

    final List<dynamic> jsonData = jsonDecode(jsonString);

    return jsonData
        .map(
          (item) => Product.fromJson(
            item as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mini Katalog'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,

actions: [

ValueListenableBuilder<List<Product>>(
  valueListenable: cartProducts,
  builder: (context, products, child) {
    return IconButton(
      icon: Badge(
        label: Text('${products.length}'),
        isLabelVisible: products.isNotEmpty,
        child: const Icon(Icons.shopping_cart),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CartPage(),
          ),
        );
      },
    );
  },
),

  DropdownButton<String>(
    value: selectedCategory,
    dropdownColor: Colors.indigo,
    style: const TextStyle(color: Colors.white),
    iconEnabledColor: Colors.white,
    underline: const SizedBox(),
    items: ['Tümü', 'Elektronik', 'Giyim', 'Aksesuar']
        .map((category) {
      return DropdownMenuItem<String>(
        value: category,
        child: Text(category),
      );
    }).toList(),
    onChanged: (value) {
      if (value != null) {
        setState(() {
          selectedCategory = value;
        });
      }
    },
  ),
  const SizedBox(width: 16),
],


bottom: PreferredSize(
  preferredSize: const Size.fromHeight(65),
  child: Padding(
    padding: const EdgeInsets.all(8),
    child: TextField(
      onChanged: (value) {
        setState(() {
          searchQuery = value;
        });
      },
      decoration: const InputDecoration(
        hintText: 'Ürün ara...',
        prefixIcon: Icon(Icons.search),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(),
      ),
    ),
  ),
),

      ),
      body: FutureBuilder<List<Product>>(
        future: productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Ürünler yüklenemedi: ${snapshot.error}',
              ),
            );
          }

          final products = snapshot.data ?? [];


final filteredProducts = products.where((product) {
  final matchesSearch = product.name
      .toLowerCase()
      .contains(searchQuery.toLowerCase().trim());

  final matchesCategory =
      selectedCategory == 'Tümü' ||
      product.category == selectedCategory;

  return matchesSearch && matchesCategory;
}).toList();



          if (products.isEmpty) {
            return const Center(
              child: Text('Henüz ürün bulunmuyor.'),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: filteredProducts.length,
            gridDelegate:
                const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 260,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.85,
            ),
            itemBuilder: (context, index) {
             final product = filteredProducts[index];

              
return GestureDetector(
  onTap: () {
    Navigator.pushNamed(
      context,
      '/product',
      arguments: product,
    );
  },
  child: Card(

                elevation: 3,
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    
Expanded(
  child: Padding(
    padding: const EdgeInsets.all(12),
    child: Image.asset(
      product.image,
      fit: BoxFit.contain,
    ),
  ),
),

                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Text(
                            product.name,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(product.category),
                          const SizedBox(height: 8),
                          Text(
                            '${product.price.toStringAsFixed(2)} TL',
                            style: const TextStyle(
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ), // Card
             ); // GestureDetector
            },
          );
        },
      ),
    );
  }
}
