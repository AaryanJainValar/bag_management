
import 'package:bag_manage/data/network/base_api_services.dart';
import 'package:bag_manage/data/network/network_api_services.dart';
import 'package:bag_manage/resources/app_url.dart';

class ScanBagRepository {

  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> bagInfoApi(dynamic data) async {
    try{
      dynamic response = await _apiServices.getGetApiResponse(AppUrl.bagInfo+data);
      return response;
    } catch(e) {
      throw e;
    }
  }

  // Future<dynamic> signUpApi(dynamic data) async {
  //   try{
  //     dynamic response = await _apiServices.getPostApiResponse(AppUrl.registerUrl, data);
  //     return response;
  //   }catch(e) {
  //     throw e;
  //   }
  // }

}