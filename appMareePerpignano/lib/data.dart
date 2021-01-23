import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Data>> fetchDataList() async {
  final response = await http.get(
      'http://dati.venezia.it/sites/default/files/dataset/opendata/livello.json');
  if (response.statusCode == 200) {
    // final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    // avendo una lista di json, non un oggetto json possiamo usare anche il seguente
    final parsed = json.decode(response.body);
    // print('body parsed $parsed');
    return parsed.map<Data>((json) => Data.fromJson(json)).toList();
  } else {
    throw Exception('Failed to get Data');
  }
}

class Data {

  final String ordine;
  final String idStazione;
  final String stazione;
  final String nomeAbbr;
  final String latDMSN;
  final String lonDMSE;
  final String latDDN;
  final String lonDDE;
  final String data;
  final String valore;

  Data(
      {this.ordine,
      this.idStazione,
      this.stazione,
      this.nomeAbbr,
      this.latDMSN,
      this.lonDMSE,
      this.latDDN,
      this.lonDDE,
      this.data,
      this.valore});

  // getter
  double get valoreDouble => double.parse(valore.split(' ')[0]);

  // a factory named constructor
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
        ordine: json['ordine'] as String,
        idStazione: json['ID_stazione'] as String,
        stazione: json['stazione'] as String,
        nomeAbbr: json['nome_abbr'] as String,
        latDMSN: json['latDMSN'] as String,
        lonDMSE: json['lonDMSE'] as String,
        latDDN: json['latDDN'] as String,
        lonDDE: json['lonDDE'] as String,
        data: json['data'] as String,
        valore: json['valore'] as String);
  }
}
