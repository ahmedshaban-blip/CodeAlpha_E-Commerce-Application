import '../../domain/repositories/accountsettings_repository.dart';
import '../datasources/accountsettings_remote_datasource.dart';

class AccountsettingsRepositoryImpl implements AccountsettingsRepository {
  final AccountsettingsRemoteDataSource remoteDataSource;

  AccountsettingsRepositoryImpl(this.remoteDataSource);

  // TODO: Implement repository logic
}
