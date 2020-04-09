import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

// Equatable will compare coin objects to each other
class CryptoCoin extends Equatable{
  final double price;
  final String name;
  final String fullName;

  const CryptoCoin({
    @required this.price,
    @required this.name,
    @required this.fullName});

  @override
  // TODO: implement props
  List<Object> get props => [name, fullName, price]; // Returns a list of objects
// and this way we don't have to check each variable we can just check the name variables for example name1 === name2

  @override
  String toString() => 'Crypto Coin { name: $name, fullName: $fullName, price: $price}';

  //Takes in Json and converts the Json in to a Crypto Coin Object
  factory CryptoCoin.fromJson(Map<String, dynamic> json){
    return CryptoCoin(price: (json['RAW']['USD']['PRICE'] as num).toDouble(),
        name: json['CoinInfo']['Name'] as String,
        fullName: json['CoinInfo']['FullName'] as String );
  }



}
