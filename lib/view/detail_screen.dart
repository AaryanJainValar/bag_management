import 'package:bag_manage/main.dart';
import 'package:bag_manage/utils/utils.dart';
import 'package:bag_manage/view_modal/scan_bag_view_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  String bagNumber;
  String sourceOfMaterial;
  String weight;
  DetailScreen({super.key,required this.bagNumber, required this.sourceOfMaterial, required this.weight});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  String? _selectedItem1;
  String? _selectedItem2;
  List<String> _dropdownItems1 = [];
  List<String> _dropdownItems2 = [];


  @override
  void initState() {

    Future.microtask(()async{
      final scanBagViewModel = Provider.of<ScanBagViewModal>(mainContext,listen: false);
      await scanBagViewModel.destinationApi(mainContext);
      await scanBagViewModel.workOrderApi(mainContext);
      _dropdownItems1 = await scanBagViewModal.destinationList.map((item) => item['destination'] as String).toList();
      _dropdownItems2 = await scanBagViewModal.workOrderList.map((item) => item['workOrder'] as String).toList();
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Detail View"),
        centerTitle: true,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Bag No : " + widget.bagNumber??""),
              Text("Source Of Material : " + widget.sourceOfMaterial??""),
              Text("Weight : " +widget.weight??""),

              _buildDropdown(
                context,
                "Select Destination",
                _selectedItem1,
                _dropdownItems1,
                    (String? newValue) {
                  setState(() {
                    _selectedItem1 = newValue;
                  });
                },
              ),

              _buildDropdown(
                context,
                "Select Item",
                _selectedItem2,
                _dropdownItems2,
                    (String? newValue) {
                  setState(() {
                    _selectedItem2 = newValue;
                  });
                },
              ),
            ],
          ),


        ),
      ),
    );
  }

  Widget _buildDropdown(
      BuildContext context,
      String hint,
      String? selectedItem,
      List<String> items,
      ValueChanged<String?> onChanged,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8, // 80% of the screen width
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.grey),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 1.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            hint: Text(hint),
            value: selectedItem,
            onChanged: onChanged,
            dropdownColor: Colors.white,
            items: items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            isExpanded: true,
          ),
        ),
      ),
    );
  }
}