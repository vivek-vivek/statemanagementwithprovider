// ignore_for_file: avoid_print

import 'package:budgetory_v1/Controller/DB/category_db_f.dart';
import 'package:budgetory_v1/Controller/DB/transaction_db_f.dart';
import 'package:budgetory_v1/DataBase/Models/ModalCategory/category_model.dart';
import 'package:flutter/material.dart';

ValueNotifier<CategoryType> selectedCategory =
    ValueNotifier(CategoryType.income);

Future<void> popUpCaBtnCategoryRadio(
    {required BuildContext context, required selectedTypeCat}) async {
  CategoryDB.instance.refreshUI();
  TransactionDB.instance.refreshUiTransaction();
  CategoryDB.instance.refreshUI();
  final categoryController = TextEditingController();
  showDialog(
    context: context,
    builder: (ctx) {
      return SimpleDialog(
        title: const Center(child: Text('Category')),
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     RadioFunction(
          //       tittle: 'Income',
          //       type: CategoryType.income,
          //       selectedType: selectedTypeCat,
          //     ),
          //     const Padding(
          //       padding: EdgeInsets.only(right: 15),
          //       child: RadioFunction(
          //         tittle: 'Expense',
          //         type: CategoryType.expense,
          //         selectedType: null,
          //       ),
          //     ),
          //   ],
          // ),
          //*add new category
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              maxLength: 10,
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
              onPressed: () async {
                final cat = categoryController.text;
                if (cat.isEmpty) {
                  return;
                } else {
                  final type = selectedTypeCat == CategoryType.income
                      ? CategoryType.income
                      : CategoryType.expense;
                  final category = CategoryModel(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      name: cat,
                      type: type);

                  CategoryDB().insertCategory(category);
                  // CategoryDB().getCategories();
                  await CategoryDB.instance.refreshUI();
                  // ignore: use_build_context_synchronously
                  Navigator.of(ctx).pop();
                  print('🎉🎉Category  box closed');
                  print(type);
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
