import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:number_counter/bloc/counter_event.dart';
import 'package:number_counter/bloc/counter_state.dart';


//State manager of the counter and its event handlers.
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final String documentId = 'counterDoc';

  // A constructor that initializes the bloc with the initial counter state
  CounterBloc() : super(const CounterState(counterValue: 0)) {
    on<IncrementCounter>((event, emit) async {
      final currentCounter = state.counterValue + 1;
      await _firestore
          .collection('number_counters')
          .doc(documentId)
          .set({'noelle_value': currentCounter});
      emit(CounterState(counterValue: currentCounter));
    });
    _initializeCounter();
  }

  // Fetches the counter value from firestore and emits the corresponding state
  Future<void> _initializeCounter() async {
    final doc = await _firestore.collection('number_counters').doc(documentId).get();
    if (doc.exists) {
      emit(CounterState(counterValue: doc['noelle_value']));
    } else {
      await _firestore.collection('number_counters').doc(documentId).set({'noelle_value': 0});
    };
  }
}
