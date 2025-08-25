import 'package:e_com_task/model/influencer.dart';
import 'package:e_com_task/model/product_model.dart';
import 'package:flutter/material.dart';
import '../core/api_client.dart';
import '../core/app_config.dart';
import '../core/exception_handler.dart';
import '../widgets/product_tile.dart';
import 'product_detail.dart';

class InfluencerDetailScreen extends StatefulWidget {
  final Influencer influencer;
  const InfluencerDetailScreen({super.key, required this.influencer});

  @override
  State<InfluencerDetailScreen> createState() => _InfluencerDetailScreenState();
}

class _InfluencerDetailScreenState extends State<InfluencerDetailScreen> {
  late Future<Map<String, dynamic>> _future;

  Future<Map<String, dynamic>> _fetch(BuildContext context) async {
    final cfg = AppConfig.of(context);
    final res = await ApiClient().get(
      'influencer-details?latlon=${cfg!.latlon}&lang=${cfg.lang}&influencer_id=${widget.influencer.id}',
    );

    return res['data'] as Map<String, dynamic>;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _future = _fetch(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: _future,
        builder: (context, snap) {
          if (snap.hasError) {
            return ExceptionHandler.fallback(snap.error!, () {
              setState(() {
                _future = _fetch(context);
              });
            });
          }
          if (!snap.hasData)
            return const Center(child: CircularProgressIndicator());
          final d = snap.data!;
          final banner = (d['banner'] ?? '').toString();
          final image = (d['image'] ?? '').toString();
          final name = (d['name'] ?? '').toString();

          final productsRaw = (d['popular_items'] as List?) ?? [];
          final products =
              productsRaw
                  .map((e) => Product.fromSearchJson(e as Map<String, dynamic>))
                  .toList();

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 220,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(name),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      if (banner.isNotEmpty)
                        Image.network(banner, fit: BoxFit.cover),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Hero(
                            tag: 'influencer_${widget.influencer.id}',
                            child: CircleAvatar(
                              radius: 36,
                              backgroundImage:
                                  image.isNotEmpty ? NetworkImage(image) : null,
                              child:
                                  image.isEmpty
                                      ? const Icon(Icons.person)
                                      : null,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child:
                      products.isEmpty
                          ? Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              'No featured products available.',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          )
                          : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children:
                                  products.map((p) {
                                    return ProductTile(
                                      product: p,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (_) => ProductDetailScreen(
                                                  restaurantId: p.restaurantId,
                                                  productId: p.id,
                                                  productName: p.name,
                                                ),
                                          ),
                                        );
                                      },
                                    );
                                  }).toList(),
                            ),
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
