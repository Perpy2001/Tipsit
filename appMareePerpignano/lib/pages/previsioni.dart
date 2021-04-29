import 'package:am029_maree/bloc/previsioniBloc.dart';
import 'package:am029_maree/class/dataRepos.dart';
import 'package:am029_maree/class/previsioni.dart';
import 'package:am029_maree/class/previsioniRepos.dart';
import 'package:am029_maree/class/tielsData.dart';
import 'package:am029_maree/widget/previsioniGraph.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Previsioni extends StatefulWidget {
  Previsioni({Key key}) : super(key: key);

  @override
  _PrevisioniState createState() => _PrevisioniState();
}

class _PrevisioniState extends State<Previsioni> {
   PrevisioneBloc previsioniBloc;

  


  @override
  void initState() {
    super.initState();
  previsioniBloc = PrevisioneBloc(PrevisioniRepo());
  previsioniBloc.add(FetchPrevisioni());
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(0, 0, 70, 100),
        appBar: AppBar(),
        body: BlocProvider(
           create: (BuildContext context) => previsioniBloc,
          
          child: Center(
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
                   child: BlocBuilder<PrevisioneBloc,PrevisioneState>(
                     builder: (BuildContext context,  state) {
                  if (state is PrevisioneNotLoaded) {
                    return Text("acesso al server");
                  } else if (state is PrevisioneLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is PrevisioneLoaded) {
                    return PrevisioniGraph(
                      zoom: zoom,
                      snapshot: state.getPrevisione,
                    );
                  } else
                  return Expanded(child: Center(
                      child: Container(
                        child: IconButton(
                          icon: Icon(Icons.replay_outlined),
                          onPressed: ()=> previsioniBloc.add(FetchPrevisioni()),
                        ),
                      ),
                    ));
                     },
                   ),
                    ),
                ],
              ),
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
