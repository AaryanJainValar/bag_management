import 'package:bag_manage/data/network/base_api_services.dart';
import 'package:bag_manage/data/network/network_api_services.dart';
import 'package:bag_manage/resources/app_url.dart';

class ScanBagRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> bagInfoApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.bagInfo + data);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> destinationApi() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.destination);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> workOrderApi() async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(AppUrl.workOrder);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> bagRequestApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.bagRequest, data);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
