
import 'dart:async';

import 'package:am029_maree/bloc/dataBloc.dart';
import 'package:am029_maree/bloc/navigationBloc.dart';
import 'package:am029_maree/bloc/previsioniBloc.dart';
import 'package:am029_maree/class/dataRepos.dart';
import 'package:am029_maree/class/previsioniRepos.dart';
import 'package:am029_maree/pages/previsioni.dart';

import 'package:am029_maree/widget/maps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class MyHomePage extends StatefulWidget {
  final navigatorKey;
  MyHomePage({Key key, this.title, this.navigatorKey}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DataBloc dataBloc;

  Timer timer;
  var refreshKey = GlobalKey<RefreshIndicatorState>();


  @override
  void initState() {
    super.initState();
    dataBloc = DataBloc(DataRepo());
     dataBloc.add(FetchData());
      timer = Timer.periodic(Duration(minutes: 5), (Timer t) =>  dataBloc.add(FetchData()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          BlocProvider(
              create: (BuildContext context) => dataBloc,
              child: BlocBuilder<DataBloc, DataState>(
                builder: (context, state) {
                  if (state is DataNotLoaded) {
                    return Text("acesso al server");
                  } else if (state is DataLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is DataLoaded) {
                    return Maps(
                    data: state.getData,
                    );
                  } else
                    return Expanded(child: Center(
                      child: Container(
                        child: IconButton(
                          icon: Icon(Icons.replay_outlined),
                          onPressed: ()=> dataBloc.add(FetchData()),
                        ),
                      ),
                    ));
                },
              )),
              

           Positioned(
                top: MediaQuery.of(context).size.width * 0.055,
                right: MediaQuery.of(context).size.width * 0.045,
                child: IconButton(
                  iconSize: 40,
                  onPressed: () {
                   BlocProvider.of<NavigatorBloc>(context).add(NavigateToPrevisioni());
                  },
                  icon: Icon(
                    Icons.assessment_rounded,
                    color: Colors.black,
                  ),
                )),
          
          Positioned(
              top: MediaQuery.of(context).size.width * 0.05,
              right: MediaQuery.of(context).size.width * 0.05,
              child: IconButton(
                iconSize: 40,
                  onPressed: () {
                   BlocProvider.of<NavigatorBloc>(context).add(NavigateToPrevisioni());
                  },
                icon: Icon(
                  Icons.assessment_rounded,
                  color: Color(0xff02d39a),
                ),
              )),
        ],
      ),
    );
  }
}
