import 'package:flutter/widgets.dart';

class AppConfig extends InheritedWidget {
  final String latlon;
  final String lang;

  const AppConfig({
    super.key,
    required this.latlon,
    required this.lang,
    required Widget child,
  }) : super(child: child);

  static AppConfig of(BuildContext context) {
    final AppConfig? res =
        context.dependOnInheritedWidgetOfExactType<AppConfig>();
    assert(res != null, 'No AppConfig found in context');
    return res!;
  }

  @override
  bool updateShouldNotify(covariant AppConfig oldWidget) =>
      latlon != oldWidget.latlon || lang != oldWidget.lang;
}
