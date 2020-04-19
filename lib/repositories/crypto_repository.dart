import 'dart:convert';

import 'package:cryptocoinprice/models/crypto_coin_model.dart';
import 'package:cryptocoinprice/repositories/base_crypto_repository.dart';
import 'package:http/http.dart' as http;

class CryptoRepository extends BaseCryptoRepository {
  static const String _baseUrl = 'https://min-api.cryptocompare.com';
  static const int cryptoCoinsPerPage = 20;

  final http.Client _httpClient;

  CryptoRepository({http.Client httpClient})
      : _httpClient = httpClient ?? http.Client();

  @override
  Future<List<CryptoCoin>> getTopCoins({int page}) async {
    List<CryptoCoin> cryptoCoins = [];
    String requestURL = '$_baseUrl/data/top/totalvolfull?limit=$cryptoCoinsPerPage&tsym=USD&page=$page';
    try {
      final response = await _httpClient.get(requestURL);
      if (response.statusCode == 200) {
        // response.body is a string which we are decoding into map String dynamic aka a JSON object
        Map<String, dynamic> data = json.decode(response.body);
        List<dynamic> cryptoCoinList = data['Data'];

        // iterates over the cryptoCoinList converting each json into a crypto_coin_model
        cryptoCoinList.forEach(
          // which then get's added to the list of crypto coins
              (json) => cryptoCoins.add(CryptoCoin.fromJson(json)),
        );
      }
      // returns new list of coins
      return cryptoCoins;
    } catch (err) {
      throw err;
    }
  }

  @override
  void dispose() {
    _httpClient.close();
  }
}


