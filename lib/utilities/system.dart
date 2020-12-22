import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void hideKeyboard() {
	SystemChannels.textInput.invokeMethod('TextInput.hide');
}
void hideKeyboardAndUnFocus(BuildContext context) {
	FocusScope.of(context).requestFocus(FocusNode());
	SystemChannels.textInput.invokeMethod('TextInput.hide');
}