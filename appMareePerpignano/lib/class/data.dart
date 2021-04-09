
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