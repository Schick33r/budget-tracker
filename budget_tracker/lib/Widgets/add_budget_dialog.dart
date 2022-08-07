import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddBudgetDialog extends StatefulWidget {
  final Function(double) budgetToAdd;
  const AddBudgetDialog({Key? key, required this.budgetToAdd})
      : super(key: key);

  @override
  State<AddBudgetDialog> createState() => _AddBudgetDialogState();
}

class _AddBudgetDialogState extends State<AddBudgetDialog> {
  final TextEditingController budgetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
          width: MediaQuery.of(context).size.width / 1.3,
          height: 200,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Add a budget', style: TextStyle(fontSize: 18)),
                const SizedBox(height: 15),
                TextField(
                  controller: budgetController,
                  decoration: const InputDecoration(hintText: 'Budget in \$'),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                    onPressed: () {
                      if (budgetController.text.isNotEmpty) {
                        widget.budgetToAdd(double.parse(budgetController.text));
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Add'))
              ],
            ),
          )),
    );
  }
}
