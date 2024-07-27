import 'package:bag_manage/repository/scan_bag_repository.dart';
import 'package:bag_manage/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';

ScanBagViewModal scanBagViewModal =
    Provider.of<ScanBagViewModal>(mainContext, listen: false);

class ScanBagViewModal with ChangeNotifier {
  final _myRepo = ScanBagRepository();
  bool loading = false;
  bool signUploading = false;
  List<dynamic> bagList = [];
  List<dynamic> destinationList = [];
  List<dynamic> workOrderList = [];

  Future<void> scanBagApi(dynamic data, BuildContext context) async {
    _myRepo.bagInfoApi(data).then((value) {
      if (value.toString().isNotEmpty) {
        bagList = value;
        notifyListeners();
      }
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        Utils.snackBar(error.toString(), context);
        print(error.toString());
      }
    });
  }

  Future<void> destinationApi(BuildContext context) async {
    await _myRepo.destinationApi().then((value) {
      if (value.toString().isNotEmpty) {
        destinationList = value;
        notifyListeners();
      }
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        Utils.snackBar(error.toString(), context);
        print(error.toString());
      }
    });
  }

  Future<void> workOrderApi(BuildContext context) async {
    await _myRepo.workOrderApi().then((value) {
      if (value.toString().isNotEmpty) {
        workOrderList = value;
        notifyListeners();
      }
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        Utils.snackBar(error.toString(), context);
        print(error.toString());
      }
    });
  }

  Future<void> bagRequestApi(dynamic data, BuildContext context) async {
    await _myRepo
        .bagRequestApi(data)
        .then((value) {})
        .onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
