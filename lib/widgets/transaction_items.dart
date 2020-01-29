import 'dart:math';

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';


 class TransactionItems extends StatefulWidget {

  const TransactionItems({
    Key key,
    @required this.transaction,
    @required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;


  @override
  _TransactionItemsState createState() => _TransactionItemsState();

}

class _TransactionItemsState extends State<TransactionItems> {
  Color _bgcolor;

  @override
  void initState() {
    const _circlecolor = [
      Colors.blue,
      Colors.amber,
      Colors.purple,
      Colors.black12
    ];

    _bgcolor = _circlecolor[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            backgroundColor: _bgcolor,
            radius: 30,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: FittedBox(
                child: Text('\$${widget.transaction.amount.toStringAsFixed(2)}'),
              ),
            ),
          ),
          title: Text(widget.transaction.title),
          subtitle: Text(DateFormat.yMMMd().format(widget.transaction.date)),
          trailing: MediaQuery.of(context).size.width > 450
              ? FlatButton.icon(
                  onPressed: () {
                    widget.deleteTx(widget.transaction.id);
                  },
                  label: Text('Delete'),
                  icon: Icon(Icons.delete),
                  textColor: Theme.of(context).errorColor,
                )
              : IconButton(
                  onPressed: () {
                    widget.deleteTx(widget.transaction.id);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).errorColor,
                  ),
                ),
        ),
      ),
    );
  }
}
