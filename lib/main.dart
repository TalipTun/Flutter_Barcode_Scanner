import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Barcode Scanner'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? scanResult;
  bool _isLoading = false; // Add this state variable for a loading indicator

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _isLoading
                  ? null
                  : handleScan, // Disable button while loading
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text("Scan"),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : Text(
                    scanResult == null
                        ? "Scan a code!"
                        : "Scan result: $scanResult",
                    textAlign: TextAlign.center,
                  ),
          ],
        ),
      ),
    );
  }

  Future<void> handleScan() async {
    setState(() {
      _isLoading = true;
      scanResult = null; // Clear the old result
    });

    final String barcode = await FlutterBarcodeScanner.scanBarcode(
      "#ff6666",
      "Cancel",
      true,
      ScanMode.BARCODE,
    );

    if (!mounted) return;

    if (barcode == '-1') {
      setState(() {
        this.scanResult =
            "Scan canceled."; // Update the state variable correctly
        _isLoading = false;
      });
      return;
    }

    final String apiUrl =
        'https://world.openfoodfacts.org/api/v2/product/$barcode.json';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 1) {
          final product = data['product'];
          final String productName =
              product['product_name'] ?? 'Product not found';
          final Map<String, dynamic> nutrients = product['nutriments'] ?? {};

          // Extract more nutrients safely
          final dynamic energyValue = nutrients['energy-kcal_100g'];
          final double calories = (energyValue is num)
              ? energyValue.toDouble()
              : 0.0;

          final dynamic proteinValue = nutrients['proteins_100g'];
          final double proteins = (proteinValue is num)
              ? proteinValue.toDouble()
              : 0.0;

          final dynamic carbsValue = nutrients['carbohydrates_100g'];
          final double carbs = (carbsValue is num)
              ? carbsValue.toDouble()
              : 0.0;

          final dynamic fatValue = nutrients['fat_100g'];
          final double fat = (fatValue is num) ? fatValue.toDouble() : 0.0;

          final dynamic sugarsValue = nutrients['sugars_100g'];
          final double sugars = (sugarsValue is num)
              ? sugarsValue.toDouble()
              : 0.0;

          final String formattedResult =
              "Product: $productName\n"
              "Calories: $calories kcal (per 100g)\n"
              "Proteins: $proteins g\n"
              "Carbohydrates: $carbs g\n"
              "Fat: $fat g\n"
              "Sugars: $sugars g";

          setState(() {
            this.scanResult = formattedResult;
          });

          setState(() {
            this.scanResult = formattedResult; // Update the state variable
          });
        } else {
          setState(() {
            this.scanResult = "Product not found."; // Update the state variable
          });
        }
      } else {
        setState(() {
          this.scanResult =
              "Failed to fetch data: ${response.statusCode}"; // Update the state variable
        });
      }
    } catch (e) {
      setState(() {
        this.scanResult = "An error occurred: $e"; // Update the state variable
      });
    } finally {
      setState(() {
        _isLoading = false; // Stop loading
      });
    }
  }
}
