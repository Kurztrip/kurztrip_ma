import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/presentation/app.dart';
// import 'package:kurztrip_ma/src/presentation/bloc/simple_bloc_observer.dart';

void main() async {
  init();
  await getIt.allReady();
  //Bloc.observer = SimpleBlocObserver();
  runApp(MobileApp());
}
