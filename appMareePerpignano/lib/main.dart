import 'dart:async';


import 'package:am029_maree/previsioni.dart';
import 'package:am029_maree/stazione.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


import 'data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'APP MAREE',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'APP MAREE'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Set<Marker> _markers = {};
  List<Data> data;
  Timer timer;
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<void> getData() async {
    data = await fetchDataList();
    setState(() {
      for (Data staz in data) {
        _markers.add(Marker(
            onTap: () {
              return Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Stazione(data: staz)));
            },
            markerId: MarkerId(staz.idStazione),
            position:
                LatLng(double.parse(staz.latDDN), double.parse(staz.lonDDE)),
            infoWindow: InfoWindow(
              title: staz.stazione,
              snippet: staz.valore,
            )));
      }
    });
  }

  /*void _setMarkerIcon() async {
    _markerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/bb.png');
  }*/

  /*Future<void> _onMapCreated(GoogleMapController contr) async {
    await getData();
  }*/

  @override
  void initState() {
    super.initState();

    getData();
    timer = Timer.periodic(Duration(minutes: 1), (Timer t) => getData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          GoogleMap(
            markers: _markers,
            initialCameraPosition: CameraPosition(
              target: LatLng(45.43639875136951, 12.327309251523655),
              zoom: 13,
            ),
          ),
                    Positioned(
              top: MediaQuery.of(context).size.width * 0.055,
              right: MediaQuery.of(context).size.width * 0.045,
              child: IconButton(
                iconSize: 40,
                onPressed: () {
                  return Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Previsioni()));
                },
                icon: Icon(
                  
                  Icons.assessment_rounded,
                  color:Colors.black,
                ),
              )),
          Positioned(
              top: MediaQuery.of(context).size.width * 0.05,
              right: MediaQuery.of(context).size.width * 0.05,
              child: IconButton(
                iconSize: 40,
                onPressed: () {
                  return Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Previsioni()));
                },
                icon: Icon(
                  
                  Icons.assessment_rounded,
                  color:Color(0xff23b6e6),
                ),
              )),

        ],
      ),
    );
  }
}
