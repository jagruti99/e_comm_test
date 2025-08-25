import 'package:e_com_task/model/product_model.dart';
import 'package:flutter/material.dart';
import '../core/api_client.dart';
import '../core/exception_handler.dart';

class ProductDetailScreen extends StatefulWidget {
  final int? restaurantId;
  final String productId;
  final String productName;

  const ProductDetailScreen({
    super.key,
    required this.restaurantId,
    required this.productId,
    required this.productName,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late Future<Map<String, dynamic>> _future;

  Future<Map<String, dynamic>> _fetch() async {
    if (widget.restaurantId == null) {
      throw Exception('Missing restaurant id for product details.');
    }
    final res = await ApiClient().post(
      'restaurant-detail-v2?id=${widget.restaurantId}',
      {
        "search": "",
        "category_id": "",
        "latlon": "29.3677642,47.9705378",
        "user_id": "",
      },
    );
    return (res['data'] as Map<String, dynamic>);
  }

  @override
  void initState() {
    super.initState();
    _future = _fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.productName)),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _future,
        builder: (context, snap) {
          if (snap.hasError) {
            return ExceptionHandler.fallback(snap.error!, () {
              setState(() {
                _future = _fetch();
              });
            });
          }
          if (!snap.hasData)
            return const Center(child: CircularProgressIndicator());
          final data = snap.data!;
          final restaurantName = (data['name'] ?? '').toString();
          final banner = (data['banner'] ?? '').toString();

          final items = (data['items_list'] as List?) ?? [];
          final products =
              items
                  .map(
                    (e) => Product.fromDetailJson(
                      e as Map<String, dynamic>,
                      restaurantId: widget.restaurantId,
                      restaurantName: restaurantName,
                    ),
                  )
                  .toList();

          final idx = products.indexWhere((p) => p.id == widget.productId);
          final selected =
              (idx >= 0)
                  ? products[idx]
                  : (products.isNotEmpty ? products.first : null);

          if (selected == null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text('Product not found in restaurant menu.'),
              ),
            );
          }

          final images = <String>[
            if (banner.isNotEmpty) banner,
            if (selected.image.isNotEmpty) selected.image,
          ];

          return LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 700;
              final details = _Details(
                selected: selected,
                restaurantName: restaurantName,
              );

              if (isWide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: _Carousel(images: images)),
                    Expanded(flex: 2, child: details),
                  ],
                );
              } else {
                return ListView(
                  padding: EdgeInsets.zero,
                  children: [_Carousel(images: images), details],
                );
              }
            },
          );
        },
      ),
    );
  }
}

class _Carousel extends StatefulWidget {
  final List<String> images;
  const _Carousel({required this.images});

  @override
  State<_Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<_Carousel> {
  final PageController _pc = PageController();

  @override
  void dispose() {
    _pc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imgs = widget.images.isNotEmpty ? widget.images : [''];
    return SizedBox(
      height: 280,
      child: PageView.builder(
        controller: _pc,
        itemCount: imgs.length,
        itemBuilder: (context, i) {
          final src = imgs[i];
          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).colorScheme.surfaceVariant,
            ),
            clipBehavior: Clip.antiAlias,
            child:
                src.isEmpty
                    ? const Center(child: Icon(Icons.image, size: 64))
                    : Image.network(src, fit: BoxFit.cover),
          );
        },
      ),
    );
  }
}

class _Details extends StatelessWidget {
  final Product selected;
  final String restaurantName;
  const _Details({required this.selected, required this.restaurantName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                selected.name,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                'From: $restaurantName',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              Text(
                selected.description.isEmpty
                    ? 'No description provided.'
                    : selected.description,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              Text(
                'Price: ${selected.currencyCode} ${selected.price.toStringAsFixed(3)}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.shopping_cart_outlined),
                      label: const Text('Add to cart'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
