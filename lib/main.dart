import 'package:flutter/widgets.dart';
import 'package:kurztrip_ma/Services/push_notifications_service.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/presentation/app.dart';

void main() async {
  init();
  await getIt.allReady();

  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationsService.initializeApp();
  //Bloc.observer = SimpleBlocObserver();
  runApp(MobileApp());
}
