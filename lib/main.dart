import 'package:flutter/material.dart';
import 'MyApp.dart';
import 'Service/db.dart';


void main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB.init();
  runApp( MyApp() );
}




