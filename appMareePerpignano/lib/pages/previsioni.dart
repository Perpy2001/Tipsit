import 'package:am029_maree/class/dataRepos.dart';
import 'package:am029_maree/class/previsioni.dart';
import 'package:am029_maree/class/previsioniRepos.dart';
import 'package:am029_maree/class/tielsData.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Previsioni extends StatefulWidget {
  Previsioni({Key key}) : super(key: key);

  @override
  _PrevisioniState createState() => _PrevisioniState();
}

class _PrevisioniState extends State<Previsioni> {
  List<FlSpot> _getSpots(List<Previsione> data) {
    List<FlSpot> spots =[];
    int i = 0;
    for (Previsione p in data) {
      spots.add(FlSpot(i.toDouble(), double.parse(p.vALORE)));
      i++;
    }
    return spots;
  }
  
double _nMaxX(int length) {
  if(zoom==1){
    return (length-1).toDouble();
  }
   return (length/zoom);
}

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(0, 0, 70, 100),
        appBar: AppBar(),
        body: Center(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ' Previsioni',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 60,
                      fontWeight: FontWeight.w900),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    
                    Text(
                      'Canal Grande',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontWeight: FontWeight.w900),
                    ),
                    Text(
                      '.',
                      style: TextStyle(
                          color: Color(0xff02d39a),
                          fontSize: 50,
                          fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
                Container(
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.all(Radius.circular(20)),
                   color: Color.fromRGBO(0, 0, 100, 100),
                 ),
                 width: MediaQuery.of(context).size.width * 0.98,
                height: MediaQuery.of(context).size.height * 0.60,
                 child: FutureBuilder(
                   future: PrevisioniRepo.fetchPrevisioniList(),
                   builder: (BuildContext context, AsyncSnapshot snapshot) {
                     if (snapshot.hasData) {
                       return LineChart(LineChartData(
                           lineTouchData: LineTouchData(
                             enabled: true,
                             touchTooltipData: LineTouchTooltipData(
                      tooltipBgColor: Colors.blueAccent,
                      getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                        return touchedBarSpots.map((barSpot) {
                          return LineTooltipItem(
                           DateTime.parse(snapshot.data[(barSpot.x).toInt()].dATAESTREMALE).hour.toString().padLeft(2, '0') +
      ':' +
      DateTime.parse(snapshot.data[(barSpot.x).toInt()].dATAESTREMALE).minute.toString().padLeft(2, '0') +'\n${barSpot.y}cm',
                            const TextStyle(color: Colors.white),
                          );
                        }).toList();
                      }),
                           ),
                           titlesData:
                               LineTitles.getTitleData(snapshot.data, zoom),
                           minX: 0,
                           maxX: _nMaxX(snapshot.data.length),
                           
                           minY: -50,
                           maxY: 200,
                           gridData: FlGridData(
                             getDrawingHorizontalLine: (value) {
                               return FlLine(
                                 color: Colors.blue,
                                 strokeWidth: 2,
                               );
                             },
                             drawHorizontalLine: false,
                             drawVerticalLine: false,
                             getDrawingVerticalLine: (value) {
                               return FlLine(
                                 color: Colors.blue,
                                 strokeWidth: 1,
                               );
                             },
                           ),
                           borderData: FlBorderData(
                               show: false,
                               border:
                                   Border.all(color: Colors.blue, width: 1)),
                           lineBarsData: [
                             LineChartBarData(
                                 belowBarData: BarAreaData(
                                     show: true,
                                     colors: [
                                       Color(0xff23b6e6).withOpacity(0.5),
                                       Color(0xff02d39a).withOpacity(0.5)
                                     ]),
                                 barWidth: 5,
                                 isCurved: true,
                                 colors: [
                                   Color(0xff23b6e6),
                                   Color(0xff02d39a)
                                 ],
                                 spots: _getSpots(snapshot.data),
                                 isStrokeCapRound: true,
                                 dotData: FlDotData(show: false))
                           ],
                           extraLinesData: ExtraLinesData(
                               extraLinesOnTop: false,
                               horizontalLines: [
                                 HorizontalLine(y: 100, color: Colors.red),
                                 HorizontalLine(y: 90, color: Colors.blueGrey),
                                 HorizontalLine(y: 60, color: Colors.blueGrey),
                                 HorizontalLine(y: 30, color: Colors.blueGrey),
                                 HorizontalLine(y: 0, color: Colors.blueGrey),
                                 HorizontalLine(
                                     y: 120, color: Colors.blueGrey),
                                 HorizontalLine(
                                     y: 180, color: Colors.blueGrey),
                                 HorizontalLine(
                                     y: 150, color: Colors.blueGrey),
                               ])));
                     }
                     return Text("caricamento...");
                   },
                 ),
                  ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton(
                onPressed: () {
                  
                  setState(() {
                    if (zoom > 1) {
                      zoom--;
                    }
                  });
                },
                child: Icon(Icons.zoom_out),
              ),
              SizedBox(
                width: 10,
              ),
              FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  setState(() {
                    if (zoom < 3) {
                     
                      zoom += 1;
                    }
                  });
                },
                child: Icon(Icons.zoom_in),
              )
            ],
          ),
        ));
  }
}


int zoom = 1;
