import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:transaction_app/widgets/transaction_items.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    // //if (transactions.isEmpty){

    // }else{

    // }
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraint) {
              return Column(
                children: <Widget>[
                  Text(
                    'No transactions added yet!',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: constraint.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      )),
                ],
              );
            },
          )

        //else  condition
//        : ListView.builder(
//            itemBuilder: (ctx, index) {
//              return TransactionItems(
//                  transaction: transactions[index], deleteTx: deleteTx);
//            },
//            itemCount: transactions.length,
//          );

        //isko istarha bhe karskty hain
//now color will not chnage if we delete an item
        : ListView(
            children: transactions
                .map((tran) => TransactionItems(
                    key: ValueKey(tran.id),
                    transaction: tran,
                    deleteTx: deleteTx))
                .toList(),
          );
  }
}
