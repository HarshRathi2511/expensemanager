//card widget of transactions
import 'dart:math';

import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> transactions;

  final Function _deleteTx;

  TransactionList(this.transactions, this._deleteTx);

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
 
 Color _bgColor;

 void initState()
 { 
   //every list item should get a random color 
   const availableColors=[Colors.red,Colors.blue,Colors.green];

   _bgColor=availableColors[Random().nextInt(3)]; //uses dart.math //color is set before the build runs 

   super.initState();
 }



  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height*0.6, //already done in main
      child: widget.transactions.isEmpty
          ? LayoutBuilder(
              builder: (ctx, constraints) {
                return Column(
                  children: [
                    Text(
                      'No Transactions added yet!',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: constraints.maxHeight * 0.15),
                    Container(
                        height: constraints.maxHeight *
                            0.6, //change the height via accessing constraints using Layout Builder
                        child: Image.asset('assets/images/waiting.png',
                            fit: BoxFit.cover)),
                  ],
                );
              },
            )
          : ListView.builder(
              //no need of Layout builder as it is scrollable
//               //we are using the ternary operator
              itemCount: widget.transactions.length,
              itemBuilder: (BuildContext ctx, int index) {
                return Dismissible(
                  onDismissed: (DismissDirection direction) {
                    setState(() {
                      widget.transactions.removeAt(index);
                    });
                  },
                  direction: DismissDirection.horizontal,
                  key: UniqueKey(),
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    elevation: 5,
                    child: ListTile(
                      leading: CircleAvatar(
                        //leading is the element in the start
                        // foregroundColor: Colors.blueAccent,
                        backgroundColor: _bgColor,
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          child: FittedBox(
                              //FittedBox is a very useful widget that scales and positions its child within itself according to fit and alignment. As many of the widgets are dynamic,
                              // which means they can grow and shrink in size, according to their child widget’s size
                              child: Text(
                            '₹' +
                                widget.transactions[index].amount
                                    .toStringAsFixed(2),
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                        radius: 30,
                      ),
                      title: Text(widget
                          .transactions[index].title), //element in the middle
                      subtitle: Text(
                        DateFormat().format(widget.transactions[index].date),
                      ), //below the title

                      trailing: MediaQuery.of(context).size.width> 460?
                      FlatButton.icon(onPressed: () =>
                            widget._deleteTx(widget.transactions[index].id),
                             icon: Icon(Icons.delete), 
                             label: const Text('Delete'), //when build gets called Text widget wont get rebuild 
                             textColor: Colors.red,)

                      :
                      IconButton(
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () =>
                            widget._deleteTx(widget.transactions[index].id),
                      ), //at the end
                    ),
                  ),
                );
              },
            ),
    );
  }
}

// return Card(
//                   margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
//                   elevation: 5,
//                   child: ListTile(
//                     leading: CircleAvatar(
//                       //leading is the element in the start
//                       // foregroundColor: Colors.blueAccent,
//                       backgroundColor: Colors.blueAccent,
//                       child: Container(
//                         padding: EdgeInsets.all(3),
//                         child: FittedBox(
//                             //FittedBox is a very useful widget that scales and positions its child within itself according to fit and alignment. As many of the widgets are dynamic,
//                             // which means they can grow and shrink in size, according to their child widget’s size
//                             child: Text(
//                           '₹' + transactions[index].amount.toStringAsFixed(2),
//                           style: TextStyle(color: Colors.white),
//                         )),
//                       ),
//                       radius: 30,
//                     ),
//                     title:
//                         Text(transactions[index].title), //element in the middle
//                     subtitle: Text(
//                       DateFormat().format(transactions[index].date),
//                     ), //below the title

//                     trailing: IconButton(icon: Icon(Icons.delete), onPressed: (){},), //at the end
//                   ),
//                 );

//IMPORTANT -WITHOUT USING THE LIST TILE WIDGET
// return Card(
//each transcation
//   child: Row(children: [
//     Container(
//       margin:
//           EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: Colors.lightBlueAccent,
//color: Theme.of(context).primaryColor,
//           width: 5,
//         ),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       padding: EdgeInsets.all(10),
//       child: Text(
//         '\₹ ${transactions[index].amount.toStringAsFixed(2)}',  // to ensure that only two decimal places are considered
//         style: TextStyle(color: Colors.redAccent),
//       ),
//     ),
//     Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           transactions[index].title,
//           style: TextStyle(
//               color: Colors.black87,
//               fontWeight: FontWeight.bold,
//               fontSize: 20),
//         ),
//         Text(
//           DateFormat().format(transactions[index].date),
//           style: TextStyle(
//               color: Colors.deepPurple,
//               fontWeight: FontWeight.bold,
//               fontSize: 15),
//         ),
//       ],
//     ),
//   ]),
// );

// Dismissible(

//                   onDismissed: (DismissDirection direction)
//                   {
//                     setState((){
//                       widget.transactions.removeAt(index);
//                     });
//                   },

//                   direction: DismissDirection.horizontal,

//                   key: UniqueKey(),

//             child: Card(
//                   margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
//                   elevation: 5,
//                   child: ListTile(
//                     leading: CircleAvatar(
//                       //leading is the element in the start
//                       // foregroundColor: Colors.blueAccent,
//                       backgroundColor: Colors.blueAccent,
//                       child: Container(
//                         padding: EdgeInsets.all(3),
//                         child: FittedBox(
//                             //FittedBox is a very useful widget that scales and positions its child within itself according to fit and alignment. As many of the widgets are dynamic,
//                             // which means they can grow and shrink in size, according to their child widget’s size
//                             child: Text(
//                           '₹' + widget.transactions[index].amount.toStringAsFixed(2),
//                           style: TextStyle(color: Colors.white),
//                         )),
//                       ),
//                       radius: 30,
//                     ),
//                     title:
//                         Text(widget.transactions[index].title), //element in the middle
//                     subtitle: Text(
//                       DateFormat().format(widget.transactions[index].date),
//                     ), //below the title

//                     trailing: IconButton(icon: Icon(Icons.delete), onPressed: (){},), //at the end
//                   ),
//                 ),

//                 );

//LIST VIEW BUILDER WIDGET

// ListView.builder(
//               //we are using the ternary operator
//               itemCount: widget.transactions.length,
//               itemBuilder: (BuildContext ctx, int index) {

//                 return Dismissible(

//                   onDismissed: (DismissDirection direction)
//                   {
//                     setState((){
//                       widget.transactions.removeAt(index);
//                     });
//                   },

//                   direction: DismissDirection.horizontal,

//                   key: UniqueKey(),

//             child: Card(
//                   margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
//                   elevation: 5,
//                   child: ListTile(
//                     leading: CircleAvatar(
//                       //leading is the element in the start
//                       // foregroundColor: Colors.blueAccent,
//                       backgroundColor: Colors.blueAccent,
//                       child: Container(
//                         padding: EdgeInsets.all(3),
//                         child: FittedBox(
//                             //FittedBox is a very useful widget that scales and positions its child within itself according to fit and alignment. As many of the widgets are dynamic,
//                             // which means they can grow and shrink in size, according to their child widget’s size
//                             child: Text(
//                           '₹' + widget.transactions[index].amount.toStringAsFixed(2),
//                           style: TextStyle(color: Colors.white),
//                         )),
//                       ),
//                       radius: 30,
//                     ),
//                     title:
//                         Text(widget.transactions[index].title), //element in the middle
//                     subtitle: Text(
//                       DateFormat().format(widget.transactions[index].date),
//                     ), //below the title

//                     trailing: IconButton(icon: Icon(Icons.delete), onPressed: (){},), //at the end
//                   ),
//                 ),

//                 );

//               },

//             ),
