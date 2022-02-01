enum Currency {
  dolar,
  real,
  euro,
}

extension CurrencyExtension on Currency {
  String toApi() {
    switch (this) {
      case Currency.dolar:
        return 'USD';
      case Currency.euro:
        return 'EUR';
      case Currency.real:
        return 'BRL';
    }
  }
}
