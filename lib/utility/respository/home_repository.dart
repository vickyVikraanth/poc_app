
import 'package:sample_project/model/home_model.dart';
import 'package:sample_project/utility/respository/home_respository_base.dart';

import '../locator.dart';
import '../services/exceptions/api_service.dart';
import '../services/exceptions/dio_interceptor.dart';
import '../services/exceptions/network_exception.dart';
import '../services/exceptions/repository_exception.dart';

 class HomeReposity implements HomeRepositoryBase{
   final ApiService _apiService = locator<ApiService>();

   @override
  Future<HomeModel?> fetchHomeApi() async {
     try {
       final response = await _apiService.getHttp(Client.endPoint);
       if (response != null) {
         return HomeModel.fromJson(response);
       }
     } on NetworkException catch (e) {
       throw RepositoryException(e.message);
     }
  }

}