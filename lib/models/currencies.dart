class Currencies {
  final double dolar;
  final double euro;
  final double real;

  Currencies({
    required this.dolar,
    required this.euro,
    required this.real,
  });

  @override
  String toString() => 'Currencies(dolar: $dolar, euro: $euro, real: $real)';
}
