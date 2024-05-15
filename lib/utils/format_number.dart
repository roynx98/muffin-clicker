
String formatNumber(int number) {
  final sNumber = '$number';
  var res = '';

  for (var i = 0; i < sNumber.length; i++) {
    final addSeparator = (i + 1) % 3 == 0 && i < (sNumber.length - 1);
    res =  (addSeparator ? ',' : '') + sNumber[sNumber.length - 1 - i] + res;
  }

  return res;
}
