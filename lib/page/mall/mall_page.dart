import 'package:flutter/material.dart';
import 'mall_priducts.dart';

class MallPage extends StatelessWidget {
  final BuildContext scaffoldContext;
  final GlobalKey<MallPriductsState> _productsKey = GlobalKey();
  MallPage({super.key, required this.scaffoldContext});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              expandedHeight: 250.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  "https://picsum.photos/id/${30}/${500}/500",
                  fit: BoxFit.cover,
                ),
              ),
              leading: IconButton(
                icon: Icon(Icons.person_2, color: Colors.black),
                onPressed: () {
                  Scaffold.of(scaffoldContext).openDrawer();
                },
              ),
            ),
          ];
        },
        body: MallPriducts(key: _productsKey),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _productsKey.pickImage(),
        child: const Icon(Icons.add_photo_alternate),
      ),
    );
  }
}
