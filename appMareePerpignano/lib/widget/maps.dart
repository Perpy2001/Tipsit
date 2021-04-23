import 'package:am029_maree/bloc/navigationBloc.dart';
import 'package:am029_maree/class/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatefulWidget {
  final List<Data> data;

  const Maps({Key key, this.data}) : super(key: key);

  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  BitmapDescriptor costumMarker;
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    setCostumMarker();
    getMarkers();
      }

  Future<void> setCostumMarker() async {
    costumMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/wave.png');
  }



  Set<Marker> getMarkers(){
        for (Data staz in widget.data) {
      setState(() {
        markers.add(Marker(
            icon: costumMarker,
            onTap: () {
              BlocProvider.of<NavigatorBloc>(context)
                  .add(NavigateToStazione(staz));
            },
            markerId: MarkerId(staz.idStazione),
            position:
                LatLng(double.parse(staz.latDDN), double.parse(staz.lonDDE)),
            infoWindow: InfoWindow(
              title: staz.stazione,
              snippet: staz.valore,
            )));
      });
    }
  }

  void _onMapCreated( GoogleMapController controller) {
    for (Data staz in widget.data) {
      setState(() {
        markers.add(Marker(
            icon: costumMarker,
            onTap: () {
              BlocProvider.of<NavigatorBloc>(context)
                  .add(NavigateToStazione(staz));
            },
            markerId: MarkerId(staz.idStazione),
            position:
                LatLng(double.parse(staz.latDDN), double.parse(staz.lonDDE)),
            infoWindow: InfoWindow(
              title: staz.stazione,
              snippet: staz.valore,
            )));
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: GoogleMap(
        mapType: MapType.hybrid,
        onMapCreated: _onMapCreated,
        markers: markers,
        initialCameraPosition: CameraPosition(
          target: LatLng(45.43639875136951, 12.327309251523655),
          zoom: 13,
        ),
      ),
    );
  }
}
