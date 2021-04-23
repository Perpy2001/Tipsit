import 'package:am029_maree/class/data.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class Stazione extends StatelessWidget {
  final Data data;
  const Stazione({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    double val = double.parse(data.valore.trim().substring(0, 4));

    String lungStaz(String staz) {
      List<String> strList = staz.split(" ");
      String ris = "";
      for (int i = 0; i < strList.length; i++) {
        if (i == 2) {
          ris += "\n   ";
        }
        ris += strList[i] + " ";
      }
      return ris;
    }

    String _livelloMarea() {
      if (val < 0.80) {
        return "bassa";
      } else if (val < 1.0) {
        return "media";
      } else if (val < 1.2) {
        return "alta";
      } else if (val < 1.8) {
        return "alta";
      } else {
        return "??";
      }
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
    return Scaffold(
      appBar: AppBar(), 
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/laguna.jpg'), fit: BoxFit.cover),
        ),
        child: Center(
          child: Card(
               shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
            elevation: 10,
            shadowColor: Colors.black,
            child: Container(
              height: MediaQuery.of(context).size.height*0.70,
              decoration: BoxDecoration(
             //     color: Color.fromRGBO(250, 250, 250, 0.9)
                  
                  ),
             // height: MediaQuery.of(context).size.height * 0.70,
              width: MediaQuery.of(context).size.width*0.70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(ora.day.toString().padLeft(2, "0") +
                      "/" +
                      ora.month.toString().padLeft(2, "0") +
                      "/" +
                      ora.year.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                  Text(ora.hour.toString() +
                      ":" +
                      ora.minute.toString().padLeft(2, "0")),
                  Container(
                    height: 300,
                    width: 250,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 50),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: LiquidCircularProgressIndicator(
                        
                        //cerchio marea
                        value: livello(),
                        valueColor: AlwaysStoppedAnimation(
                            livello() < 0.80 ? Colors.blue : colore(val)),
                        backgroundColor: Color.fromRGBO(200, 200, 200, 0.2),
                        center: Text(
                          _livelloMarea(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                    style: TextStyle(color: colore(val), fontSize: 40),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Color colore(double val) {
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
