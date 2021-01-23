import 'package:am029_maree/data.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class Stazione extends StatelessWidget {
  final Data data;
  const Stazione({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color colore() {
      double val = double.parse(data.valore.trim().substring(0, 4));
      if (val < 0.80) {
        return Colors.green;
      } else if (val < 1.0) {
        return Colors.yellow;
      } else if (val < 1.2) {
        return Colors.orange;
      } else if (val < 1.8) {
        return Colors.red;
      } else {
        return Colors.purple;
      }
    }

    String lungStaz(String staz) {
      List<String> strList = staz.split(" ");
      String ris = "";
      for (int i = 0; i < strList.length; i++) {
        if (i == 2) {
          ris += "\n ";
        }
        ris += strList[i] + " ";
      }
      return ris;
    }

    double livello() {
      double val = double.parse(data.valore.trim().substring(0, 4));
      if (val < 0.80) {
        return data.valoreDouble;
      } else if (val < 1.0) {
        return 0.90;
      } else if (val < 1.2) {
        return 0.95;
      } else if (val < 1.8) {
        return 1.0;
      }
      return 0.2;
    }

    DateTime ora = DateTime.parse(data.data);
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 80, 10, 80),
      child: Container(
        decoration: BoxDecoration(
            border: Border(
              top: BorderSide(width: 1.0, color: Color(0xFFFFDFDFDF)),
              left: BorderSide(width: 1.0, color: Color(0xFFFFDFDFDF)),
              right: BorderSide(width: 1.0, color: Color(0xFFFF7F7F7F)),
              bottom: BorderSide(width: 1.0, color: Color(0xFFFF7F7F7F)),
            ),
            color: Colors.white),
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(ora.day.toString().padLeft(2, "0") +
                "/" +
                ora.month.toString().padLeft(2, "0") +
                "/" +
                ora.year.toString()),
            Text(ora.hour.toString() +
                ":" +
                ora.minute.toString().padLeft(2, "0")),
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width * 0.60,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 50),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: LiquidCircularProgressIndicator(
                  value: livello(), // Defaults to 0.5.
                  valueColor: AlwaysStoppedAnimation(
                      livello() < 0.80 ? Colors.blue : colore()),
                  backgroundColor: Colors.white,
                  center: Text(data.valoreDouble.toString()),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                lungStaz(data.stazione),
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            Text(
              data.idStazione,
              style: TextStyle(fontSize: 20),
            ),
            Text(
              data.valore,
              style: TextStyle(color: colore(), fontSize: 40),
            ),
            SizedBox(height: 50)
          ],
        ),
      ),
    );
  }
}
