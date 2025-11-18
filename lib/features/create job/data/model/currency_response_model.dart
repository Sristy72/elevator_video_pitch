class CurrencyResponseModel {
  final List<CurrencyData> currencies;

  CurrencyResponseModel({required this.currencies});

  factory CurrencyResponseModel.fromJson(Map<String, dynamic> json) {
    try {
      // ✅ Directly read items (since repo passes response.data['data'])
      final List<dynamic> dataList = (json['items'] is List)
          ? json['items']
          : [];

      return CurrencyResponseModel(
        currencies: dataList
            .map((item) => CurrencyData.fromJson(item))
            .toList(),
      );
    } catch (e) {
      throw Exception("Failed to parse CurrencyResponseModel: $e");
    }
  }

  Map<String, dynamic> toJson() {
    return {'currencies': currencies.map((e) => e.toJson()).toList()};
  }
}

class CurrencyData {
  final String id;
  final String code;
  final String currencyName;
  final String primaryCountry;
  final String? symbol;
  final String? flag;

  CurrencyData({
    required this.id,
    required this.code,
    required this.currencyName,
    required this.primaryCountry,
    this.symbol,
    this.flag,
  });

  factory CurrencyData.fromJson(Map<String, dynamic> json) {
    return CurrencyData(
      id: json['_id'] ?? '',
      code: json['code'] ?? '',
      currencyName: json['currencyName'] ?? '',
      primaryCountry: json['primaryCountry'] ?? '',
      symbol: json['symbol'],
      flag: json['flag'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'code': code,
      'currencyName': currencyName,
      'primaryCountry': primaryCountry,
      'symbol': symbol,
      'flag': flag,
    };
  }
}



