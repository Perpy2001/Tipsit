import 'package:crono/pages/crono.dart';
import 'package:crono/pages/timer.dart';
import 'package:flutter/material.dart';

class CostumDrawer extends StatelessWidget {
  const CostumDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 150,
      child: Drawer(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.redAccent[700],
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              ListTile(
                title: Icon(Icons.timer),
                subtitle: Text(
                  'Cronometro',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CronoPage()));
                },
              ),
              ListTile(
                title: Icon(Icons.av_timer),
                subtitle: Text(
                  'Timer',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Timer()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
