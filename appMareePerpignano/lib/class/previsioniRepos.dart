import 'package:am029_maree/class/previsioni.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PrevisioniRepo{
  static Future<List<Previsione>> fetchPrevisioniList() async {
  final response = await http.get(
      'https://dati.venezia.it/sites/default/files/dataset/opendata/previsione.json');
  if (response.statusCode == 200) {
    // final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    // avendo una lista di json, non un oggetto json possiamo usare anche il seguente
    final parsed = json.decode(response.body);
    // print('body parsed $parsed');
    return parsed.map<Previsione>((json) => Previsione.fromJson(json)).toList();
  } else {
    throw Exception('Failed to get Data');
  }
}
}