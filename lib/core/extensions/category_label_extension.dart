import 'package:flutter/material.dart';

import 'l10n_x.dart';

extension CategoryLabelExtension on String {
  String toCategoryLabel(BuildContext context) {
    return switch (this) {
      'food' => context.tr.cat_food,
      'shopping' => context.tr.cat_shopping,
      'transport' => context.tr.cat_transport,
      _ => context.tr.cat_other,
    };
  }

  IconData toCategoryIcon() {
    return switch (this) {
      'food' => Icons.restaurant_outlined,
      'shopping' => Icons.shopping_bag_outlined,
      'transport' => Icons.directions_car_filled_outlined,
      _ => Icons.category_outlined,
    };
  }
}
