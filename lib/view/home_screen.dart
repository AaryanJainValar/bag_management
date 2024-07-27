import 'package:bag_manage/view_modal/scan_bag_view_modal.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String barcodeResult = '';

  @override
  Widget build(BuildContext context) {
    mainContext = context;
    final scanBagViewModel = Provider.of<ScanBagViewModal>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: () => scanBarcode(
                  scanBagViewModel,
                ),
                icon: const Icon(Icons.camera_alt),
                label: const Text('Scan Barcode'),
              ),
              const SizedBox(height: 16),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    barcodeResult = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Enter Barcode',
                  border: OutlineInputBorder(),
                  hintText: 'Enter the barcode manually',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () =>
                    scanBagViewModel.scanBagApi("?bn=$barcodeResult", context),
                icon: const Icon(Icons.search),
                label: const Text('Submit'),
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Product Information:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: scanBagViewModel.bagList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return scanBagViewModel.bagList.isEmpty
                            ? const Text('No product information available.')
                            : GestureDetector(
                                onTap: () async {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return DetailScreen(
                                      bagNumber: scanBagViewModel.bagList[index]
                                          ['bagNumber'],
                                      sourceOfMaterial: scanBagViewModel
                                          .bagList[index]['sourceOfMaterial'],
                                      weight: scanBagViewModel.bagList[index]
                                          ['weight'],
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                        const SizedBox(height: 16),
                                        Text(
                                            'Bag Number: ${scanBagViewModel.bagList[index]['bagNumber']}'),
                                        const SizedBox(height: 8),
                                        Text(
                                            'Bagger Number: ${scanBagViewModel.bagList[index]['baggerNumber']}'),
                                        const SizedBox(height: 8),
                                        Text(
                                            'Event DateTime: ${scanBagViewModel.bagList[index]['eventDateTime']}'),
                                        const SizedBox(height: 8),
                                        Text(
                                            'Feed Hopper Number: ${scanBagViewModel.bagList[index]['feedHopperNumber']}'),
                                        const SizedBox(height: 8),
                                        Text(
                                            'Reason Code: ${scanBagViewModel.bagList[index]['reasonCode']}'),
                                        const SizedBox(height: 8),
                                        Text(
                                            'Description: ${scanBagViewModel.bagList[index]['description']}'),
                                        const SizedBox(height: 8),
                                        Text(
                                            'Source of Material: ${scanBagViewModel.bagList[index]['sourceOfMaterial']}'),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                      },
                    )
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
    if (kDebugMode) {
      print("abc12 = $barcodeResult");
    }

    if (barcodeResult.isNotEmpty) {
      scanBagViewModel.scanBagApi("?bn=$barcodeResult", context);
    }
  }
}
