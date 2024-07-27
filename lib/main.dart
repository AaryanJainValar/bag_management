import 'package:bag_manage/utils/utils.dart';
import 'package:bag_manage/view/home_screen.dart';
import 'package:bag_manage/view_modal/scan_bag_view_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


late BuildContext mainContext;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ScanBagViewModal()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:  HomeScreen(),
      ),
    );
  }
}

