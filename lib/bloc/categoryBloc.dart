import 'package:bloc/bloc.dart';

// Define the events
enum ButtonEvent { ButtonEvent1, ButtonEvent2, ButtonEvent3, ButtonEvent4 }

// Define the states
abstract class ButtonState {}

class ButtonUnselectedState extends ButtonState {}

class ButtonSelectedState extends ButtonState {
  int selectedButtonIndex = 0;

  ButtonSelectedState(this.selectedButtonIndex);
}

class ButtonBloc extends Bloc<ButtonEvent, ButtonState> {
  ButtonBloc() : super(ButtonUnselectedState()) {
    on<ButtonEvent>((event, emit) {
      emit(ButtonSelectedState(event.index));
    });
  }
}
