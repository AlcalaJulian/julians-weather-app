// ignore: depend_on_referenced_packages
import 'package:geolocator_web/geolocator_web.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
// ignore: public_member_api_docs
void registerPlugins(Registrar registrar) {
  GeolocatorPlugin.registerWith(registrar);
  registrar.registerMessageHandler();
}
