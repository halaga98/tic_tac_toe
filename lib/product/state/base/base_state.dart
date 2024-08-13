import 'package:flutter/material.dart';
import 'package:tic_tac_toe/product/state/container/product_state_items.dart';
import 'package:tic_tac_toe/product/state/view_model/product_view_model.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  ProductViewModel get productViewModel => ProductStateItems.productViewModel;
}
