import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../modal/Transection.dart';
// import 'dart:async';

class txCard extends StatefulWidget {
  final List<Transaction> _transaction;
  final Function dlFunc;

  txCard(this._transaction, this.dlFunc);

  @override
  State<StatefulWidget> createState() {
    return txCardState(_transaction);
  }
}

class txCardState extends State<txCard> {
  List<Transaction> _transaction;

  txCardState(this._transaction);

  void _onDl(int i) {
    widget.dlFunc(
      i,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return Card(
          child: ListTile(
            // leading: CircleAvatar(
              leading: FittedBox(
                child: Text(
                  _transaction[index].money.toStringAsFixed(2),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.greenAccent,
                  ),
                ),
              ),
            // ),
            title: Text(
              _transaction[index].title,
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            subtitle: Text(
                  "${DateFormat().format(_transaction[index].date)}",
                  style: TextStyle(
                    color: Colors.lightGreenAccent,
                  ),
                ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () { _onDl(index); },

            ),
          ),




          // shape: ShapeBorder,
          // child: Row(
          //   children: [
          //     Container(
          //       width: 115,
          //       child: FittedBox(
          //         child: Text(
          //           _transaction[index].money.toStringAsFixed(2),
          //           textAlign: TextAlign.center,
          //           style: TextStyle(
          //             fontWeight: FontWeight.bold,
          //             fontSize: 20,
          //             color: Colors.greenAccent,
          //           ),
          //         ),
          //       ),
          //       margin: EdgeInsets.symmetric(vertical: 9, horizontal: 15),
          //       decoration: BoxDecoration(
          //           border: Border.all(
          //             color: Colors.greenAccent,
          //             width: 3,
          //           ),
          //           borderRadius: BorderRadius.circular(20)),
          //       padding: EdgeInsets.all(10),
          //     ),
          //     Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       children: [
          //         Text(
          //           _transaction[index].title,
          //           style: TextStyle(
          //             color: Colors.green,
          //             fontWeight: FontWeight.bold,
          //             fontSize: 16,
          //           ),
          //         ),
          //         Text(
          //           "${DateFormat().format(_transaction[index].date)}",
          //           style: TextStyle(
          //             color: Colors.lightGreenAccent,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ],
          // ),
        );
      },
      itemCount: _transaction.length,
      // children: _transaction.map((t) {
      // }
      // ).toList(),
    );
  }
}
