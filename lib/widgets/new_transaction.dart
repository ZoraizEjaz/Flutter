import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//it is a widget
class NewTransaction extends StatefulWidget {
  //this function is present in usertransactions.
  //we have a pointer reference of that function.
  // Passing value to this function will call main.dart function

  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

//it is a state
class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectDate;

  void _submitData() {

    if(_amountController.text.isEmpty){
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectDate == null) {
      return;
    }

    //widget builds connection b/w NewTransaction & _NewTransactionState classes
    //with the help of widget you can call the widget functions from the state class
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectDate
    );

    //this context is available in state class you don't have to define it
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickData) {
      if (pickData == null) {
        return;
      }

      setState(() {
        _selectDate = pickData;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          //mainAxisAlignment = Vertical Axis
          //crossAxisAlignment = Horizontal Axis
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              keyboardType: TextInputType.text,
              //"_" added in () which is saying I get an argument but I don't care.
              //() => is added to make it anonymous function
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
              //onChanged: (val) => amounInput = val,
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectDate == null
                          ? 'No date choosen!'
                          : 'Picke Date: ${DateFormat.yMd().format(_selectDate)}',
                    ),
                  ),
                  FlatButton(
                    color: Colors.white,
                    textColor: Theme.of(context).textTheme.button.color,
                    onPressed: _presentDatePicker,
                    child: Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            RaisedButton(
              child: Text('Add transation'),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
              onPressed: _submitData,
            )
          ],
        ),
      ),
    );
  }
}
