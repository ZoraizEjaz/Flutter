import 'dart:math';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.transcation,
    @required this.deleteTx,
  }) : super(key: key);

  final Transaction transcation;
  final Function deleteTx;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor;

  @override
  void initState() {
    const availableColors = [
      Colors.red,
      Colors.black,
      Colors.blue,
      Colors.purple,
    ];

    _bgColor = availableColors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
          leading: CircleAvatar(
            backgroundColor: _bgColor,
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: FittedBox(child: Text('\$${widget.transcation.amount}')),
            ),
          ),
          title: Text(
            widget.transcation.title,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          subtitle: Text(
            DateFormat.yMMMd().format(widget.transcation.date),
          ),
          trailing: MediaQuery.of(context).size.width > 360
              ? FlatButton.icon(
                  icon: Icon(Icons.delete),
                  label: const Text('Delete'),
                  textColor: Theme.of(context).errorColor,
                  onPressed: () => widget.deleteTx(widget.transcation.id),
                )
              : IconButton(
                  icon: const Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  onPressed: () => widget.deleteTx(widget.transcation.id),
                )

          //we can not use deleteTx only here
          //as this function is present in main.dart file
          //we have to make it anonymous function
          ),
    );
  }
}
