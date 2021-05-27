import 'package:flutter/material.dart';

Future<T?> goto<T>(BuildContext context, Widget page) {
  return Navigator.of(context).push<T>(MaterialPageRoute(builder: (_) => page));
}
