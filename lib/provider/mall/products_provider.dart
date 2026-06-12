import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xinyue/api/mall/product_api.dart';
import 'package:xinyue/framework/net/http_response.dart';
import 'package:xinyue/model/mall/product_model.dart';

final productsProvider = NotifierProvider<ProductsNotifier, List<Product>>(
  () => ProductsNotifier(),
);

class ProductsNotifier extends Notifier<List<Product>> {
  static const String _productsKey = 'products';
  final ProductApi _productApi = ProductApi();

  @override
  List<Product> build() {
    return [];
  }

  Future<void> loadProducts() async {
    // 优先尝试网络请求
    final networkResponse = await _fetchProductsFromNetwork();
    if (networkResponse.success && networkResponse.data != null) {
      state = networkResponse.data!;
      await _saveProducts(state);
      return;
    }

    // 网络请求失败，尝试本地缓存
    final cachedProducts = await _loadProductsFromCache();
    if (cachedProducts.isNotEmpty) {
      state = cachedProducts;
      return;
    }

    // 最后加载默认数据
    await _loadDefaultProducts();
  }

  /// 从网络获取商品数据
  Future<void> refreshProducts() async {
    final response = await _fetchProductsFromNetwork();
    if (response.success && response.data != null) {
      state = response.data!;
      await _saveProducts(state);
    }
  }

  /// 加载更多商品
  Future<void> loadMoreProducts() async {
    final page = (state.length ~/ 20) + 1;
    final response = await _productApi.getProducts(page: page);

    if (response.success && response.data != null) {
      final newProducts = response.data!;
      if (newProducts.isNotEmpty) {
        state = [...state, ...newProducts];
        await _saveProducts(state);
      }
    }
  }

  /// 从网络获取商品
  Future<MHttpResponse<List<Product>>> _fetchProductsFromNetwork() async {
    try {
      return await _productApi.getProducts();
    } catch (e) {
      return MHttpResponse.error(code: -1, message: e.toString());
    }
  }

  /// 从缓存加载商品
  Future<List<Product>> _loadProductsFromCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedProducts = prefs.getString(_productsKey);

      if (savedProducts != null) {
        final List<dynamic> jsonData = json.decode(savedProducts);
        return jsonData
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
      }
    } catch (e) {
      // 忽略解析错误
    }
    return [];
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
      await _saveProducts(state);
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

  Future<void> _saveProducts(List<Product> products) async {
    final prefs = await SharedPreferences.getInstance();
    final productsMap = products
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
    await prefs.setString(_productsKey, json.encode(productsMap));
  }

  Future<void> addProduct(Product product) async {
    final newProducts = [...state, product];
    state = newProducts;
    await _saveProducts(state);
  }

  Future<void> updateProduct(String id, Product updatedProduct) async {
    final newProducts = state
        .map((p) => p.id == id ? updatedProduct : p)
        .toList();
    state = newProducts;
    await _saveProducts(state);
  }

  Future<void> deleteProduct(String id) async {
    final newProducts = state.where((p) => p.id != id).toList();
    state = newProducts;
    await _saveProducts(state);
  }
}
