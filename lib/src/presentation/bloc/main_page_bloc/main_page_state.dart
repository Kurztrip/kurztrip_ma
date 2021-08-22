import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MainPageState extends Equatable {
  MainPageState(this.driver, [this.properties = const <Object>[]]) : super();
  final bool driver;
  final List properties;

  @override
  List<Object> get props => properties as List<Object>;
}

class TruckTab extends MainPageState {
  TruckTab(bool driver) : super(driver);
}

class PackageTab extends MainPageState {
  PackageTab(bool driver) : super(driver);
}

class RouteTab extends MainPageState {
  RouteTab(bool driver) : super(driver);
}

class AccountTab extends MainPageState {
  AccountTab(bool driver) : super(driver);
}

class ErrorState extends MainPageState {
  final String message;
  ErrorState(bool driver, {this.message = 'error'}) : super(driver, [message]);
}
