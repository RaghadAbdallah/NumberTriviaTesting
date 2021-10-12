import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:testing_proj/core/error/exceptions.dart';
import 'package:testing_proj/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  /// Calls the http://numbersapi.com/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  /// Calls the http://numbersapi.com/random endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource{
  final http.Client client;

  NumberTriviaRemoteDataSourceImpl({
    required this.client});
  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) => _getTriviaFromUrl('http://numbersapi.com/$number?json');
  @override
  Future<NumberTriviaModel> getRandomNumberTrivia()  => _getTriviaFromUrl('http://numbersapi.com/random?json');

  Future<NumberTriviaModel> _getTriviaFromUrl(String url) async{
    final response = await client.get(Uri.parse(url));

    if(response.statusCode == 200){
      return NumberTriviaModel.fromJson(json.decode(response.body));
    } else{
      throw ServerException();
    }
  }

}
