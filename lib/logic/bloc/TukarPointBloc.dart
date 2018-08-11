import 'dart:async';

import 'package:bpulsa/logic/viewmodel/TukarPointViewModel.dart';
import 'package:bpulsa/model/TukarPointModel.dart';

class TukarPointBloc {
  final TukarPointViewModel tukarPointViewModel = TukarPointViewModel();
  final tukarPointController = StreamController<List<TukarPointModel>>();
  Stream<List<TukarPointModel>> get tukarPointItems => tukarPointController.stream;

  TukarPointBloc() {
    tukarPointController.add(tukarPointViewModel.getTukarPoints());
  }
}
