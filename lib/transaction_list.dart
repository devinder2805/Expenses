import 'package:flutter/material.dart';
import 'transaction.dart';

class TransactionList extends StatelessWidget {
  TransactionList({super.key});

  List<Transaction> userTransaction = [
    Transaction(
      id: "t1",
      title: "test",
      price: 12.34,
      date: DateTime(2023, 5, 12),
    ),
    Transaction(
      id: "t2",
      title: "Grocery",
      price: 52.34,
      date: DateTime(2023, 6, 12),
    ),
    Transaction(
      id: "t3",
      title: "Shoes",
      price: 52.34,
      date: DateTime(2023, 10, 12),
    ),
    Transaction(
      id: "t3",
      title: "Shoes",
      price: 52.34,
      date: DateTime(2023, 10, 12),
    ),
    Transaction(
      id: "t3",
      title: "Shoes",
      price: 52.34,
      date: DateTime(2023, 10, 12),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: userTransaction.map((transaction) {
          return Card(
            margin: EdgeInsets.all(5),
            elevation: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    "\$ ${transaction.price}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "${transaction.title}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "${transaction.date}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
