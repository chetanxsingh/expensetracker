import 'package:expensetracker/Data/expense_Data.dart';
import 'package:expensetracker/components/expense_summary.dart';
import 'package:expensetracker/components/expense_tile.dart';
import 'package:expensetracker/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
    
  }
class _HomePageState extends State<HomePage>{
  final newExpenseNameController = TextEditingController();
  final newExpenseAmaountController = TextEditingController();

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
      ),

      TextField(
        controller: newExpenseAmaountController,

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
 void save(){
ExpenseItem newExpense = ExpenseItem(
  name: newExpenseNameController.text,
   amount: newExpenseAmaountController.text, 
   dateTime: DateTime.now()
   );
Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);
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
      backgroundColor: Colors.grey,
      floatingActionButton: FloatingActionButton(onPressed: addNewExpense,
      child: Icon(Icons.add),
    ),
    body: ListView(children: [
      
      ExpenseSummary(startOfWeek: value.startOfWeekDate()),
      
      
      
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),

     itemCount: value.getAllexpnseList().length,
      itemBuilder: (context, index) => ExpenseTile(
        name: value.getAllexpnseList()[index].name,
       amount: value.getAllexpnseList()[index].amount,
        dateTime: value.getAllexpnseList()[index].dateTime,
        ),
    
      ),
    ]),
      
    ),
   );
  }

}
