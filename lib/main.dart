
import 'package:expensetracker/Data/expense_Data.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';
void main() async{ 
//intialize hive
  await Hive.initFlutter();
   // open a hive
   var box = await Hive.openBox("expense_database2");

 runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
 return ChangeNotifierProvider(
  create: (context) => ExpenseData(),
  builder: (context, child) => const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ),
 );
   
  } 
}

