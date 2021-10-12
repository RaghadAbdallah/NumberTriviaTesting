import 'package:dartz/dartz.dart';
import 'package:testing_proj/core/error/failures.dart';
import 'package:testing_proj/features/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure,NumberTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Failure,NumberTrivia>> getRandomNumberTrivia();
}