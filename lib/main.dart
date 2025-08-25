import 'package:flutter/material.dart';
import 'core/app_config.dart';
import 'screens/influencer_list.dart';
import 'screens/search_influencer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppConfig(
      latlon: "29.3677642,47.9705378",
      lang: "en",
      child: MaterialApp(
        title: 'Flutter-task',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.teal,
          brightness: Brightness.light,
        ),
        home: const InfluencerListScreen(),
        routes: {
          SearchInfluencerScreen.route: (_) => const SearchInfluencerScreen(),
        },
      ),
    );
  }
}
