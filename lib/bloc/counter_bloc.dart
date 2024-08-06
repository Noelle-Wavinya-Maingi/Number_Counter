import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:counter/bloc/counter_event.dart';
import 'package:counter/bloc/counter_state.dart';

//State manager of the counter and its event handlers.
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final String documentId = 'counterDoc';

  // A constructor that initializes the bloc with the initial counter state
  CounterBloc() : super(const CounterState(counterValue: 0)) {
    on<IncrementCounter>((event, emit) async {
      final currentCounter = state.counterValue + 1;
      await _firestore
          .collection('counters')
          .doc(documentId)
          .set({'value': currentCounter});
      emit(CounterState(counterValue: currentCounter));
    });
    _initializeCounter();
  }

  // Fetches the counter value from firestore and emits the corresponding state
  Future<void> _initializeCounter() async {
    final doc = await _firestore.collection('counters').doc(documentId).get();
    if (doc.exists) {
      emit(CounterState(counterValue: doc['value']));
    } else {
      await _firestore.collection('counters').doc(documentId).set({'value': 0});
    }so 
  }
}
