// ignore_for_file: avoid_print
import 'package:budgetory_v1/Controller/DB/category_db_f.dart';
import 'package:budgetory_v1/Controller/DB/transaction_db_f.dart';
import 'package:budgetory_v1/DataBase/Models/ModalCategory/category_model.dart';
import 'package:budgetory_v1/Controller/colors/color.dart';
import 'package:flutter/material.dart';

ValueNotifier<CategoryType> selectedCategory =
    ValueNotifier(CategoryType.income);

Future<void> pop({required BuildContext context, required tabBarIndex}) async {
  CategoryDB.instance.refreshUI();
  TransactionDB.instance.refreshUiTransaction();
  CategoryDB.instance.refreshUI();
  final categoryController = TextEditingController();
  final colorId = ColorsID();
  showDialog(
    context: context,
    builder: (ctx) {
      return SimpleDialog(
        title: Center(
            child: Text('Category', style: TextStyle(color: colorId.btnColor))),
        children: [
          //*add new category
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: categoryController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
          //******* */
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(colorId.btnColor)),
              onPressed: () {
                final cat = categoryController.text;
                if (cat.isEmpty) {
                  return;
                } else {
                  final type = (tabBarIndex == 0
                      ? CategoryType.income
                      : CategoryType.expense);
                  final category = CategoryModel(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      name: cat,
                      type: type);
                  CategoryDB().insertCategory(category);
                  CategoryDB().getCategories();
                  print(CategoryDB.instance.getCategories().toString());
                  Navigator.of(ctx).pop();
                  print('🎉🎉Category  box closed');
                }
              },
              child: const Text('Add Category'),
            ),
          )
        ],
      );
    },
  );
}
