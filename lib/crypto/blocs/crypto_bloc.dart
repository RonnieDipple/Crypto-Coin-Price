import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cryptocoinprice/models/crypto_coin_model.dart';
import 'package:cryptocoinprice/repositories/crypto_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import 'crypto_event.dart';
import 'crypto_state.dart';

// Handles all the business logic, stuff like api calls etc
// Converts all events to states
class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  final CryptoRepository _cryptoRepository;

  CryptoBloc({@required CryptoRepository cryptoRepository})
      : assert(cryptoRepository != null),
        _cryptoRepository = cryptoRepository;

  // Just a placeholder
  @override
  CryptoState get initialState => CryptoEmpty();

  @override
  Stream<CryptoState> mapEventToState(
      CryptoEvent event,
      ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is RefreshCryptoCoins) {
      yield* _getCryptoCoins(cryptoCoins: []);
    } else if (event is LoadMoreCryptoCoins) {
      yield* _mapLoadMoreCryptoCoinsToState(event);
    }
  }

  Stream<CryptoState> _getCryptoCoins(
      {List<CryptoCoin> cryptoCoins, int page = 0}) async* {
    // Request Coins
    try {
      List<CryptoCoin> newCryptoCoinsList =
          cryptoCoins + await _cryptoRepository.getTopCoins(page: page);
      yield CryptoLoaded(cryptoCoins: newCryptoCoinsList);
    } catch (err) {
      yield CryptoError();
    }
  }

  Stream<CryptoState> _mapAppStartedToState() async* {
    yield CryptoLoading();
    yield* _getCryptoCoins(cryptoCoins: []);
  }

  Stream<CryptoState> _mapLoadMoreCryptoCoinsToState(
      LoadMoreCryptoCoins event) async* {
    // if we have 30 coins in the list then cryptoCoins.length is 30 and cryptoCoinsPerPage is 30
    // so that means we will be doing 30 divided by 30
    // and then rounding to the nearest integer for th answer because of the ~
    final int nextPage =
        event.cryptoCoins.length ~/ CryptoRepository.cryptoCoinsPerPage;

    yield* _getCryptoCoins(cryptoCoins: event.cryptoCoins, page: nextPage);
  }
}
