import 'package:cryptocoinprice/models/crypto_coin_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class CryptoState extends Equatable {
  const CryptoState();
  @override
  List<Object> get props => [];
}

// Initial state when the app is first loaded
class CryptoEmpty extends CryptoState{}

// The state when fetching coins from the api
class CryptoLoading extends CryptoState{}

// returns state once we have retrieved all the coins
class CryptoLoaded extends CryptoState{
  final List<CryptoCoin> cryptoCoins;

  const CryptoLoaded({this.cryptoCoins});

  // Props so we can comapare different crypto loaded states to each other by comparing the cryptoCoins properties
  @override
  List<Object> get props => [cryptoCoins];

  @override
  String toString() => 'CryptoLoaded {coins: $cryptoCoins}';


}

// When we have an error with the api
class CryptoError extends CryptoState{}



