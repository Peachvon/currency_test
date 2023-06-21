import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class BaseApiService {
  final String? baseUrl = dotenv.env['URL_API'];
  Future<dynamic> getResponse(String url);
}
