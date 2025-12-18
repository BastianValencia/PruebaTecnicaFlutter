import 'package:intl/intl.dart';

class CurrencyFormatter {
  static final NumberFormat _formatter = NumberFormat.currency(
    locale: 'es_CL', 
    symbol: '\$',
    decimalDigits: 0, 
    customPattern: '\u00A4 #,###', 
  );

  static String format(double value, {String currency = 'USD'}) {
    return '${_formatter.format(value)} $currency';
  }
}
