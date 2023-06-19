import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';

import '../exceptions/exceptions.dart';

extension EitherExtension on Future {
  Future<Either<Failure, T>> toEither<T>() async {
    try {
      final result = await this;
      return Right(result);
    } on Failure catch (e) {
      print(e);
      return Left(e);
    } catch (e, s) {
      print(e);
      print(s);
      return Left(Failure(message: 'unexpected_failure_message'.tr()));
    }
  }
}
