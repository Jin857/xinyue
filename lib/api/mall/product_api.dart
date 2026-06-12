import 'package:xinyue/framework/net/api_service.dart';
import 'package:xinyue/framework/net/http_response.dart';
import 'package:xinyue/framework/net/http_config.dart';
import 'package:xinyue/model/mall/product_model.dart';

/// 商品 API 服务
class ProductApi extends ApiService {
  static final ProductApi _instance = ProductApi._internal();

  factory ProductApi() => _instance;

  ProductApi._internal();

  /// 获取商品列表
  Future<MHttpResponse<List<Product>>> getProducts({
    int page = 1,
    int pageSize = 20,
  }) async {
    final response = await request<Map<String, dynamic>>(
      ApiPath.products,
      queryParameters: {'page': page, 'pageSize': pageSize},
    );

    if (response.success && response.data != null) {
      final List<dynamic> dataList = response.data!['list'] ?? [];
      final List<Product> products = dataList
          .map((item) => Product.fromJson(item as Map<String, dynamic>))
          .toList();
      return MHttpResponse.success(data: products);
    } else {
      return MHttpResponse.error(
        code: response.code,
        message: response.message,
      );
    }
  }

  /// 获取商品详情
  Future<MHttpResponse<Product>> getProductDetail(String id) async {
    final path = ApiPath.productDetail.replaceAll('{id}', id);
    final response = await request<Map<String, dynamic>>(path);

    if (response.success && response.data != null) {
      final product = Product.fromJson(response.data!);
      return MHttpResponse.success(data: product);
    } else {
      return MHttpResponse.error(
        code: response.code,
        message: response.message,
      );
    }
  }

  /// 搜索商品
  Future<MHttpResponse<List<Product>>> searchProducts({
    required String keyword,
    int page = 1,
    int pageSize = 20,
  }) async {
    final response = await request<Map<String, dynamic>>(
      '${ApiPath.products}/search',
      queryParameters: {'keyword': keyword, 'page': page, 'pageSize': pageSize},
    );

    if (response.success && response.data != null) {
      final List<dynamic> dataList = response.data!['list'] ?? [];
      final List<Product> products = dataList
          .map((item) => Product.fromJson(item as Map<String, dynamic>))
          .toList();
      return MHttpResponse.success(data: products);
    } else {
      return MHttpResponse.error(
        code: response.code,
        message: response.message,
      );
    }
  }
}
