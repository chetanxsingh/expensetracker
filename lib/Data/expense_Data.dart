
import 'package:expensetracker/Data/hive_database.dart';
import 'package:expensetracker/date_time_helper/date_time_helper.dart';
import 'package:expensetracker/models/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseData extends ChangeNotifier{

  List<ExpenseItem> getAllExpenseList= [];
  
  List<ExpenseItem> overallExpenseList = [];



  List<ExpenseItem> getAllexpnseList(){
    return overallExpenseList;
  }

final db = HiveDataBase();
void prepareData(){
  if (db.readData().isNotEmpty){
    overallExpenseList = db.readData();
}
}



void addNewExpense(ExpenseItem newExpense){
  overallExpenseList.add(newExpense);
  notifyListeners();
db.saveData(overallExpenseList);
}

void deleteExpense(ExpenseItem expense){
  overallExpenseList.remove(expense);
  notifyListeners();
  db.saveData(overallExpenseList);
}

String getDayName(DateTime dateTime){
  switch (dateTime.weekday) {
    case 1:
    return 'Mon';
    case 2:
    return 'Tue';
    case 3:
    return 'Wed';
    case 4:
    return 'Thur';
    case 5:
    return 'Fri';
    case 6:
    return 'Sat';
    case 7:
    return 'Sun';
    default:
    return ' ';
  }
}

//startofweek

DateTime startOfWeekDate(){
  DateTime? startOfWeek;

  DateTime today =  DateTime.now();
   
    for(int i=0; i <7; i++){
      if(getDayName(today.subtract(Duration(days: i))) == 'Sun'){
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
   return startOfWeek!;
  }

Map<String, double> calculateDailyExpenseSummary(){
  Map<String, double> dailyExpenseSummary = {

  };


  for (var expense in overallExpenseList){
    String date = convertDateTimeToString(expense.dateTime);
    double amount = double.parse(expense.amount);
    if(dailyExpenseSummary.containsKey(date)){
    double currentAmount = dailyExpenseSummary[date]!;
    currentAmount += amount;
    dailyExpenseSummary[date] = currentAmount;
    }else {
      dailyExpenseSummary.addAll({date: amount});

    }
      
    } 
    return dailyExpenseSummary;
  }
}




