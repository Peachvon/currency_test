import 'package:flutter/material.dart';
import 'package:currency_test/router.dart' as router;
import 'config/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.mode});
  final String? mode;
  Widget _wrapWithBanner(Widget child) {
    return Banner(
      location: BannerLocation.topStart,
      message: mode!,
      color: Colors.green.withOpacity(0.6),
      textStyle: const TextStyle(
          fontWeight: FontWeight.w700, fontSize: 12.0, letterSpacing: 1.0),
      textDirection: TextDirection.ltr,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      builder: (BuildContext context, Widget? child) {
        final MediaQueryData data = MediaQuery.of(context);
        return MediaQuery(
          data: data.copyWith(textScaleFactor: 1.0),
          child: mode != null ? _wrapWithBanner(child!) : child!,
        );
      },
      title: 'Currency',
      theme: themeApp,
      routerConfig: router.goRouter,
      //home: const HomeScreen(),
    );
  }
}
