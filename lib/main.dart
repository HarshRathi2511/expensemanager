
import 'package:flutter/material.dart';

import 'package:expense_manager/widgets/new_transaction.dart';
import 'package:expense_manager/widgets/transaction_list.dart';
import './widgets/chart.dart';
import 'models/transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized(); //to ensure that the device only works in a landscape mode
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown,DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.amber,
          fontFamily: 'OpenSans',
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(fontFamily: 'OpenSans', fontSize: 20)),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // String titleInput;  //inputs are by default strings
  // String amountInput;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // when using final the pointer to the object remains the same its not changed
    // Transaction(id: 't2', title: 'Watch', amount: 500.00, date: DateTime.now()),
  
    Transaction(id: 't2', title: 'Watch', amount: 500.00, date: DateTime.now()),
    Transaction(
        id: 't3', title: 'Macbook', amount: 111500.00, date: DateTime.now()),
    Transaction(
        id: 't4', title: 'Airpods', amount: 1500.00, date: DateTime.now()),
    // Transaction(
    //     id: 't4', title: 'iPhone', amount: 1500.00, date: DateTime.now()),
    // Transaction(
    //     id: 't5', title: 'One Plus 8T', amount: 40500.00, date: DateTime.now()),
  ];

  //getter to just pass the last weeks transactions to the Chart widget
  List<Transaction> get _recentTransactions {
    //we could also use a loop

    return _userTransactions.where((tx) {
      // List_Name.where(test)  --if this test successful then the item is kept in the list(test is generally a function)

      return tx.date.isAfter(DateTime.now().subtract(Duration(
          days: 7))); //if tx.date is after the '' then only it will return true
    }).toList(); //to convert where iterable to List
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: chosenDate,
        id: DateTime.now().toString());
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) //use the id to identify the transaction
  {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      }); //(element) => false is the test function
    });
  }

  void _startAddNewTransaction(
      BuildContext ctx) //triggers text inputs in form of modal sheet
  {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return GestureDetector(
            child: NewTransaction(_addNewTransaction),
            onTap: () {}, //updated as such ,not reqd
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  bool _showChart = false;

  List<Widget> _buildLandscapeContent(
      AppBar appBar, MediaQueryData mediaQuery, Widget txListWidget) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Show Chart'),
          Switch.adaptive(
              value: _showChart,
              onChanged: (val) {
                //adaptive for ios and android
                setState(() {
                  _showChart = val;
                });
              })
        ],
      ),
      _showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: Chart(_recentTransactions))
          : txListWidget
    ];
  }

  List<Widget> _buildPotraitContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget txListWidget) {
    return [
      Container(
          height: (mediaQuery.size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top) *
              0.3,
          child: Chart(_recentTransactions)),
      txListWidget
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(
        context); //use the variable and access it //better performance as it is not re rendered

    final isLandscape = mediaQuery.orientation ==
        Orientation.landscape; // calculated whenever build runs again

    final appBar = AppBar(
      title: Text(
        'Personal Expenses',
        style: TextStyle(fontFamily: 'OpenSans'),
      ),
      actions: [
        IconButton(
          icon: Center(child: Icon(Icons.add)),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ],
    );

    final txListWidget = Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.7,
        child: TransactionList(_userTransactions, _deleteTransaction));

    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        //tomake space for the top bar and bottom
        child: SingleChildScrollView(
          //works only after the body
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start, //default
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Switch(value: value, onChanged: onChanged), // Switch(value: value, onChanged: onChanged)
                if (isLandscape)
                  ..._buildLandscapeContent(appBar, mediaQuery, txListWidget),

                if (!isLandscape)
                  ..._buildPotraitContent(
                      //spread operator to convert list into single elements and merge them with main list
                      mediaQuery,
                      appBar,
                      txListWidget),
              ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
