import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:manage_gym/common/exceptions/exceptions.dart';

abstract class UseCase<Type, Param> {
  Future<Either<Failure, Type>> call(Param param);
}

abstract class SimpleUseCase<Type, Param> {
  Future<Type> call(Param param);
}

class Nothing extends Equatable {
  @override
  List<Object> get props => [];
}
