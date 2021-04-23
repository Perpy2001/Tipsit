import 'package:am029_maree/class/data.dart';
import 'package:am029_maree/class/dataRepos.dart';
import 'package:bloc/bloc.dart';


class DataEvent{
@override
List<Object> get props=>[];

}

class FetchData extends DataEvent{

}


class DataState{
@override
List<Object> get props=>[];
}


class DataNotLoaded extends DataState{


}

class DataLoading extends DataState{

}


class DataLoaded extends DataState{
  final _data;

  DataLoaded(this._data);
  List<Data> get getData => _data;
  @override
  List<Object> get props=>[_data];



}


class DataError extends DataState{

}

class DataBloc extends Bloc<DataEvent,DataState>{ 
  DataRepo dataRepo;
    DataState get initialState => DataNotLoaded();


  DataBloc(this.dataRepo) : super(null);




  @override
  Stream<DataState> mapEventToState(DataEvent event) async*{
    if(event is FetchData){
      yield DataLoading();
      try{
        List<Data> data = await DataRepo.fetchDataList();
        print(data[0].nomeAbbr);
        yield DataLoaded(data);

      }catch(e){
        yield DataError();
      }
    }
  }

}