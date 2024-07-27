
import 'package:bag_manage/modals/get_scan_bag_response.dart';
import 'package:bag_manage/repository/scan_bag_repository.dart';
import 'package:bag_manage/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

ScanBagViewModal scanBagViewModal = Provider.of<ScanBagViewModal>(mainContext);
class ScanBagViewModal with ChangeNotifier {
  final _myRepo = ScanBagRepository();

  bool loading = false;
  bool signUploading = false;
  List<dynamic> bagList = [];
  List<dynamic> destinationList = [];
  List<dynamic> workOrderList = [];



  setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  setSignUpLoading(bool value) {
    signUploading = value;
    notifyListeners();
  }

  Future<void> scanBagApi(dynamic data, BuildContext context) async {
    setLoading(true);
    _myRepo.bagInfoApi(data).then((value){
      setLoading(false);
      print("response = $value" );
      if(value.toString().isNotEmpty) {
         bagList = value;
        print("abc = $bagList");
         notifyListeners();

      }
      if(kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if(kDebugMode) {
        Utils.snackBar(error.toString(), context);
        print(error.toString());
      }

    });
  }

  Future<void> destinationApi(BuildContext context) async {
    setLoading(true);
    _myRepo.destinationApi().then((value){
      setLoading(false);
      print("response = $value" );
      if(value.toString().isNotEmpty) {
        destinationList = value;
        print("abc12 = $bagList");
        print("abc123 = $destinationList");
        notifyListeners();
      }
      if(kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if(kDebugMode) {
        Utils.snackBar(error.toString(), context);
        print(error.toString());
      }
    });
  }

  Future<void> workOrderApi(BuildContext context) async {
    setLoading(true);
    _myRepo.workOrderApi().then((value){
      setLoading(false);
      print("response = $value" );
      if(value.toString().isNotEmpty) {
        workOrderList = value;
        print("abc12 = $bagList");
        print("abc123 = $destinationList");
        print("abc1234 = $workOrderList");
        notifyListeners();
      }
      if(kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if(kDebugMode) {
        Utils.snackBar(error.toString(), context);
        print(error.toString());
      }
    });
  }

}