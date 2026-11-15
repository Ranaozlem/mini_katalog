
import 'package:flutter/foundation.dart';
import 'product.dart';

// Sepete eklenen ürünleri tutar.
final ValueNotifier<List<Product>> cartProducts =
    ValueNotifier<List<Product>>([]);

// Yeni ürün ekleme işlemi.
void addToCart(Product product) {
  cartProducts.value = [
    ...cartProducts.value,
    product,
  ];
}
