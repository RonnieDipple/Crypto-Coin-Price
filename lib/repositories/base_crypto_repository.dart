import 'package:cryptocoinprice/models/crypto_coin_model.dart';


abstract class BaseCryptoRepository{
  Future<List<CryptoCoin>> getTopCoins({int page});
  void dispose();



}
