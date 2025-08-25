import 'package:flutter/material.dart';
import '../widgets/error_fallback.dart';

class ExceptionHandler {
  static Widget fallback(Object error, VoidCallback onRetry) {
    return ErrorFallbackWidget(message: error.toString(), onRetry: onRetry);
  }
}
