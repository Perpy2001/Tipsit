import 'package:am029_maree/data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineTitles {
  static String returnZoom(int value, List<Previsione> data) {
    switch (value.toInt()) {
      case 2:
        return getTielsDatae(data[2].dATAESTREMALE);
      case 6:
        return getTielsDatae(data[6].dATAESTREMALE);
      case 10:
        return getTielsDatae(data[10].dATAESTREMALE);
      case 14:
        return getTielsDatae(data[14].dATAESTREMALE);
      case 18:
        return getTielsDatae(data[18].dATAESTREMALE);
    }
    return '';
  }

  static String returnZoom2(int value, List<Previsione> data) {
    switch (value.toInt()) {
      case 0:
        return getTielsDatae(data[0].dATAESTREMALE);
      case 2:
        return getTielsDatae(data[2].dATAESTREMALE);
      case 4:
        return getTielsDatae(data[4].dATAESTREMALE);
      case 6:
        return getTielsDatae(data[6].dATAESTREMALE);
      case 8:
        return getTielsDatae(data[8].dATAESTREMALE);
    }
    return '';
  }

  static String returnZoom3(int value, List<Previsione> data) {
    switch (value.toInt()) {
      case 0:
        return getTielsDatae(data[0].dATAESTREMALE);
      case 1:
        return getTielsDatae(data[1].dATAESTREMALE);
      case 2:
        return getTielsDatae(data[2].dATAESTREMALE);
      case 3:
        return getTielsDatae(data[3].dATAESTREMALE);
      case 4:
        return getTielsDatae(data[4].dATAESTREMALE);
        case 5:
        return getTielsDatae(data[5].dATAESTREMALE);
    }
    return '';
  }

  static getTitleData(List<Previsione> data, int zoom) => FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff68737d),
            fontWeight: FontWeight.w900,
            fontSize: 16,
          ),
          getTitles: (value) {
            switch (zoom) {
              case 1:
                return returnZoom(value.toInt(), data);
              case 2:
                return returnZoom2(value.toInt(), data);
              case 3:
                return returnZoom3(value.toInt(), data);
            }
            return '';
          },
          reservedSize: 40,
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.w900,
            fontSize: 17,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case -50:
                return '-0.50';
              case -20:
                return '-0.20';
              case 0:
                return '0';
              case 30:
                return '0.30';
              case 60:
                return '0.60';
              case 90:
                return '0.90';
              case 120:
                return '1.20';
              case 150:
                return '1.50';
              case 180:
                return '1.80';
            }
            return '';
          },
          reservedSize: 40,
          margin: 10,
        ),
      );
}

String getTielsDatae(String giorno) {
  String ris = "";
  ris += DateTime.parse(giorno).day.toString().padLeft(2, '0') +
      '/' +
      DateTime.parse(giorno).month.toString().padLeft(2, '0') +
      "\n";
  ris += DateTime.parse(giorno).hour.toString().padLeft(2, '0') +
      ':' +
      DateTime.parse(giorno).minute.toString().padLeft(2, '0');

  return ris;
}
