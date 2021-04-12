import 'package:am029_maree/class/previsioni.dart';
import 'package:am029_maree/class/previsioniRepos.dart';
import 'package:am029_maree/pages/previsioni.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

//Eventi
class PrevisioneEvent {
  @override
  List<Object> get props => [];
}

class FetchPrevisioni extends PrevisioneEvent {}

class PrevisioniButton extends PrevisioneEvent {}

//Stati
class PrevisioneState {
  @override
  List<Object> get props => [];
}

class PrevisioneNotLoaded extends PrevisioneState {}

class PrevisioneLoading extends PrevisioneState {}

class PrevisioneLoaded extends PrevisioneState {
  final _previsione;

  PrevisioneLoaded(this._previsione);
  List<Previsione> get getPrevisione => _previsione;
  @override
  List<Object> get props => [_previsione];
}

class PrevisioneError extends PrevisioneState {}

class PrevisioneBloc extends Bloc<PrevisioneEvent, PrevisioneState> {
  PrevisioniRepo previsioneRepo;



  PrevisioneBloc(this.previsioneRepo) : super(null);
  PrevisioneState get initialState => PrevisioneNotLoaded();

  @override
  Stream<PrevisioneState> mapEventToState(PrevisioneEvent event) async* {
    if (event is FetchPrevisioni) {
      yield PrevisioneLoading();
      try {
        List<Previsione> previsione =
            await PrevisioniRepo.fetchPrevisioniList();
        print(previsione[0].tITOLO);
        yield PrevisioneLoaded(previsione);
      } catch (e) {
        yield PrevisioneError();
      }
    }
  }
}
