import 'package:manage_gym/common/exceptions/exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:manage_gym/common/usecases/usecase.dart';
import 'package:manage_gym/features/auth/domain/repositories/auth_repository.dart';

class CurrentUserIdUseCase extends SimpleUseCase<String, Nothing> {
  final AuthRepository repository;
  CurrentUserIdUseCase({required this.repository});

  @override
  Future<String> call(Nothing param) async {
    return await repository.currentUserId();
  }
}
