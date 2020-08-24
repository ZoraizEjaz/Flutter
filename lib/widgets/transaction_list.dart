import '../models/transaction.dart';
import 'package:flutter/material.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transcations;
  final Function deleteTx;

  TransactionList(@required this.transcations, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transcations.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                Text(
                  'No transaction has been added yet!',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return TransactionItem(
                  transcation: transcations[index], deleteTx: deleteTx);
            },
            itemCount: transcations.length,
          );
  }
}
