import 'package:flutter/widgets.dart';

class Package{
  const Package({
    this.id,
    required this.weight,
    required this.volume,
    required this.longitude,
    required this.latitude,
    required this.address,
    required this.storeId,
    required this.receiver,
    required this.idReceiver
  });
  final int? id;
  final double? weight;
  final double? volume;
  final double longitude;
  final double latitude;
  final String? address;
  final int? storeId;
  final String? receiver;
  final String? idReceiver;

  static Package createEmpty(){
    return Package(id: 0, weight: 0, volume: 0, address: '', longitude: 0, latitude: 0, storeId: 0, receiver: '', idReceiver: '');
  }
}