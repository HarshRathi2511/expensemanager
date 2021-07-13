import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label; //shows the weekday
  final double spendingAmount;
  final double spendingPctOfTotal;

  const ChartBar({this.label, this.spendingAmount, this.spendingPctOfTotal});  //we can make this a const 
  //contructor as every property of the constructor is bound by 'final ' =>immutable 

  //i.e we cant access ChartBar.label=19; =>Wrong
  //

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: [
            Container(
                height: constraints.maxHeight * 0.15,
                child: FittedBox(
                    child: Text('\$' +
                        spendingAmount.toStringAsFixed(
                            0)))), //to ensure the text doesnt grow
            SizedBox(
                height: constraints.maxHeight *
                    0.05), //height dynamically calculated for each device
            Container(
              height: constraints.maxHeight * 0.6,
              width: 10,
              child: Stack(//allows elememts to be placed on top on each other
                  children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10)),
                ),
                FractionallySizedBox(
                  //Creates a widget that sizes its child to a fraction of the total available space.
                  heightFactor: spendingPctOfTotal,
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(20))),
                ),
              ]),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            Container(
                height: constraints.maxHeight * 0.15,
                child: FittedBox(child: Text(label))),
          ],
        );
      },
    );
  }
}
