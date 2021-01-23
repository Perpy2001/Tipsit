# am029_maree

Già esiste sul Play Store un app similare, noi qui la realizziamo a scopo didattico con Flutter: l'app va a rilevare l'altezza maree delle stazioni sparse per la laguna di Venezia.

## i dati

Vengono forniti [qui](http://dati.venezia.it/sites/default/files/dataset/opendata/livello.json): un array json (vedi seguito).

## il client web

Le riechiete `http` vengono descritte nel file `data.dart`. Dalla documentazioni abbimo preso in esame la seguente [guida](https://flutter.dev/docs/cookbook/networking/background-parsing) dove si intende lavorare, a differenza di quanto facciamo noi, su un *isolate* a parte. Usiamo il plugin [http](https://pub.dev/packages/http). Il metodo *asincrono* che utilizzaimo è il seguente
``` dart
Future<List<Data>> fetchDataList() async {
  final response =
      await http.get('http://dati.venezia.it/sites/default/files/dataset/opendata/livello.json');
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    return parsed.map<Data>((json) => Data.fromJson(json)).toList();
  } else {
    throw Exception('Failed to get Data');
  }
}
```
ogni stazione fornisce un oggetto `Data`. Con
``` dart
parsed.map<Data>(json -> f(json))
```
prendiamo la lista di *json* la trasformiamo in un `Iterable` che convertiamo in `List>Data>` (non confondere con omonimo metodo di `Map`). 

## il model

Il model
``` dart
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

  Data({
    this.ordine, 
    this.idStazione, 
    this.stazione,
    this.nomeAbbr,
    this.latDMSN,
    this.lonDMSE,
    this.latDDN,
    this.lonDDE,
    this.data,
    this.valore
    });
  

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
      valore: json['valore'] as String
      );
  }
}
```
lo otteniamo usando la pagina web https://javiercbk.github.io/json_to_dart/ aggiungendo per precauzione `as String` in modo da controllare il `dynamic`!


## snesori

Come nell'esempio precedente usaimo il plugin [sensors](https://pub.dev/packages/http).

## app definitiva

Dopo aver aggiunto ad `AndroidManifest.xml` i seguenti permessi
```
<uses-permission android:name="android.permission.INTERNET"/>
```
possiamo dare da terminale
```
flutter run --release
```
