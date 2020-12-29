
import 'package:flutter/material.dart';

class BaseProvider extends ChangeNotifier {
  UISTATE _state = UISTATE.LOADING;

  String _errorMessage = 'Something went wrong!';
  String _successMessage = "Event successful";

  //expose to other
  UISTATE get state => _state;
  String get uiErrorMessage => _errorMessage;
  String get uiSuccessMessage => _successMessage;

  void setUiStateAndNotify(UISTATE state) {
    _state = state;
    notifyListeners();
  }

  void setErrorMessage(String message) {
    _errorMessage = message;
    // notifyListeners(); // Since setUiStateAndNotify is called everytime, no need to notifyListeneres here
  }

  void setSuccessMessage(String message) {
    _successMessage = message;
    // notifyListeners(); // Since setUiStateAndNotify is called everytime, no need to notifyListeneres here
  }
}

enum UISTATE{
  LOADING, SUCCESS, ERROR
}