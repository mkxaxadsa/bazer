import 'package:finance/data/models/expense_transaction.dart';
import 'package:finance/data/models/income_transaction.dart';
import 'package:finance/data/models/transaction.dart';

class TransactionParser {
  static TransactionModel parse (Map<String,dynamic> map) {
    if(map["type"] == IncomeTransactionModel.type) return IncomeTransactionModel.fromMap(map);
    return ExpenseTransactionModel.fromMap(map);
  }
}