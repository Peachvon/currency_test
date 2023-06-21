import 'package:currency_test/src/app.dart';
import 'package:currency_test/src/local_storage_model/history_currency_moodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await dotenv.load(fileName: ".env.prod");
  // Initialize hive
  await Hive.initFlutter();
  Hive.registerAdapter(CurrencyLocalstorageModelAdapter());
  runApp(const MyApp());
}
