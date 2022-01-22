import 'package:flutter/foundation.dart';



class Transaction{
   String id;
   String title;
   double money;
   DateTime date;

  Transaction({required this.id,required this.title,required this.money,required this.date});
}