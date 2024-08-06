import 'package:equatable/equatable.dart';

abstract class CounterEvent extends Equatable {
  const CounterEvent();

  @override
  List<Object> get props => [];
}

//The increment counter event that extends the Counter Event
class IncrementCounter extends CounterEvent {}
