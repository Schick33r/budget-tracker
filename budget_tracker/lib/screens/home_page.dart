import 'package:budget_tracker/services/budget_view_model.dart';
import 'package:budget_tracker/services/theme_services.dart';
import 'package:flutter/material.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../Widgets/add_transaction_dialog.dart';
import '../Widgets/transaction_card.dart';
import '../models/transaction_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context, listen: false);
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AddTransactionDialog(
                  itemToAdd: (transactionItem) {
                    final budgetService =
                        Provider.of<BudgetViewModel>(context, listen: false);
                    budgetService.addItem(transactionItem);
                    // setState(() {
                    //   items.add(transactionItem);
                    // });
                  },
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
            width: screenSize.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: Consumer<BudgetViewModel>(
                      builder: ((context, value, child) {
                        final balance = value.getBalance(); // <- new
                        final budget = value.getBudget(); // <- new
                        double percentage = balance / budget;
                        // Making sure percentage isnt negative and isnt bigger than 1
                        if (percentage < 0) {
                          percentage = 0;
                        }
                        if (percentage > 1) {
                          percentage = 1;
                        }

                        return CircularPercentIndicator(
                          radius: screenSize.width / 2,
                          lineWidth: 10.0,
                          percent: percentage,
                          backgroundColor: Colors.white,
                          center: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "\$" +
                                    balance
                                        .toString()
                                        .split(".")[0], // <- updated
                                style: const TextStyle(
                                    fontSize: 48, fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                "Balance",
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                "Budget: \$" + budget.toString(), // <- updated
                                style: const TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                          progressColor: Theme.of(context).colorScheme.primary,
                        );
                      }),
                    )),
                const SizedBox(
                  height: 35,
                ),
                const Text(
                  "Items",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Consumer<BudgetViewModel>(
                  builder: ((context, value, child) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: value.items.length,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return TransactionCard(
                            item: value.items[index],
                          );
                        });
                    //  List.generate(
                    // items.length,
                    // (index) => TransactionCard(
                    //       item: items[index],
                    //     )),
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
