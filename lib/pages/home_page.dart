import 'package:flutter/material.dart';
import 'package:ioasys_currency/commands/fetch_currencies_command.dart';
import 'package:ioasys_currency/models/currencies.dart';
import 'package:ioasys_currency/models/currency.dart';
import 'package:ioasys_currency/widgets/currency_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final fetchCurrencies = FetchCurrenciesCommand();

  final _realController = TextEditingController();
  final _dolarController = TextEditingController();
  final _euroController = TextEditingController();

  double? dolar;
  double? euro;

  @override
  void initState() {
    super.initState();
    _realController.addListener(() {
      if (_realController.text.isNotEmpty) {
        fetchData(double.parse(_realController.text), Currency.real);
      }
    });
  }

  void setCurrencies(Currencies currencies) {
    _dolarController.text = currencies.dolar.toStringAsFixed(2);
    _euroController.text = currencies.euro.toStringAsFixed(2);
    _realController.text = currencies.real.toStringAsFixed(2);
  }

  void fetchData(double real, Currency from) async {
    if (from != Currency.dolar) {
      final currencies = await fetchCurrencies(
        value: real,
        from: from,
        to: Currency.dolar,
      );
      print(currencies);
    }
    // setCurrencies(currencies);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF17152A),
      appBar: AppBar(
        backgroundColor: const Color(0xFFC1007E),
        leading: const Image(image: AssetImage('assets/images/logo.png')),
        title: const Text('Conversor de Moedas'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 38.0, vertical: 50.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const Image(image: AssetImage('assets/images/moeda.png')),
              const SizedBox(height: 50.0),
              CurrencyField(
                label: 'Reais',
                prefix: 'R\$ ',
                controller: _realController,
                onChanged: (value) => fetchData(value, Currency.real),
              ),
              const SizedBox(height: 35.0),
              CurrencyField(
                  label: 'Dólares',
                  prefix: 'US\$ ',
                  value: dolar,
                  controller: _dolarController,
                  onChanged: (double value) {}),
              const SizedBox(height: 35.0),
              CurrencyField(
                label: 'Euros',
                prefix: '€ ',
                value: euro,
                controller: _euroController,
                onChanged: (double value) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
