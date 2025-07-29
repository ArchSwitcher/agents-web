

// import 'dart:async';

// class FormBloc{

// StreamController<bool> _isFormStream = BehaviorSubject<bool>.seeded(false);
//   Stream<bool> get formStream => _isFormStream.stream;
//   Sink<bool> get _updateFormStream => _isFormStream.sink;

// void updateFormStatus({bool isFormValid = false}){
//     _updateFormStream.add(isFormValid);
//   }

// void dispose(){
//     _isFormStream.close();
//   }

// }

// FormBloc formBloc = FormBloc();