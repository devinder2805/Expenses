import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  DateTime? selectedDate;

  void presentDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Theme.of(context).colorScheme.secondary,
                onPrimary: Colors.white,
                surface: Theme.of(context).primaryColor,
              ),
            ),
            child: child!,
          );
        }).then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        setState(() {
          selectedDate = pickedDate;
        });
      }
    });
  }

  void submitTransaction() {
    final title = titleController.text;
    double? amount;

    if (amountController.text.isEmpty) {
      amount = 0;
    } else {
      amount = double.parse(amountController.text);
    }

    if (titleController.text.isEmpty || amount <= 0 || selectedDate == null) {
      return;
    }

    Transaction transaction = Transaction(
      date: selectedDate as DateTime,
      id: DateTime.now().toString(),
      title: title,
      price: amount,
    );

    widget.addTransaction(transaction);

    Navigator.of(context).pop();
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

    return Card(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            textField("Enter title", TextInputType.text, titleController),
            textField("Enter amount", TextInputType.number, amountController),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedDate == null
                          ? "No date chosen"
                          : DateFormat.yMMMd().format(selectedDate as DateTime),
                    ),
                    TextButton(
                      onPressed: presentDatePicker,
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
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: OutlinedButton(
                onPressed: submitTransaction,
                style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.all(10),
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                child: const Text(
                  "Add Transaction",
                  style: TextStyle(
                    color: Colors.amber,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
