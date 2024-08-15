import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic_tac_toe/feature/home/view/home_view.dart';
import 'package:tic_tac_toe/feature/home/view_model/home_view_model.dart';
import 'package:tic_tac_toe/product/state/base/base_state.dart';

/// Manage your home view business logic
mixin HomeViewMixin on BaseState<HomeView> {
  late final HomeViewModel _homeViewModel;

  final ValueNotifier<String> userName = ValueNotifier<String>("");

  final TextEditingController userNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  HomeViewModel get homeViewModel => _homeViewModel;

  @override
  void initState() {
    super.initState();

    _homeViewModel = HomeViewModel();
    checkUserName();

    _homeViewModel.getGames();
    _homeViewModel.listenGames();
  }

  Future<void> checkUserName() async {
    final prefs = await SharedPreferences.getInstance();
    userName.value = prefs.getString('username') ?? "";
  }

  void saveName() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', userNameController.text);
    userName.value = userNameController.text;
  }
}
