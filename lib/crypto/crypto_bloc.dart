import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cryptocoinprice/models/crypto_coin_model.dart';
import 'package:cryptocoinprice/repositories/crypto_repository.dart';
import 'package:flutter/cupertino.dart';
import './bloc.dart';
import 'package:meta/meta.dart';


// Handles all the business logic, stuff like api calls etc
class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  final CryptoRepository _cryptoRepository;

  CryptoBloc({@required CryptoRepository cryptoRepository}): assert(cryptoRepository!=null),
        _cryptoRepository = cryptoRepository;




  // Just a placeholder
  @override
  CryptoState get initialState => CryptoEmpty();

  @override
  Stream<CryptoState> mapEventToState(
    CryptoEvent event,
  ) async* {
    if (event is AppStarted){
      yield* _mapAppStartedToState();

    }else if (event is RefreshCryptoCoins){
      yield* _getCryptoCoins(cryptoCoins: []);
      
    } else if (event is LoadMoreCryptoCoins){
      yield* _mapLoadMoreCryptoCoinsToState(event);

    }
  }

  Stream<CryptoState> _getCryptoCoins({List<CryptoCoin> cryptoCoins, int page = 0}) async*{
    // Request Coins
    try{
      List<CryptoCoin> newCryptoCoinsList = cryptoCoins + await _cryptoRepository.getTopCoins(page: page);
      yield CryptoLoaded(cryptoCoins: newCryptoCoinsList);

    } catch (err){
      yield CryptoError();
    }

  }


  
}
