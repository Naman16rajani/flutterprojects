import 'package:futter/UI/transactions.dart';

import '../modal/Transection.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

import 'UI/cards.dart';
import 'UI/chart.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.white,
      title: "first app",
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  // Home({Key? key}) : super(key: key);
  List<Transaction> transaction = [
    Transaction(id: "t1", title: "a", money: 15.5, date: DateTime.now().subtract(Duration(days: 7))),
    Transaction(id: "t2", title: "b", money: 25.5, date: DateTime.now().subtract(Duration(days: 6))),
    Transaction(id: "t3", title: "c", money: 35.5, date: DateTime.now().subtract(Duration(days: 5))),
    Transaction(id: "t4", title: "d", money: 45.5, date: DateTime.now().subtract(Duration(days: 4))),
    Transaction(id: "t5", title: "e", money: 55.5, date: DateTime.now().subtract(Duration(days: 3))),
    Transaction(id: "t6", title: "f", money: 65.5, date: DateTime.now().subtract(Duration(days: 3))),
    Transaction(id: "t9", title: "n", money: 95.5, date: DateTime.now().subtract(Duration(days: 2))),
    Transaction(id: "t7", title: "g", money: 75.5, date: DateTime.now().subtract(Duration(days: 1))),
    Transaction(id: "t8", title: "h", money: 85.5, date: DateTime.now().subtract(Duration(days: 0))),
  ];

  // TextEditingController _title = TextEditingController();
  // TextEditingController _money = TextEditingController();
  // TextEditingController _date = TextEditingController();
  // String _id = "";
// int i=4;

  void deleteTransaction(int i){
    setState(() {
      transaction.removeAt(i);
    });
  }

  void onClick(String id, String title, double money, DateTime date) {
    setState(() {
      // _id="t" + i.toString();
      // i+=1;

      Transaction n = Transaction(
        id: id,
        title: title,
        money: money,
        date: date,
        // date: (_date.text.isNotEmpty
        //     ? DateTime.parse(_date.text)
        //     : DateTime.now())
      );
      transaction.add(n);
    });
  }

  void userInputModal(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bctx) {
          return newTX(onClick);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("XpensTraker"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              userInputModal(context);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          userInputModal(context);
        },
      ),
      body: Container(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Chart(transaction),


              const Padding(padding: EdgeInsets.all(10)),
              Container(
                height: 500,
                child: transaction.isNotEmpty?txCard(transaction,deleteTransaction):Column(
                  children: [
                    const Text(
                      "Please, enter transactions",
                      textAlign: TextAlign.center,
                      style: TextStyle(

                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Image.asset("images/5799682-01.png"),
                  ],
                ),
                // color: Colors.lightBlueAccent,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
