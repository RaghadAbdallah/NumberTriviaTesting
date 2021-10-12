import 'package:flutter/material.dart';
import 'package:testing_proj/features/number_trivia/domain/entities/number_trivia.dart';

class TriviaDisplay extends StatelessWidget {
  final NumberTrivia numberTrivia;


  TriviaDisplay({required this.numberTrivia});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        children: [
          Text(numberTrivia.number.toString(),
            style: TextStyle(fontSize: 40),),
          Expanded(
            child: Center(
                child: SingleChildScrollView(
                  child: Text(
                    numberTrivia.text, style: TextStyle(fontSize: 30),),
                )),
          )
        ],),);
  }
}