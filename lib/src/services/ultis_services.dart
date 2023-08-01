import 'package:intl/intl.dart';

class UltisServices {
  // Retorna uma string com R$
  String priceToCurrency(double price) {
    NumberFormat numberFormat = NumberFormat.simpleCurrency(locale: 'pt_BR');

    return numberFormat.format(price);
  }
}
