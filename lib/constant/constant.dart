import 'package:flutter_dotenv/flutter_dotenv.dart';

final String baseUrl = dotenv.env['API_URL'] ?? "not found";
final String apiKey = dotenv.env['API_KEY'] ?? "Not Found";
final String wsUrl = dotenv.env['WS_URL'] ?? "Not Found";