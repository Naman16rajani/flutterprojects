import 'package:flutter/material.dart';
import 'dart:async';
class newTX extends StatefulWidget {
  final Function txFunc;
  newTX(this.txFunc);

  @override
  State<StatefulWidget> createState() {
    return newTXState();
  }
}

class newTXState extends State<newTX> {
  TextEditingController title = TextEditingController();
  TextEditingController money = TextEditingController();
  TextEditingController date = TextEditingController();
  String id = "";
  int i = 3;


  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  void _onSubmit() {
    if (money.text.isNotEmpty && title.text.isNotEmpty) {
      setState(() {
        id = "t" + i.toString();
        i += 1;
        widget.txFunc(
            id,
            title.text,
            double.parse(money.text),
            (date.text.isNotEmpty
                ? DateTime.parse(date.text)
                : selectedDate));
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            controller: money,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              label: Text("Money"),
            ),
            style: TextStyle(
              color: Colors.black,
            ),
            onSubmitted: (_) {
              _onSubmit();
            },
          ),
          TextField(
            controller: title,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              label: Text("Title"),
            ),
            style: TextStyle(
              color: Colors.black,
            ),
            onSubmitted: (_) {
              _onSubmit();
            },
          ),

          Text("${selectedDate.toLocal()}".split(' ')[0]),
          SizedBox(height: 20.0,),
          ElevatedButton(
            onPressed: () => _selectDate(context),
            child: Text('Select date'),
          ),

          // TextField(
          //   controller: date,
          //   keyboardType: TextInputType.datetime,
          //   decoration: InputDecoration(
          //     label: Text("Date"),
          //   ),
          //   style: TextStyle(
          //     color: Colors.black,
          //   ),
          // ),
          //
          Padding(padding: EdgeInsets.all(5)),
          OutlinedButton(onPressed: _onSubmit, child: Text("Submit"))
        ],
      ),
    );
  }
}
