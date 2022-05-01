
import 'package:dio/dio.dart';
import 'package:sample_project/utility/base_view_model.dart';

import '../model/home_model.dart';
import '../utility/respository/home_repository.dart';
import '../utility/services/exceptions/exceptions.dart';

class HomeViewModel extends BaseViewModel{
  HomeReposity homeReposity = new HomeReposity();
  List<Rows>? rowsData =[];
  HomeModel? homeModel;

  HomeViewModel();

  Future<dynamic> getFutureList() async {
    setState(ViewState.busy);
    try {
      var data = await homeReposity.fetchHomeApi();
      setState(ViewState.idle);
        homeModel = data;
        setState(ViewState.idle);
        rowsData!.addAll(homeModel!.rows!);
        return homeModel;
    } on DioError catch (error) {
      setState(ViewState.idle);
      throw DataException.fromDioError(error) as String;
    }
  }

  void viewModelSearch(String data){
    rowsData?.clear();
    if(data.isEmpty){
      rowsData!.addAll(homeModel!.rows!);
    }else{
      for(int i=0 ; i<homeModel!.rows!.length;i++){
        if(homeModel!.rows![i].title!=null&&homeModel!.rows![i].title!.toLowerCase().contains(data.toLowerCase())){
          rowsData?.add(homeModel!.rows![i]);
        }
      }
    }

   notifyListeners();
  }
}