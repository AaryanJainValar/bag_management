import 'package:bag_manage/main.dart';
import 'package:bag_manage/view_modal/scan_bag_view_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final String bagNumber;
  final String sourceOfMaterial;
  final String weight;

  DetailScreen({
    Key? key,
    required this.bagNumber,
    required this.sourceOfMaterial,
    required this.weight,
  }) : super(key: key);

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
    super.initState();
    Future.microtask(() async {
      final scanBagViewModel =
          Provider.of<ScanBagViewModal>(mainContext, listen: false);
      await scanBagViewModel.destinationApi(mainContext);
      await scanBagViewModel.workOrderApi(mainContext);
      _dropdownItems1 = scanBagViewModel.destinationList
          .map((item) => item['destination'] as String)
          .toList();
      _dropdownItems2 = scanBagViewModel.workOrderList
          .map((item) => item['workOrder'] as String)
          .toList();
      setState(() {});
    });
  }

  void _onBagRequestPressed(ScanBagViewModal scanBagViewModel, String bagNumber,
      String sourceOfMaterial, String destination, String weight) {
    if (_selectedItem1 != null || _selectedItem2 != null) {
      Map data = {
        "bagNumber": bagNumber,
        "sourceOfMaterial": sourceOfMaterial,
        "destination": destination,
        "weight": weight
      };
      print("sc = $data");
      scanBagViewModel.bagRequestApi(data, context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bag request submitted successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please select both destination and work order')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Detail View"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildInfoContainer("Bag No : ${widget.bagNumber}"),
              _buildInfoContainer("Weight : ${widget.weight}"),
              _buildInfoContainer(
                  "Source Of Material : ${widget.sourceOfMaterial}"),
              _buildDropdown(
                context,
                "Select Work Order",
                _selectedItem2,
                _dropdownItems2,
                (String? newValue) {
                  setState(() {
                    _selectedItem2 = newValue;
                  });
                },
              ),
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
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _onBagRequestPressed(
                  Provider.of<ScanBagViewModal>(context, listen: false),
                  widget.bagNumber,
                  widget.sourceOfMaterial,
                  _selectedItem1 ?? "",
                  widget.weight,
                ),
                child: const Text("Bag Request"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoContainer(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.grey),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 1.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
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
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.grey),
          boxShadow: const [
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
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              );
            }).toList(),
            isExpanded: true,
          ),
        ),
      ),
    );
  }
}
