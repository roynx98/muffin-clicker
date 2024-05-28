import 'dart:math';

class Number {
  final String label;
  final int value;
  Number({required this.label, required this.value});
}

final bigNumberLabels = [
  Number(label: 'million', value: pow(10, 6).toInt()),
  Number(label: 'billion', value: pow(10, 6).toInt()),
  // Number(label: 'trillion', value: pow(10, 12).toInt()),
  // Number(label: 'quadtrillion', value: pow(10, 15).toInt()),
  // Number(label: 'quintillion', value: pow(10, 18).toInt()),
];

String formatNumber(int number) {
  for (var i = bigNumberLabels.length - 1; i >= 0; i--) {
    final bigNumberLabel = bigNumberLabels[i];
    if (number >= bigNumberLabel.value) {
      var limitedNumber = (number.toDouble() / bigNumberLabel.value.toDouble())
          .toStringAsFixed(2);

      while (limitedNumber[limitedNumber.length - 1] == '0') {
        limitedNumber = limitedNumber.substring(0, limitedNumber.length - 1);
      }
      if (limitedNumber[limitedNumber.length - 1] == '.') {
        limitedNumber = limitedNumber.substring(0, limitedNumber.length - 1);
      }

      return '$limitedNumber ${bigNumberLabel.label}';
    }
  }

  final sNumber = '$number';
  var res = '';

  for (var i = 0; i < sNumber.length; i++) {
    final addSeparator = (i + 1) % 3 == 0 && i < (sNumber.length - 1);
    res = (addSeparator ? ',' : '') + sNumber[sNumber.length - 1 - i] + res;
  }

  return res;
}
