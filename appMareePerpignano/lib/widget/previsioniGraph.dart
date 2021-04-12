import 'package:flutter/material.dart';
import 'package:am029_maree/bloc/previsioniBloc.dart';
import 'package:am029_maree/class/dataRepos.dart';
import 'package:am029_maree/class/previsioni.dart';
import 'package:am029_maree/class/previsioniRepos.dart';
import 'package:am029_maree/class/tielsData.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class PrevisioniGraph extends StatefulWidget {
  final zoom;
final snapshot;
  PrevisioniGraph({Key key, this.snapshot, this.zoom}) : super(key: key);

  @override
  _PrevisioniGraphState createState() => _PrevisioniGraphState();
}

class _PrevisioniGraphState extends State<PrevisioniGraph> {
  double _nMaxX(int length) {
  if(widget.zoom==1){
    return (length-1).toDouble();
  }
   return (length/widget.zoom);
}
  List<FlSpot> _getSpots(List<Previsione> data) {
    List<FlSpot> spots =[];
    int i = 0;
    for (Previsione p in data) {
      spots.add(FlSpot(i.toDouble(), double.parse(p.vALORE)));
      i++;
    }
    return spots;
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(LineChartData(
                             lineTouchData: LineTouchData(
                               enabled: true,
                               touchTooltipData: LineTouchTooltipData(
                        tooltipBgColor: Colors.blueAccent,
                        getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                          return touchedBarSpots.map((barSpot) {
                            return LineTooltipItem(
                             DateTime.parse(widget.snapshot[(barSpot.x).toInt()].dATAESTREMALE).hour.toString().padLeft(2, '0') +
      ':' +
      DateTime.parse(widget.snapshot[(barSpot.x).toInt()].dATAESTREMALE).minute.toString().padLeft(2, '0') +'\n${barSpot.y}cm',
                              const TextStyle(color: Colors.white),
                            );
                          }).toList();
                        }),
                             ),
                             titlesData:
                                 LineTitles.getTitleData(widget.snapshot, widget.zoom),
                             minX: 0,
                             maxX: _nMaxX(widget.snapshot.length),
                             
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
                                   spots: _getSpots(widget.snapshot),
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
}