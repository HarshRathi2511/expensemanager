//text input xsw1widgets
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  //converted to stateful to avoid entered data from getting lost

  final Function addTx; // to access the addTx in the _NewTransactionState
  //class we use =>"widget.addTx(titleController.text,double.parse(amountController.text)); "
  //done automatically
  NewTransaction(this.addTx) {
    print('Constructor NewTransaction Widget ');
  }

  @override
  _NewTransactionState createState() {
    print('create NewTransaction Widget');
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  _NewTransactionState() {
    print('Constructor _NewTransactionState');
  }

  @override //to tell the compiler that we are making our own initState
  void initState() {
    //call super first->convention
    super
        .initState(); //super->parent class //so our initState runs and The compilers default one also runs
    print('initState()');
    //generally used to load data from a server initially
  }

  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget()');

  }

  @override
  void dispose() {
    print('Dispose()');
    super.dispose();
  }

  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    primary: Colors.white,
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
  );

  void submitData() {
    if (amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(enteredTitle, enteredAmount, _selectedDate);

    Navigator.of(context).pop(); //closes modal sheet once completed
  }

  DateTime _selectedDate;

  void _presentDatePicker() {
    showDatePicker(
      // of the type Future<DateTime> showDatePicker
      context: context,
      initialDate: DateTime
          .now(), //showDatePicker(context: context, initialDate: initialDate, firstDate: firstDate, lastDate: lastDate)
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      //pickedDate contains the date picked by user(sutomatically done by flutter)
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    }); //then function triggered when date has been picked ,but the code doesnt stop

    print('...'); //this will execute and wont wait
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom +
                  10), //to ensure that the bottom sheet is not affected by the keyboard space
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            TextField(
              autocorrect: true,
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (val) {
                submitData();
              },
            ),
            TextField(
              autocorrect: true,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
              onSubmitted: (val) {
                submitData();
              }, //when we press enter then it submits //val is a string we dont care about
              // onChanged: (val) {
              //   titleInput=val;
              // } ,
              controller: amountController,
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                      //FlexFit with tight
                      child: Text(_selectedDate == null
                          ? 'No Date Chosen'
                          : DateFormat.yMd().format(_selectedDate))),
                  SizedBox(width: 10),
                  ElevatedButton(
                      onPressed: _presentDatePicker,
                      child: Text(
                        'Choose Date ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
            SizedBox(height: 70),
            // Center(
            //   child: ElevatedButton(
            //     onPressed: submitData,
            //     child: Text('Add Transaction'),

            //   ),
            // )

            ElevatedButton(
              style: flatButtonStyle,
              onPressed: submitData,
              child: Text(
                'ADD TRANSACTION',
                style: TextStyle(fontSize: 18),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
