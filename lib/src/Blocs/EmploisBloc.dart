import 'package:rxdart/rxdart.dart';
import '../Model/Emploi.dart';
import 'Repository.dart';


class EmploisBloc {
  final _repository = Repository();
  final _emploisFetcher = PublishSubject<List<Emploi>>();

  Stream<List<Emploi>> get latestEmplois => _emploisFetcher.stream;

  getLatestEmplois(x) async {
    List<Emploi> itemModel = await _repository.getLatestEmplois(x);
    _emploisFetcher.sink.add(itemModel);
  }

  dispose() {
    _emploisFetcher.close();
  }

}

final bloc = EmploisBloc();