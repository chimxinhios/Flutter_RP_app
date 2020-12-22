import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NumericTextFormatter extends TextInputFormatter {
	@override
	TextEditingValue formatEditUpdate(
			TextEditingValue oldValue, TextEditingValue newValue) {
		if (newValue.text.isEmpty) {
			return newValue.copyWith(text: '');
		} else if (newValue.text.compareTo(oldValue.text) != 0) {
			final selectionIndexFromTheRight =
					newValue.text.length - newValue.selection.end;
			final f = NumberFormat("#,###", "vi_VN");
			final num = int.parse(newValue.text.replaceAll(f.symbols.GROUP_SEP, ''));
			final newString = f.format(num);
			return TextEditingValue(
				text: newString,
				// selection: TextSelection.collapsed(
				// 		offset: newString.length - selectionIndexFromTheRight),
			);
		} else {
			return newValue;
		}
	}
}

class DateFormatter extends TextInputFormatter {
	final String mask = 'xx-xx-xxxx';
	final String separator = '-';

	@override
	TextEditingValue formatEditUpdate(
			TextEditingValue oldValue, TextEditingValue newValue) {
		if (newValue.text.isNotEmpty) {
			if (newValue.text.length > oldValue.text.length) {
				final lastEnteredChar =
				newValue.text.substring(newValue.text.length - 1);
				if (!_isNumeric(lastEnteredChar)) {
					return oldValue;
				}

				if (newValue.text.length > mask.length) {
					return oldValue;
				}
				if (newValue.text.length < mask.length &&
						mask[newValue.text.length - 1] == separator) {
					final value = _validateValue(oldValue.text);
					print(value);

					return TextEditingValue(
						text: '$value$separator$lastEnteredChar',
						// selection: TextSelection.collapsed(
						// 	offset: newValue.selection.end + 1,
						// ),
					);
				}

				if (newValue.text.length == mask.length) {
					return TextEditingValue(
						text: '${_validateValue(newValue.text)}',
						// selection: TextSelection.collapsed(
						// 	offset: newValue.selection.end,
						// ),
					);
				}
			}
		}
		return newValue;
	}

	bool _isNumeric(String s) {
		if (s == null) {
			return false;
		}
		return double.tryParse(s) != null;
	}

	String _validateValue(String s) {
		var result = s;

		if (s.length < 4) {
			// days
			final num = int.parse(s.substring(s.length - 2));
			final raw = s.substring(0, s.length - 2);
			if (num == 0) {
				result = '${raw}01';
			} else if (num > 31) {
				result = '${raw}31';
			} else {
				result = s;
			}
		} else if (s.length < 7) {
			// month
			final num = int.parse(s.substring(s.length - 2));
			final raw = s.substring(0, s.length - 2);
			if (num == 0) {
				result = '${raw}01';
			} else if (num > 12) {
				result = '${raw}12';
			} else {
				result = s;
			}
		} else {
			// year
			final num = int.parse(s.substring(s.length - 4));
			final raw = s.substring(0, s.length - 4);
			final currentYear = DateTime.now().year;
			final minYear = currentYear - 100;
			if (num < minYear) {
				result = '$raw$minYear';
			} else if (num > currentYear) {
				result = '$raw$currentYear';
			} else {
				result = s;
			}
		}

		print(result);
		return result;
	}
}