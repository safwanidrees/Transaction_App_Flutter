import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transaction_app/widgets/next.dart';
import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';
import './widgets/next.dart';
import 'package:flutter/services.dart';

void main() {
  // SystemChrome.setPreferredOrientations(DeviceOrientation.portraitUp,De)
//  System Chrome is uesed to set the app as potarit or lanscape
//
//  SystemChrome.setPreferredOrientations([
//    DeviceOrientation.portraitUp,
//    DeviceOrientation.portraitDown,
//  ]
//     );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expenses',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          errorColor: Colors.red,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              button: TextStyle(color: Colors.white)),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // String titleInput;
  // String amountInput;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Weekly Groceries',
    //   amount: 16.53,
    //   date: DateTime.now(),
    // ),
  ];

//were is same as for loop   it allow you to run the function on every item on the list if item is true it return new list

  List<Transaction> get _recentTransaction {
    //pasing anonyms function
    return _userTransactions.where((tx) {
      return tx.date.isAfter(//yhis date is day-7 days
          DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime selectedDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: selectedDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransactions(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      //it will round the corner of bottom sheet

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      context: ctx,

      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );

//  return new Container(
//                 height: 350.0,
//                 color: Colors.transparent, //could change this to Color(0xFF737373),
//                            //so you don't have to change MaterialApp canvasColor
//                 child: new Container(
//                     decoration: new BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: new BorderRadius.only(
//                             topLeft: const Radius.circular(10.0),
//                             topRight: const Radius.circular(10.0))),
//                     child: new Center(
//                       child: NewTransaction(_addNewTransaction),
//                     )),
//               );
      },
    );
  }

  bool _showChart = false;

  @override
  Widget build(BuildContext context) {
    // make small the code
    final mediaQuery = MediaQuery.of(context);

    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget appbar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              'Personal Expenses',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewTransaction(context),
                )
              ],
            ),
          )
        : AppBar(
            centerTitle: true,
            title: Text(
              'Personal Expenses',
            ),
            backgroundColor: Colors.purple,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _startAddNewTransaction(context),
              ),
            ],
          );

    //is shows my lisr

    final txList = Container(
        height: (MediaQuery.of(context).size.height -
                appbar.preferredSize.height -
                mediaQuery.padding.top) *
            0.7,
        child: TransactionList(_userTransactions, _deleteTransactions));
    //safearea is used position every thing in the pagge in ios
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Show Chart',style:Theme.of(context).textTheme.title),
                  Switch.adaptive(
                    activeColor: Theme.of(context).accentColor,
                    //now _showChart is false so Switch is off

                    value: _showChart,

                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    },
                  )
                ],
              ),

            //if(_showChart == true ){}
            //   else{}

            if (!isLandscape)
              Container(
                height: (MediaQuery.of(context).size.height -
                        appbar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.3,
                child: Chart(_recentTransaction),
              ),
            if (!isLandscape)
              txList,

            if (isLandscape)
              if (_showChart)
                Container(
                  height: (MediaQuery.of(context).size.height -
                          appbar.preferredSize.height -
                          mediaQuery.padding.top) *
                      0.6,
                  child: Chart(_recentTransaction),
                )
              else
                txList,
            //       Container(
            //       margin: EdgeInsets.only(left: 87,right:87),
            //         child: RaisedButton(
            //           child: Text('Hello',
            //           ),
            //           color: Colors.purple,
            //           padding: EdgeInsets.all(20),
            //           splashColor: Colors.pink,
            //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            //  onPressed: (){},
            //         ),
            //       ),
            // Container(
            //   padding: EdgeInsets.all(10),
            //   child: TextField(

            //     decoration: InputDecoration(
            //         hintText: ('Hellow'),
            //         border: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(10.0))),
            //   ),
            // ),
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appbar,
          )
        : Scaffold(
            appBar: appbar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,

            //its doesnot shpw floating button in ios

            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),

                    //onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context)=>Next()));},
                  ),
          );
  }
}
