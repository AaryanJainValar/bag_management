import 'package:bag_manage/view_modal/scan_bag_view_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../utils/utils.dart';
import 'detail_screen.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Variables to hold the barcode and product information
  String barcodeResult = '';

  // Method to handle API call for fetching product information
  void fetchProductInfo() async {
    // Implement API call here and update productInfo
    // Example:
    // final response = await http.get('https://recapi.perfinfo.us/recapi/api/BagInfo?bn=$barcode');
    // setState(() {
    //   productInfo = json.decode(response.body);
    // });
  }

  @override
  Widget build(BuildContext context) {
    mainContext = context;
    final scanBagViewModel = Provider.of<ScanBagViewModal>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: () => scanBarcode(scanBagViewModel, ),
                icon: Icon(Icons.camera_alt),
                label: Text('Scan Barcode'),
              ),
              SizedBox(height: 16),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    barcodeResult = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Enter Barcode',
                  border: OutlineInputBorder(),
                  hintText: 'Enter the barcode manually',
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => scanBagViewModel.scanBagApi("?bn="+barcodeResult, context),
                icon: Icon(Icons.search),
                label: Text('Submit'),
              ),
              SizedBox(height: 32),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Product Information:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: scanBagViewModel.bagList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                       return scanBagViewModel.bagList.length == 0 ?
                       Text('No product information available.') :
                       GestureDetector(
                         onTap: () async {

                            Navigator.push(context, MaterialPageRoute(builder: (context){
                             return DetailScreen(
                               bagNumber: scanBagViewModel.bagList[index]['bagNumber'],
                               sourceOfMaterial: scanBagViewModel.bagList[index]['sourceOfMaterial'],
                               weight: scanBagViewModel.bagList[index]['weight'],
                             );
                           }));
                         },
                           child: Card(
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(16),
                           ),
                           elevation: 4,
                           child: Padding(
                             padding: const EdgeInsets.all(16.0),
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: <Widget>[
                                 Center(
                                   child: ClipOval(
                                     child: Image.network(
                                       'https://via.placeholder.com/150',
                                       width: 100,
                                       height: 100,
                                       fit: BoxFit.cover,
                                     ),
                                   ),
                                 ),
                                 SizedBox(height: 16),
                                 Text('Bag Number: ${scanBagViewModel.bagList[index]['bagNumber']}'),
                                 SizedBox(height: 8),
                                 Text('Bagger Number: ${scanBagViewModel.bagList[index]['baggerNumber']}'),
                                 SizedBox(height: 8),
                                 Text('Event DateTime: ${scanBagViewModel.bagList[index]['eventDateTime']}'),
                                 SizedBox(height: 8),
                                 Text('Feed Hopper Number: ${scanBagViewModel.bagList[index]['feedHopperNumber']}'),
                                 SizedBox(height: 8),
                                 Text('Reason Code: ${scanBagViewModel.bagList[index]['reasonCode']}'),
                                 SizedBox(height: 8),
                                 Text('Description: ${scanBagViewModel.bagList[index]['description']}'),
                                 SizedBox(height: 8),
                                 Text('Source of Material: ${scanBagViewModel.bagList[index]['sourceOfMaterial']}'),

                               ],
                             ),
                           ),
                         ),
                       );
                    },)

                    // if (productInfo.isNotEmpty) ...[
                    //   Text('Product Name: ${productInfo['ProductName']}'),
                    //   SizedBox(height: 4),
                    //   Text('Product Description: ${productInfo['ProductDescription']}'),
                    //   SizedBox(height: 4),
                    //   Text('Weight: ${productInfo['Weight']}'),
                    // ] else ...[
                    //   Text('No product information available.'),
                    // ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Method to handle barcode scanning
Future<void> scanBarcode(ScanBagViewModal scanBagViewModel) async {
  barcodeResult = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666', 'Cancel', true, ScanMode.BARCODE);
  print("abc12 = $barcodeResult");

  if(barcodeResult.isNotEmpty) {
    scanBagViewModel.scanBagApi("?bn="+barcodeResult, context);

  }
}
}
