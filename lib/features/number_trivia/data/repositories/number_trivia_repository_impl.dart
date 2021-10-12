import 'package:dartz/dartz.dart';
import 'package:testing_proj/core/error/exceptions.dart';
import 'package:testing_proj/core/error/failures.dart';
import 'package:testing_proj/core/network/network_info.dart';
import 'package:testing_proj/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:testing_proj/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:testing_proj/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:testing_proj/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:testing_proj/features/number_trivia/domain/repositories/number_trivia_repository.dart';

typedef Future<NumberTriviaModel> _ConcreteOrRandomChooser();

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaLocalDataSource localDataSource;
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl(
      {required this.localDataSource,
        required this.remoteDataSource,
        required this.networkInfo});

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number) async{
    return await _getTrivia((){
      return remoteDataSource.getConcreteNumberTrivia(number);
    });

  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return await _getTrivia((){
      return remoteDataSource.getRandomNumberTrivia();
    });
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(
      _ConcreteOrRandomChooser getConcreteOrRandom)async{
    if(await networkInfo.isConnected) {
      try{
        final remoteTrivia=await getConcreteOrRandom();
        localDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException{
        return Left(ServerFailure());
      }
    }else{
      try{
        final localTrivia= await localDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException{
        return Left(CacheFailure());
      }
    }
  }
}