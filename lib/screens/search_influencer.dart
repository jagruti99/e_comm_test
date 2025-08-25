import 'dart:async';
import 'package:e_com_task/model/product_model.dart';
import 'package:flutter/material.dart';
import '../core/api_client.dart';
import '../core/app_config.dart';
import '../core/exception_handler.dart';
import '../widgets/product_tile.dart';
import 'product_detail.dart';

class SearchInfluencerScreen extends StatefulWidget {
  static const route = '/search';
  const SearchInfluencerScreen({super.key});

  @override
  State<SearchInfluencerScreen> createState() => _SearchInfluencerScreenState();
}

class _SearchInfluencerScreenState extends State<SearchInfluencerScreen>
    with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;
  Future<List<Product>>? _future;
  String _lastQuery = '';

  void _onChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      _search(value.trim());
    });
  }

  Future<List<Product>> _fetch(BuildContext ctx, String query) async {
    final cfg = AppConfig.of(ctx);
    final res = await ApiClient().post('restaurant-search', {
      "search": query,
      "category_id": "",
      "latlon": cfg.latlon,
      "user_id": "",
    });
    final data = (res['data'] ?? {}) as Map<String, dynamic>;
    final restaurants = (data['restaurants'] as List?) ?? [];
    final List<Product> results = [];
    for (final r in restaurants) {
      final rMap = r as Map<String, dynamic>;
      final rid = rMap['id'] as int?;
      final rname = (rMap['name'] ?? '').toString();
      final items = (rMap['items'] as List?) ?? [];
      for (final it in items) {
        final p = Product.fromSearchJson(it as Map<String, dynamic>);
        results.add(
          Product(
            id: p.id,
            name: p.name,
            description: p.description,
            image: p.image,
            price: p.price,
            currencyCode: p.currencyCode,
            restaurantId: rid,
            restaurantName: rname,
          ),
        );
      }
    }
    return results;
  }

  void _search(String query) {
    setState(() {
      _lastQuery = query;
      if (query.isEmpty) {
        _future = Future.value(<Product>[]);
      } else {
        _future = _fetch(context, query);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final body = AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      transitionBuilder:
          (child, anim) => FadeTransition(opacity: anim, child: child),
      child:
          (_future == null)
              ? const Center(child: Text('Start typing to search…'))
              : FutureBuilder<List<Product>>(
                future: _future,
                builder: (context, snap) {
                  if (snap.hasError) {
                    return ExceptionHandler.fallback(
                      snap.error!,
                      () => _search(_lastQuery),
                    );
                  }
                  if (!snap.hasData)
                    return const Center(child: CircularProgressIndicator());
                  final data = snap.data!;
                  if (data.isEmpty)
                    return const Center(child: Text('No results'));
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, i) {
                      final p = data[i];
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
                    },
                  );
                },
              ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Semantics(
              label: 'Search field',
              child: TextField(
                controller: _controller,
                onChanged: _onChanged,
                onSubmitted: _onChanged,
                decoration: InputDecoration(
                  hintText: 'Search restaurants or items',
                  prefixIcon: const Icon(Icons.search),
                  border: const OutlineInputBorder(),
                  suffixIcon:
                      _controller.text.isEmpty
                          ? null
                          : IconButton(
                            tooltip: 'Clear text',
                            onPressed: () {
                              _controller.clear();
                              _search('');
                            },
                            icon: const Icon(Icons.clear),
                          ),
                ),
              ),
            ),
          ),
          Expanded(child: body),
        ],
      ),
    );
  }
}
