import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xinyue/model/mall/product_model.dart';

final productsProvider = NotifierProvider<ProductsNotifier, List<Product>>(
  () => ProductsNotifier(),
);

class ProductsNotifier extends Notifier<List<Product>> {
  static const String _productsKey = 'products';

  @override
  List<Product> build() {
    return [];
  }

  Future<void> loadProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final savedProducts = prefs.getString(_productsKey);

    if (savedProducts != null) {
      try {
        final List<dynamic> jsonData = json.decode(savedProducts);
        state = jsonData
            .map(
              (item) => Product(
                id: item['id'] as String,
                imageUrl: item['imageUrl'] as String,
                title: item['title'] as String,
                price: (item['price'] as num).toDouble(),
                sales: item['sales'] as String,
              ),
            )
            .toList();
        return;
      } catch (e) {
        // 如果解析失败，继续加载默认数据
      }
    }

    await _loadDefaultProducts();
  }

  Future<void> _loadDefaultProducts() async {
    try {
      final String jsonString = await rootBundle.loadString(
        'assets/products.json',
      );
      final List<dynamic> jsonData = json.decode(jsonString);

      final List<Product> defaultProducts = jsonData
          .map(
            (item) => Product(
              id: item['id'] as String,
              imageUrl: item['imageUrl'] as String,
              title: item['title'] as String,
              price: (item['price'] as num).toDouble(),
              sales: item['sales'] as String,
            ),
          )
          .toList();

      state = defaultProducts;
      await _saveProducts(jsonData.cast<Map<String, dynamic>>());
    } catch (e) {
      state = [
        Product(
          id: '1',
          imageUrl: 'https://picsum.photos/id/1/300/300',
          title: '商品1',
          price: 99.00,
          sales: '月销100',
        ),
      ];
    }
  }

  Future<void> _saveProducts(List<Map<String, dynamic>> products) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_productsKey, json.encode(products));
  }

  Future<void> addProduct(Product product) async {
    final newProducts = [...state, product];
    state = newProducts;

    final productsMap = newProducts
        .map(
          (p) => {
            'id': p.id,
            'imageUrl': p.imageUrl,
            'title': p.title,
            'price': p.price,
            'sales': p.sales,
          },
        )
        .toList();
    await _saveProducts(productsMap);
  }
}
