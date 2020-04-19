
import 'package:cryptocoinprice/crypto/crypto_bloc.dart';
import 'package:cryptocoinprice/repositories/crypto_repository.dart';
import 'package:cryptocoinprice/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cryptocoinprice/crypto/crypto_event.dart';




void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CryptoBloc>(
      create: (_) => CryptoBloc(cryptoRepository: CryptoRepository()
      )..add(AppStarted()),
      child: MaterialApp(
        title: 'Crypto Coin Price',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.black,
          accentColor: Colors.tealAccent,
        ),
        home: HomeScreen(),
      ),
    );
  }
}


