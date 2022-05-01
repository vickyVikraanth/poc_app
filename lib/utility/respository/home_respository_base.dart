
import 'package:sample_project/model/home_model.dart';

abstract class HomeRepositoryBase{
  Future<HomeModel?> fetchHomeApi();
}