import 'package:am029_maree/bloc/navigationBloc.dart';
import 'package:am029_maree/class/data.dart';
import 'package:am029_maree/pages/previsioni.dart';
import 'package:am029_maree/pages/stazione.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatelessWidget {
  final List<Data> data;

  const Maps({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Set<Marker> markers() {
      Set<Marker> markers = {};
      for (Data staz in data) {
        markers.add(Marker(
            onTap: () {
   BlocProvider.of<NavigatorBloc>(context).add(NavigateToStazione(staz));
            },
            markerId: MarkerId(staz.idStazione),
            position:
                LatLng(double.parse(staz.latDDN), double.parse(staz.lonDDE)),
            infoWindow: InfoWindow(
              title: staz.stazione,
              snippet: staz.valore,
            )));
      }
      return markers;
    }

    return Container(
     
      
        child:  GoogleMap(
            markers: markers(),
            initialCameraPosition: CameraPosition(
              target: LatLng(45.43639875136951, 12.327309251523655),
              zoom: 13,
            ),
          ),
    );
  }
}
