import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/earnings_data.dart';

class ApiService {
  final String baseUrl = 'https://api.api-ninjas.com/v1/';
  final String apiKey = ''//Your API key

  Future<List<EarningsData>> fetchEarningsData(String ticker) async {
    final response = await http.get(Uri.parse('$baseUrl/earningscalendar?ticker=$ticker'),
      headers: {
        'X-API-Key': apiKey,
      });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((json) => EarningsData.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load earnings data');
    }
  }

  Future<String> fetchTranscript(String ticker, int quarter, int year) async {
    final response = await http.get(Uri.parse('$baseUrl/earningstranscript?ticker=$ticker&quarter=$quarter&year=$year'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['transcript'];
    } else {
      throw Exception('Failed to load transcript');
    }
  }
}
