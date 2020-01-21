import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
              style: Theme
                  .of(context)
                  .textTheme
                  .title,
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
        : ListView.builder(
      itemBuilder: (ctx, index) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
          child: Card(
            child: ListTile(
                leading:
//  circle shape making

                // Container(
                //   height: 60,
                //   width: 60,
                //   decoration: BoxDecoration(color:Theme.of(context).primaryColor,shape: BoxShape.circle),child: Padding(
                //     padding: EdgeInsets.all(10),
                //     child: FittedBox(
                //       child: Text(
                //           '\$${transactions[index].amount.toStringAsFixed(2)}'),
                //     ),

                //   ),)

                CircleAvatar(
                  radius: 30,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: FittedBox(
                      child: Text(
                          '\$${transactions[index].amount.toStringAsFixed(2)}'),
                    ),
                  ),
                ),
                title: Text(transactions[index].title),
                subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date)),

                trailing: MediaQuery.of(context).size.width > 450

                    ?

                FlatButton.icon(
                  onPressed: () {
                    deleteTx(transactions[index].id);
                  },
                  label: Text('Delete'),
                  icon: Icon(Icons.delete),
                  textColor: Theme .of(context).errorColor,  )

                    :

                IconButton(
                onPressed: () {
          deleteTx(transactions[index].id);
          },
            icon: Icon(
              Icons.delete,
              color: Theme
                  .of(context)
                  .errorColor,
            ),
          ),
        ),)
        ,
        );
      },
      itemCount: transactions.length,
    );
  }
}
