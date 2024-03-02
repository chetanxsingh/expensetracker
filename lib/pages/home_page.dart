import 'package:expensetracker/Data/expense_Data.dart';
import 'package:expensetracker/components/expense_summary.dart';
import 'package:expensetracker/components/expense_tile.dart';
import 'package:expensetracker/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
    
  }
class _HomePageState extends State<HomePage>{
  final newExpenseNameController = TextEditingController();
  final newExpenseAmaountController = TextEditingController();
  final _myBox = Hive.openBox("expense_database2");


  @override
  void initState() {
    
    super.initState();
  Provider.of<ExpenseData>(context, listen: false).prepareData();
}

 void addNewExpense(){
  showDialog(
  context: context,
 builder: (context) => AlertDialog(
    title:  Text('Add new expense'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
      TextField(
        controller: newExpenseNameController,

        decoration: const InputDecoration(
          hintText: "Expense Item",
        ),
      ),

      TextField(
        controller: newExpenseAmaountController,
        keyboardType: TextInputType.number,
         decoration: const InputDecoration(
          hintText: "Rupees",
         ),
      ),
    ],
    ),
    actions: [
      MaterialButton(onPressed: save,
      child: Text('Save'),),


      MaterialButton(onPressed: cencel,
      child: Text('Cencel'),),
    ],
 ),
  );
 }
void deleteExpense(ExpenseItem expense){
  Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
}


 void save(){
    if(newExpenseNameController.text.isNotEmpty &&
    newExpenseAmaountController.text.isNotEmpty){
      ExpenseItem newExpense = ExpenseItem(
  name: newExpenseNameController.text,
   amount: newExpenseAmaountController.text, 
   dateTime: DateTime.now()
   );
Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);
    }
   Navigator.pop(context);
   clear();
 }
 
 void cencel(){
  Navigator.pop(context);

 }
 void clear(){
  newExpenseNameController.clear();
  newExpenseAmaountController.clear();
 }
 




@override
  Widget build(BuildContext context) {
   return Consumer<ExpenseData>(
    builder: (context, value,child) => Scaffold(
      backgroundColor: Color(0xFFe1d8f7),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewExpense,
        backgroundColor: Color(0xFFb596e5),
         child: const Icon(Icons.add),
    ),
    body: ListView(children: [
      
      ExpenseSummary(startOfWeek: value.startOfWeekDate()),
      
      const SizedBox(height: 30),
      
      
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),

     itemCount: value.getAllexpnseList().length,
      itemBuilder: (context, index) => ExpenseTile(
        name: value.getAllexpnseList()[index].name,
       amount: value.getAllexpnseList()[index].amount,
        dateTime: value.getAllexpnseList()[index].dateTime,
       deleteTapped: (p0) => 
       deleteExpense(value.getAllexpnseList()[index]),


        ),
  
      ),
    ]
    
    ),
      
    ),
   );
  }

}
