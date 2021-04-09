import 'dart:convert';
import 'package:am029_maree/class/data.dart';
import 'package:http/http.dart' as http;


class DataRepo{
  static Future<List<Data>> fetchDataList() async {
  final response = await http.get(
      'https://dati.venezia.it/sites/default/files/dataset/opendata/livello.json');
  if (response.statusCode == 200) {
    // final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    // avendo una lista di json, non un oggetto json possiamo usare anche il seguente
    final parsed = json.decode(response.body);
     //print('body parsed $parsed');
    return parsed.map<Data>((json) => Data.fromJson(json)).toList();
  } else {
    throw Exception('Failed to get Data');
  }
}

}



