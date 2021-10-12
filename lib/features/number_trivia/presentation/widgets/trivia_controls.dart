import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_proj/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:testing_proj/features/number_trivia/presentation/bloc/number_trivia_event.dart';

class TriviaControls extends StatefulWidget {
  @override
  _TriviaControlsState createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  late String inputNumber;
  final controller =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        TextField(
          controller: controller,
          decoration:InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Input Number') ,
          keyboardType: TextInputType.number,
          onChanged: (value){
            inputNumber=value ;},
          onSubmitted: (_){
            dispatchConcrete();},),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
                child:MaterialButton(
                  color: Theme.of(context).accentColor,
                  textTheme: ButtonTextTheme.normal,
                  child:Text('Search',style: TextStyle(fontSize: 20),) ,
                  onPressed:dispatchConcrete ,)),
            SizedBox(width: 10,),
            Expanded(child:MaterialButton(
              color: Theme.of(context).accentColor,
              textTheme: ButtonTextTheme.normal,
              child:Text('Get Random Number',style: TextStyle(fontSize: 16),) ,
              onPressed:dispatchRandom ,)),
          ],
        )
      ],
    );
  }

  void dispatchConcrete(){
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context).add(GetTriviaForConcreteNumber(inputNumber));
  }

  void dispatchRandom(){
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context).add(GetTriviaForRandomNumber());
  }
}
