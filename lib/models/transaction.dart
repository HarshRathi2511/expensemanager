//we can also create a map for the transactions and its price 
//but we are creating a class instead 
import 'package:flutter/foundation.dart';

class Transaction 
{
  final String id;  //final-runtime constant 
  final String title;
  final double amount;
  final DateTime date;  //DateTime is built into dart 

  Transaction({
     @required this.id,    // @required not given by dart ...it is given by flutter //import 'package:flutter/foundation.dart';
      @required this.title,
      @required this.amount,
      @required this.date});


}