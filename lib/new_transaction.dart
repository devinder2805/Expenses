import 'package:flutter/material.dart';
import 'transaction.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;
  NewTransaction(this.addTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void submitTransaction(String title, String price, DateTime date) {
    var transaction = Transaction(
      date: DateTime.now(),
      id: DateTime.now().toString(),
      title: title,
      price: double.parse(price),
    );

    widget.addTransaction(transaction);
  }

  @override
  Widget build(BuildContext context) {
    Widget textField(
      String placeHolder,
      TextInputType keyboardType,
      TextEditingController controller,
    ) {
      return Container(
        margin: const EdgeInsets.all(10),
        child: TextField(
          keyboardType: keyboardType,
          controller: controller,
          cursorColor: Theme.of(context).colorScheme.secondary,
          decoration: InputDecoration(
            labelText: placeHolder,
            labelStyle: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
            ),
            contentPadding: const EdgeInsets.all(10),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.secondary,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.secondary,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          textField("Enter title", TextInputType.text, titleController),
          textField("Enter amount", TextInputType.number, amountController),
          Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("No date chosen"),
                  TextButton(
                    onPressed: null,
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationThickness: 2,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    child: const Text(
                      "Choose date",
                      style: TextStyle(color: Colors.amber),
                    ),
                  ),
                ]),
          ),
          Container(
            child: OutlinedButton(
              child: Text(
                "Add Transaction",
                style: TextStyle(color: Colors.amber),
              ),
              onPressed: () {
                submitTransaction(titleController.toString(),
                    amountController.text, DateTime.now());
              },
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.all(10),
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                side:
                    BorderSide(color: Theme.of(context).colorScheme.secondary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
