import 'package:dio/dio.dart';
import 'package:ioasys_currency/models/currencies.dart';
import 'package:ioasys_currency/models/currency.dart';

class FetchCurrenciesCommand {
  Future<Currencies> call({
    required double value,
    required Currency from,
    required Currency to,
  }) async {
    final currenciesStr = '${from.toApi()}${to.toApi()}';
    final response =
        await Dio().get('https://api.hgbrasil.com/finance', queryParameters: {
      'format': 'json',
      'currencies': currenciesStr,
    });
    print(response.data);
    final currencies = response.data['results']['currencies'];
    final dolar = value / currencies['USD']['buy'];
    final euro = value / currencies['EUR']['buy'];
    return Currencies(dolar: 0.0, euro: 0.0, real: 0.0);
  }
}
