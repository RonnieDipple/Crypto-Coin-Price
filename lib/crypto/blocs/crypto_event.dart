import 'package:cryptocoinprice/models/crypto_coin_model.dart';
import 'package:equatable/equatable.dart';

abstract class CryptoEvent extends Equatable {
  const CryptoEvent();

  @override
  List<Object> get props => [];
}

// App has three different events
class AppStarted extends CryptoEvent{}


// Triggers when pulled down to refresh
class RefreshCryptoCoins extends CryptoEvent{}

// Load more coins triggers when we get to the bottom of the scrollview
class LoadMoreCryptoCoins extends CryptoEvent{
  //need the List variable because
  // once we add more coins to the crypto loaded state we need to keep track of the crypto coins we already have
  final List<CryptoCoin> cryptoCoins;

  const LoadMoreCryptoCoins({this.cryptoCoins});

  @override
  List<Object> get props => [cryptoCoins];

  @override
  String toString() => 'LoadMoreCryptoCoins { crypotoCoins: $cryptoCoins}';


}



