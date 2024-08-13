import 'package:finance/data/models/categories.dart';

const incomeCategories = [
  Business(),
  Salary(),
  Dividents(),
  InvestmentIncome(),
  Rent(),
  Freelance(),
  Royalty(),
  Passive(),
];

const expenseCategories = [
  Procurement(),
  Food(),
  Transport(),
  Rest(),
  InvestmentExpense(),
];


const allCategories = [...incomeCategories,...expenseCategories];