
import 'package:bag_manage/modals/get_scan_bag_response.dart';
import 'package:bag_manage/repository/scan_bag_repository.dart';
import 'package:bag_manage/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ScanBagViewModal with ChangeNotifier {
  final _myRepo = ScanBagRepository();

  bool loading = false;
  bool signUploading = false;
  List<dynamic> bagList = [];



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
      }
      // Utils.snackBar('Barcode Scanned', context);
      // Navigator.pushNamed(context, RoutesName.home);
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