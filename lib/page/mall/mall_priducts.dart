import 'dart:io';
import 'package:cached_network_image_ce/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';

class MallPriducts extends StatefulWidget {
  final GlobalKey<MallPriductsState> key;
  const MallPriducts({required this.key}) : super(key: key);

  @override
  State<MallPriducts> createState() => MallPriductsState();
}

extension MallPriductsExtension on GlobalKey<MallPriductsState> {
  void pickImage() => currentState?._pickImage();
}

class MallPriductsState extends State<MallPriducts> {
  // 存储用户通过 image_picker 选择的本地图片
  final List<File> _localImages = [];

  // 网络图片数据（示例：来自 picsum.photos 的 20 张随机图片）
  final List<String> _networkImageUrls = List.generate(
    20,
    (index) => 'https://picsum.photos/id/${index + 10}/${index * 100}/500',
  );

  final ImagePicker _picker = ImagePicker();

  /// 从相册选择图片，添加到本地列表
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

  /// 显示全屏图片查看器（支持本地/网络图片）
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ---------- 本地图片区域 ----------
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
        // ---------- 网络图片瀑布流 ----------
        Expanded(
          child: MasonryGridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 两列瀑布流
            ),
            itemCount: _networkImageUrls.length,
            itemBuilder: (context, index) {
              final url = _networkImageUrls[index];
              return GestureDetector(
                onTap: () => _showPhotoView(CachedNetworkImageProvider(url)),
                child: Card(
                  margin: const EdgeInsets.all(6),
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: url,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: Colors.grey.shade200,
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                    errorBuilder: (context, url, error) => Container(
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.broken_image, size: 40),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
