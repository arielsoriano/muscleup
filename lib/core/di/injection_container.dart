import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> initialize() async {
  await _initializeCore();
  await _initializeFeatures();
}

Future<void> _initializeCore() async {

}

Future<void> _initializeFeatures() async {

}
