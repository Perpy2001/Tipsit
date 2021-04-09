import 'dart:async';

import 'package:am029_maree/bloc/dataBloc.dart';
import 'package:am029_maree/class/data.dart';
import 'package:am029_maree/pages/previsioni.dart';
import 'package:am029_maree/pages/stazione.dart';
import 'package:am029_maree/widget/maps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'class/dataRepos.dart';

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
  DataBloc dataBloc;

  Timer timer;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  // Set<Marker> _markers = {};
  // List<Data> data;
/*
  Future<void> getData() async {
    data = await DataRepo.fetchDataList();
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
*/
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
    dataBloc = DataBloc(DataRepo());
    dataBloc.add(FetchData());
    // getData();
    //  timer = Timer.periodic(Duration(minutes: 1), (Timer t) => getData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocProvider(
          create: (BuildContext context) => dataBloc,
          child: BlocBuilder<DataBloc, DataState>(
            builder: (context, state) {
              if (state is DataNotLoaded) {
                return Text("acesso al server");
              } else if (state is DataLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is DataLoaded) {
                return Maps(
                  data: state.getData,
                );
              } else
                return Text("Error");
            },
          )),
    );
  }
}
