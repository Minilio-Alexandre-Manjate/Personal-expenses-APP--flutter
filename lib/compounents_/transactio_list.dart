import 'package:expenses/models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expenses/src/shared/themes/color_schemes.g.dart';

class TransactoList extends StatelessWidget {
  final List<Transaction> transactions;

  final void Function(String) onRemove;
  const TransactoList(this.transactions, this.onRemove, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      child: transactions.isEmpty
          ? SizedBox(
              height: 10,
              child: Column(
                children: [
                  const SizedBox(
                    height: 200,
                    child: Text(
                      'No transaction registered!!',
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 250,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                final tr = transactions[index];
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      foregroundColor: const Color.fromARGB(255, 12, 12, 12),
                      radius: 45,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(child: Text('\$${tr.value}')),
                      ),
                    ),
                    title: Text(
                      tr.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Text(
                      DateFormat('d MMM y').format(tr.date),
                    ),
                    trailing: IconButton(
                      onPressed: () => onRemove(tr.id),
                      icon: Icon(
                        Icons.delete,
                        color: lightColorScheme.tertiary,
                      ),
                    ),
                  ),
                );
              }),
    );
  }
}
