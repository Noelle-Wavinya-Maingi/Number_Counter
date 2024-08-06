import 'package:equatable/equatable.dart';

class CounterState extends Equatable {
  // This is the current counter value
  final int counterValue;

  //Constructor for creating the counter state instance,
  // which requires the current counter value.
  const CounterState({required this.counterValue});

  @override
  List<Object> get props => [counterValue];
}
