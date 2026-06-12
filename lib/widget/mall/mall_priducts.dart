import 'dart:io';
import 'package:cached_network_image_ce/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:xinyue/framework/refresh/app_easy_refresh.dart';
import 'package:xinyue/model/mall/product_model.dart';
import 'package:xinyue/provider/mall/products_provider.dart';
import 'product_card.dart';

class MallPriducts extends ConsumerStatefulWidget {
  final GlobalKey<MallPriductsState> key;
  const MallPriducts({required this.key}) : super(key: key);

  @override
  ConsumerState<MallPriducts> createState() => MallPriductsState();
}

extension MallPriductsExtension on GlobalKey<MallPriductsState> {
  void pickImage() => currentState?._pickImage();
}

class MallPriductsState extends ConsumerState<MallPriducts> {
  final List<File> _localImages = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    ref.read(productsProvider.notifier).loadProducts();
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _localImages.add(File(pickedFile.path));
      });
    }
  }

  void _showPhotoView(ImageProvider imageProvider) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          backgroundColor: Colors.black,
          body: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Center(
              child: PhotoView(
                imageProvider: imageProvider,
                backgroundDecoration: const BoxDecoration(color: Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 下拉刷新（从网络重新获取）
  Future<void> _onRefresh() async {
    await ref.read(productsProvider.notifier).refreshProducts();
  }

  /// 上拉加载更多（从网络加载下一页）
  Future<void> _onLoad() async {
    await ref.read(productsProvider.notifier).loadMoreProducts();
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productsProvider);

    return Container(
      color: Colors.grey.shade50,
      child: Column(
        children: [
          if (_localImages.isNotEmpty)
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _localImages.length,
                itemBuilder: (context, index) {
                  final file = _localImages[index];
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: GestureDetector(
                      onTap: () => _showPhotoView(FileImage(file)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          file,
                          width: 100,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          Expanded(
            child: AppEasyRefreshStateful(
              initialRefresh: false,
              enablePullDown: true,
              enablePullUp: true,
              onRefresh: _onRefresh,
              onLoad: _onLoad,
              child: GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductCard(
                    product: product,
                    onTap: () => _showPhotoView(
                      CachedNetworkImageProvider(product.imageUrl),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
