import 'package:tic_tac_toe/product/state/container/product_state_container.dart';
import 'package:tic_tac_toe/product/state/view_model/product_view_model.dart';

final class ProductStateItems {
  const ProductStateItems._();

  static ProductViewModel get productViewModel =>
      ProductContainer.read<ProductViewModel>();
}
