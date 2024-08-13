import 'package:tic_tac_toe/feature/home/view/home_view.dart';
import 'package:tic_tac_toe/feature/home/view_model/home_view_model.dart';
import 'package:tic_tac_toe/product/service/login_service.dart';
import 'package:tic_tac_toe/product/state/base/base_state.dart';

/// Manage your home view business logic
mixin HomeViewMixin on BaseState<HomeView> {
  late final HomeViewModel _homeViewModel;

  HomeViewModel get homeViewModel => _homeViewModel;

  @override
  void initState() {
    super.initState();

    _homeViewModel = HomeViewModel(
      operationService: LoginService(),
    );
  }
}
