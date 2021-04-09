


import 'package:am029_maree/class/data.dart';
import 'package:am029_maree/pages/previsioni.dart';
import 'package:am029_maree/pages/stazione.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatelessWidget {
   final List<Data> data;

  const Maps({Key key, this.data}) : super(key: key);


  @override
  Widget build(BuildContext context) {

  Set<Marker> Markers(){
    Set<Marker> markers={};
          for (Data staz in data) {
        markers.add(Marker(
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
      return markers;
  }

    return Container(
      child:Stack(
          children: [
            GoogleMap(
              markers: Markers(),
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