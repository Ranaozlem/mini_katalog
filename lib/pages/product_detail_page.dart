
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/cart.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ürün Detayı'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(20),
              ),
              
child: Padding(
  padding: const EdgeInsets.all(16),
  child: Image.asset(
    product.image,
    fit: BoxFit.contain,
  ),
),

            ),
            const SizedBox(height: 24),

            Text(
              product.name,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            Chip(
              label: Text(product.category),
            ),
            const SizedBox(height: 16),

            Text(
              '${product.price.toStringAsFixed(2)} TL',
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 25),

            const Text(
              'Ürün Açıklaması',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            Text(
              product.description,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
         

const SizedBox(height: 30),

SizedBox(
  width: double.infinity,
  child: ElevatedButton.icon(
    onPressed: () {
      addToCart(product);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${product.name} sepete eklendi!'),
        ),
      );
    },
    icon: const Icon(Icons.shopping_cart),
    label: const Text('Sepete Ekle'),
  ),
),

], // children
), // Column

      ),
    );
  }
}
