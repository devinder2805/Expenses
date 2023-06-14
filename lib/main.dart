// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'transaction_list.dart';
import 'new_transaction.dart';
import 'transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Expenses",
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        primaryColor: Colors.purple,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.amber,
          brightness: Brightness.dark,
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transaction> userTransaction = [
    Transaction(
      id: "t3",
      title: "Shoes",
      price: 52.34,
      date: DateTime(2023, 10, 12),
    ),
    Transaction(
      id: "t4",
      title: "Shoes",
      price: 52.34,
      date: DateTime(2023, 10, 12),
    ),
  ];

  void addTransaction(Transaction transaction) {
    setState(() {
      userTransaction.add(transaction);
    });
  }

  void deleteTransaction(String id) {
    setState(() {
      userTransaction.removeWhere((transaction) => (transaction.id == id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "My Expenses",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return NewTransaction(addTransaction);
                  });
            },
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            iconSize: 30,
          ),
        ],
      ),
      body: TransactionList(userTransaction, deleteTransaction),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return NewTransaction(addTransaction);
              });
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
