// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'transaction_list.dart';
import 'new_transaction.dart';
import 'transaction.dart';
import 'chart.dart';

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
        fontFamily: "UbuntuMono",
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
  List<Transaction> userTransaction = [];

  void addTransaction(Transaction transaction) {
    setState(() {
      userTransaction.add(transaction);
    });
  }

  void deleteTransaction(String id) {
    setState(() {
      userTransaction.removeWhere((transaction) {
        return transaction.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget noTransaction() {
      return Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
              child: Image.asset("assets/images/waiting.png"),
            ),
            Text("No Transaction added yet"),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "My Expenses",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: "Satisfy",
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
      body: SingleChildScrollView(
        child: userTransaction.isEmpty
            ? noTransaction()
            : Column(
                children: [
                  Chart(),
                  TransactionList(userTransaction, deleteTransaction),
                ],
              ),
      ),
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
