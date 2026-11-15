
import 'package:flutter/material.dart';
import '../models/cart.dart';
import '../models/product.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sepetim'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: ValueListenableBuilder<List<Product>>(
        valueListenable: cartProducts,
        builder: (context, products, child) {
          if (products.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 80),
                  SizedBox(height: 15),
                  Text('Sepetiniz boş'),
                ],
              ),
            );
          }

          final total = products.fold<double>(
            0,
            (sum, product) => sum + product.price,
          );

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];

                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        leading: Image.asset(
                          product.image,
                          width: 55,
                        ),
                        title: Text(product.name),
                        subtitle: Text(
                          '${product.price.toStringAsFixed(2)} TL',
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            final updated =
                                List<Product>.from(products);
                            updated.removeAt(index);
                            cartProducts.value = updated;
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Toplam: ${total.toStringAsFixed(2)} TL',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
