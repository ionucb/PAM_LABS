import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: Calculator()));
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final priceController = TextEditingController();
  final percentController = TextEditingController();
  String currency = 'MDL';
  String discountText = '';
  String finalText = '';

  void calculate() {
    double price = double.parse(priceController.text);
    double percent = double.parse(percentController.text);
    double discount = price * percent / 100;

    setState(() {
      discountText = 'Reducere: ${discount.toStringAsFixed(2)} $currency';
      finalText = 'Preț final: ${(price - discount).toStringAsFixed(2)} $currency';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator de reducere')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Preț inițial'),
            ),
            TextField(
              controller: percentController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Reducere (%)'),
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: currency,
              items: const [
                DropdownMenuItem(value: 'MDL', child: Text('MDL')),
                DropdownMenuItem(value: 'EUR', child: Text('EUR')),
                DropdownMenuItem(value: 'USD', child: Text('USD')),
              ],
              onChanged: (value) {
                setState(() {
                  currency = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculate,
              child: const Text('Calculează'),
            ),
            const SizedBox(height: 20),
            Text(discountText, style: const TextStyle(fontSize: 20)),
            Text(finalText, style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
