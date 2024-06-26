import 'package:expensetracker/bar_graph/bar_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
class MyBarGraph extends StatelessWidget {
  final double? maxY;
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;





  const MyBarGraph({
    super.key,
    required this.maxY,
    required this.sunAmount,
    required this.monAmount, 
    required this.tueAmount, 
    required this.wedAmount, 
    required this.thurAmount, 
    required this.friAmount,
    required this.satAmount,
  });

  @override
  Widget build(BuildContext context) {

   BarData myBarData = BarData(
    sunAmount: sunAmount,
    monAmount: monAmount,
     tueAmount: tueAmount,
      wedAmount: wedAmount, 
      thurAmount: thurAmount, 
      friAmount: friAmount, 
      satAmount: satAmount);

myBarData.initializeBarData();

 return BarChart(
  BarChartData(
    maxY: maxY,
    minY: 0,
  titlesData: const FlTitlesData(
    show: true,
    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
    leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        getTitlesWidget: gerBottomTitles,
      )
    )
  ),

    gridData: const FlGridData(show: false),
    borderData: FlBorderData(show: false),

    barGroups: myBarData.barData.map((data) => BarChartGroupData(
      x: data.x,
      barRods: [
        BarChartRodData(
          
          toY: data.y,
          color: Colors.orangeAccent,width: 23,
          borderRadius: BorderRadius.circular(5),
          backDrawRodData: BackgroundBarChartRodData(show: true,
          toY: maxY,
          color: Color(0xffffd289),
          
          )
          
          
          
          
          ),
      ],
      
      
      ),
      )
    .toList(),
  )
 );

  

   
}
}

Widget gerBottomTitles(double value, TitleMeta meta){
  const style = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 13,
  );
  Widget text;
switch (value.toInt()) {
  case 0:
  text = const Text('S' , style: style,);
  break;

  case 1:
  text = const Text('M' , style: style,);
  break;

  case 2:
  text = const Text('T' , style: style,);
  break;
  case 3:
  text = const Text('W' , style: style,);
  break;

  case 4:
  text = const Text('T' , style: style,);
  break;
  case 5:
  text = const Text('F' , style: style,);
  break;
  case 6:
  text = const Text('S' , style: style,);
  break;
  default:
  text = const Text('' , style: style,);
  break;
}
return SideTitleWidget(
  child: text, 
  axisSide: meta.axisSide);
}