import 'package:tic_tac_toe/feature/home/view_model/state/home_state.dart';
import 'package:tic_tac_toe/product/service/interface/authenction_operation.dart';
import 'package:tic_tac_toe/product/state/base/base_cubit.dart';

/// Manage your home view business logic
final class HomeViewModel extends BaseCubit<HomeState> {
  /// [AuthenticationOperation] service
  HomeViewModel({
    required AuthenticationOperation operationService,
  })  : _authenticationOperationService = operationService,
        super(const HomeState(
          isLoading: false,
        ));

  final AuthenticationOperation _authenticationOperationService;

  void changeColor(int gridColor) {
    emit(state.copyWith(gridColor: gridColor));
  }

  /// Change loading state
  void changeLoading() {
    emit(state.copyWith(isLoading: !state.isLoading));
  }

  /// Get users
  Future<void> fetchUsers() async {
    // CustomLogger.showError<User>(usersFromCache);
    final response = await _authenticationOperationService.users();
    emit(state.copyWith(users: response));
  }
}
