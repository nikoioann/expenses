import 'package:expenses/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses App',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
            button: TextStyle(
              color: Colors.black,
            )),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 23.0,
          ),
        ),
        errorColor: Colors.redAccent[400],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transaction> _userTransactions = [
    Transaction(
      id: 't0',
      title: 'Crossfit',
      amount: 60,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: 't1',
      title: 'Groceries',
      amount: 59.67,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: 't2',
      title: 'MacBook',
      amount: 3070,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction.now(
      id: 't3',
      title: 'Laptop',
      amount: 670,
    ),
    Transaction.now(
      id: 't4',
      title: 'Coffee',
      amount: 2.75,
    ),
    Transaction(
      id: 't5',
      title: 'Monitor',
      amount: 1500,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime txDate) {
    final newTx = Transaction(
      id: 't4',
      title: txTitle,
      amount: txAmount,
      date: txDate,
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  void _deleteTransaction(String txID) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == txID);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses App'),
        actions: [
          IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: Icon(Icons.add_box_outlined),
          ),
        ],
      ),
      body: ListView(
        children: [
          Chart(_recentTransactions),
          TransactionList(_userTransactions, _deleteTransaction),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}