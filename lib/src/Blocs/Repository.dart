import 'dart:async';

import '../Model/Emploi.dart';
import '../Service/EmploiService.dart';

class Repository {

  final emploisAPI = EmploiService();

  Future<List<Emploi>> getLatestEmplois(x) => emploisAPI.getLatestEmplois(x);
}