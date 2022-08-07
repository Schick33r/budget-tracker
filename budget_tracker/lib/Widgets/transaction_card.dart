import 'package:flutter/material.dart';
import 'package:budget_tracker/services/theme_services.dart';
import 'package:provider/provider.dart';
import '../models/transaction_item.dart';
import '../services/budget_view_model.dart';

class TransactionCard extends StatelessWidget {
  final TransactionItem item;

  const TransactionCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context, listen: false);
    return GestureDetector(
      onTap: (() => showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(children: [
                  const Text("Delete item"),
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        final budgetViewModel = Provider.of<BudgetViewModel>(
                            context,
                            listen: false);
                        budgetViewModel.deleteItem(item);
                        Navigator.pop(context);
                      },
                      child: const Text("Yes")),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("No"))
                ]),
              ),
            );
          })),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
        child: Container(
            height: 60,
            width: MediaQuery.of(context).size.width, //screenSize.width,
            decoration: BoxDecoration(
                color: (themeService.darkTheme
                    ? Theme.of(context).colorScheme.background
                    : Colors.grey[200]),

                // Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(item.itemTitle,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  Text((!item.isExpense ? "+ " : "- ") + item.amount.toString(),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500)),
                ],
              ),
            )),
      ),
    );
  }
}
