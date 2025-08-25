import 'package:e_com_task/model/influencer.dart';
import 'package:flutter/material.dart';
import '../core/api_client.dart';
import '../core/exception_handler.dart';
import '../core/app_config.dart';
import '../widgets/influencer_card.dart';
import 'influencer_detail.dart';
import 'search_influencer.dart';

class InfluencerListScreen extends StatefulWidget {
  const InfluencerListScreen({super.key});

  @override
  State<InfluencerListScreen> createState() => _InfluencerListScreenState();
}

class _InfluencerListScreenState extends State<InfluencerListScreen> {
  late Future<List<Influencer>> _future;

  Future<List<Influencer>> _fetch(BuildContext context) async {
    final cfg = AppConfig.of(context);
    final res = await ApiClient().post(
      'influencer-listing?latlon=${cfg.latlon}&lang=${cfg.lang}',
      {
        "filter": {"categories": ""},
      },
    );
    final list = ((res['data'] ?? {})['influencer'] as List?) ?? [];
    return list.map((e) => Influencer.fromJson(e)).toList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _future = _fetch(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Influencers'),
        actions: [
          IconButton(
            tooltip: 'Search products / restaurants',
            icon: const Icon(Icons.search),
            onPressed:
                () =>
                    Navigator.pushNamed(context, SearchInfluencerScreen.route),
          ),
        ],
      ),
      body: FutureBuilder<List<Influencer>>(
        future: _future,
        builder: (context, snap) {
          if (snap.hasError) {
            return ExceptionHandler.fallback(snap.error!, () {
              setState(() {
                _future = _fetch(context);
              });
            });
          }
          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snap.data!;
          if (data.isEmpty) {
            return const Center(child: Text('No influencers found'));
          }
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, i) {
              final it = data[i];
              return InfluencerCard(
                data: it,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => InfluencerDetailScreen(influencer: it),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
