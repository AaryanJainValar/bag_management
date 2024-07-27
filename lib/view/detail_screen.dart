import 'package:flutter/material.dart';

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
  List<String> _dropdownItems1 = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];
  List<String> _dropdownItems2 = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];
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

              Padding(
                padding: const EdgeInsets.only(top: 8.0),
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
                      hint: Text("Select Item"),
                      value: _selectedItem1,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedItem1 = newValue!;
                        });
                      },
                      dropdownColor: Colors.white,
                      items: _dropdownItems1.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      isExpanded: true,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
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
                      hint: Text("Select Item"),
                      value: _selectedItem2,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedItem2 = newValue!;
                        });
                      },
                      dropdownColor: Colors.white,
                      items: _dropdownItems2.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      isExpanded: true,
                    ),
                  ),
                ),
              ),
            ],
          ),


        ),
      ),
    );
  }
}
