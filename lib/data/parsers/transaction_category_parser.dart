import 'package:finance/core/data/categories.dart';
import 'package:finance/data/models/category.dart';

class TransactionCategoryParser {
  static TransactionCategory parse(String name) {
    return allCategories.firstWhere((element) => element.name == name);
  }
}