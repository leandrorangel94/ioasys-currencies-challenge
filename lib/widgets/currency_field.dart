import 'package:flutter/material.dart';

typedef OnChange = void Function(double value);

class CurrencyField extends StatefulWidget {
  final String label;
  final String prefix;
  final OnChange onChanged;
  final double? value;
  final TextEditingController? controller;

  const CurrencyField({
    Key? key,
    required this.label,
    required this.prefix,
    required this.onChanged,
    this.value,
    this.controller,
  }) : super(key: key);

  @override
  State<CurrencyField> createState() => _CurrencyFieldState();
}

class _CurrencyFieldState extends State<CurrencyField> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.value != null) {
      _controller.text = widget.value.toString();
    }
    _controller.addListener(() {
      if (_controller.text.isNotEmpty) {
        widget.onChanged(double.parse(_controller.text));
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      style: const TextStyle(color: Colors.white),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: const TextStyle(
          color: Colors.white,
        ),
        prefix: Text(
          widget.prefix,
          style: const TextStyle(color: Colors.white),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
