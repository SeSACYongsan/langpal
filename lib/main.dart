import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpal/router.dart';

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp.router(
        routerConfig: router,
        title: "Langpal",
        theme: ThemeData(
          fontFamily: "CookieRun",
        ),
      ),
    ),
  );
}
