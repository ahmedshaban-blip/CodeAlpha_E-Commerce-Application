import '../../domain/repositories/thankyou_repository.dart';
import '../datasources/thankyou_remote_datasource.dart';

class ThankyouRepositoryImpl implements ThankyouRepository {
  final ThankyouRemoteDataSource remoteDataSource;

  ThankyouRepositoryImpl(this.remoteDataSource);

  // TODO: Implement repository logic
}
