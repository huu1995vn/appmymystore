import 'dart:math';

Map<String, Map> unit = {
  'copper': {'value': 1, 'label': 'đồng'},
  'thousand': {'value': 1000, 'label': 'nghìn'},
  'million': {'value': 1000000, 'label': 'triệu'},
  'billion': {'value': 1000000000, 'label': 'tỷ'}
};

//Hàm get Unit bằng value nếu typeUnit == null
dynamic getUnitByValue(value) {
  var i = log(value) / log(1000);
  var iValue = pow(1000, i);
  if (iValue >= 1000000000) {
    return unit["billion"];
  }
  if (iValue >= 1000000) {
    return unit["million"];
  }
  if (iValue >= 1000) {
    return unit["thousand"];
  }
  return unit["copper"];
}

//Hàm định dạng curreny loại bỏ 0 không ý nghĩa
dynamic formatCurrency(currenry) {
  var lCurreny = currenry.split(".");
  var numberPart = lCurreny[0];
  var decimalPart = lCurreny[1];
  while (decimalPart != null && decimalPart.endsWith("0")) {
    decimalPart = decimalPart.substring(0, decimalPart.length - 1);
  }
  if (decimalPart != null && decimalPart.length > 0) {
    return numberPart + "," + decimalPart;
  } else {
    return numberPart;
  }
}

dynamic format(dynamic amount,
    {bool onlyString = false, String? typeUnit, int numRound = 3}) {
  if (amount == null) return null;
  try {
    var iCurrency = unit[typeUnit];

    iCurrency ??= getUnitByValue(amount);

    amount = amount ?? 0; // không để giá trị bị lỗi
    var valueCurrency = amount / iCurrency!['value'];
    if (numRound != null && numRound > 0) {
      valueCurrency = valueCurrency.toStringAsFixed(numRound);
    }
    // valueCurrency = new DecimalPipe('en-US').transform(amount / iCurrency['value'], '1.2-' + numRound);  // giá trị
    valueCurrency = formatCurrency(valueCurrency);
    var typeCurrency = iCurrency!['label']; // đơn vị
    return '${valueCurrency ?? 0} $typeCurrency';

    // return {
    //     currency: valueCurrency,
    //     type: typeCurrency
    // }
  } catch (error) {
    return amount;
  }
}
