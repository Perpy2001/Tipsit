import 'package:am029_maree/class/data.dart';
import 'package:am029_maree/pages/previsioni.dart';
import 'package:am029_maree/pages/stazione.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

//Eventi
class NavigationEvent {
  @override
  List<Object> get props => [];
}

class NavigateToPrevisioni extends NavigationEvent {}

class NavigateToStazione extends NavigationEvent {
  final  Data _data;

  NavigateToStazione(this._data);
  
   Data get getPrevisione => _data;
  @override
  List<Object> get props => [_data];
}



class NavigatorBloc extends Bloc<NavigationEvent, dynamic> {

  final GlobalKey<NavigatorState> navigatorKey;

  NavigatorBloc(this.navigatorKey) : super(null);
 

  @override
  Stream<dynamic> mapEventToState(NavigationEvent event) async* {
     if(event is NavigateToPrevisioni){
      navigatorKey.currentState.push(MaterialPageRoute(builder: (context) {
                         return  Previsioni();
                        }));
    }else if(event is NavigateToStazione){
            navigatorKey.currentState.push(MaterialPageRoute(builder: (context) {
                         return  Stazione(data: event._data,);
                        }));
    }
}
}