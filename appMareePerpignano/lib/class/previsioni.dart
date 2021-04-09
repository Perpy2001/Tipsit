
class Previsione {
  String dATAPREVISIONE;
  String dATAESTREMALE;
  String tIPOESTREMALE;
  String vALORE;
  String tITOLO;
  String vIGNETTA;
  String dEFAULTVIGNETTA;

  Previsione(
      {this.dATAPREVISIONE,
      this.dATAESTREMALE,
      this.tIPOESTREMALE,
      this.vALORE,
      this.tITOLO,
      this.vIGNETTA,
      this.dEFAULTVIGNETTA});

  // a factory named constructor
  factory Previsione.fromJson(Map<String, dynamic> json) {
    return Previsione(
      dATAPREVISIONE: json['DATA_PREVISIONE'] as String,
      dATAESTREMALE: json['DATA_ESTREMALE'] as String,
      tIPOESTREMALE: json['TIPO_ESTREMALE'] as String,
      vALORE: json['VALORE'] as String,
      tITOLO: json['TITOLO'] as String,
      vIGNETTA: json['VIGNETTA'] as String,
      dEFAULTVIGNETTA: json['DEFAULT_VIGNETTA'] as String
    );
  }
}
