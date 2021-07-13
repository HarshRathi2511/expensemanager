import 'package:expense_manager/models/transaction.dart';
import 'package:expense_manager/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    //returns a list whose elements are maps ,these maps contain String and a key of object
    return List.generate(7, //return a List using List.generate function

        (index) //index values range from 0,1,2,3,4,5,6 => this function is executed for each of them for the different index values

        {
      final weekDay = DateTime.now().subtract(Duration(
          days:
              index)); //DateTime.now() gives the current date and the time stamp  ....subtract duration to get the new date

      double totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum = totalSum + recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E()
            .format(weekDay)
            .substring(0, 3), // generates the substring from index 0 to index 3
        'amount': totalSum
      }; //DateFormat.E(weekDay) =>.E is the constructor which gives us the weekday shortcut when a date is given
    }).reversed.toList();//to reverse the list 
  }

  double get totalSpending {
    //for getting the total expenses for last week => sum of all 'totalSum' for each
    return groupedTransactionValues.fold(0.0, (sum, item) {
      //Reduces a collection to a single value by iteratively combining each element of the collection with an existing value
      return sum + item['amount'];
    }); //groupedTransactionValues.fold(initialValue, (previousValue, element) => null)
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);

    return Container(
      // height: MediaQuery.of(context).size.height *0.2,
      child: Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: groupedTransactionValues.map((data) {
              // return Text(data['day'].toString()+ ':'+ data['amount'].toString());
              return Flexible(
                fit: FlexFit.tight, //
                flex: 1, // to distribute the available space 
                child: ChartBar(
                  label: data['day'],
                  spendingAmount: data['amount'],
                  spendingPctOfTotal: totalSpending == 0
                      ? 0.0
                      : (data['amount'] as double) / totalSpending,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
