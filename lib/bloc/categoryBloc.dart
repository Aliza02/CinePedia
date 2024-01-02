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

  // @override
  // Stream<ButtonState> mapEventToState(ButtonEvent event) async* {
  //   switch (event) {
  //     case ButtonEvent.ButtonEvent1:
  //       yield ButtonSelectedState(1);

  //     case ButtonEvent.ButtonEvent2:
  //       yield ButtonSelectedState(2);

  //     case ButtonEvent.ButtonEvent3:
  //       yield ButtonSelectedState(3);

  //     case ButtonEvent.ButtonEvent4:
  //       yield ButtonSelectedState(4);
  //   }
  // }
}
