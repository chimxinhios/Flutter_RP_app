import 'package:flutter/material.dart';
import 'overlay_builder.dart';

class ToastWidget {
	final OverlayBuilderState overlay = OverlayBuilderState();
	final BuildContext context;

	ToastWidget(this.context);

	void show({
		String text,
		ToastType toastType = ToastType.error,
		Duration duration = const Duration(seconds: 2),
	}) {

		Icon _icon;
		Color backgroundColor;

		switch (toastType) {
			case ToastType.success:
				_icon = Icon(
					Icons.check_circle,
					color: const Color(0xff26AA53),
				);
				backgroundColor = const Color(0xffDFF6DE);
				break;
			case ToastType.error:
				_icon = Icon(
					Icons.error,
					color: const Color(0xffAD0000),
				);
				backgroundColor = const Color(0xffFBE2E2);
				break;

			case ToastType.warning:
				_icon = Icon(
					Icons.warning,
					color: const Color(0xffFF7C00),
				);
				backgroundColor = const Color(0xffFFF8D7);
				break;
		}

		print('ToastWidget.show: $text');
		if (overlay.isShowingOverlay()) {
			overlay.removeOverlay();
		}

		overlay.overlayState = Overlay.of(context);
		overlay.child = Container(
			decoration: BoxDecoration(
					color: backgroundColor,
					borderRadius: BorderRadius.circular(5),
					boxShadow: [
						const BoxShadow(
							color: Color.fromRGBO(63, 75, 186, 0.12),
							blurRadius: 10,
							spreadRadius: 0,
							offset: Offset(0, 2),
						)
					]),
//        color: backgroundColor,
			width: MediaQuery.of(context).size.width - 32,
			child: Padding(
				padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
				child: Row(
					children: <Widget>[
						_icon,
						const SizedBox(
							width: 12,
						),
						Expanded(
							child: Text(text),
						),
						GestureDetector(
							onTap: overlay.removeOverlay,
							child: FittedBox(
								child: Icon(Icons.close),
							),
						)
					],
				),
			),
		);
		overlay.showOverlay();

		Future.delayed(duration, () {
			if (overlay.isShowingOverlay()) {
				overlay.removeOverlay();
			}
		});
	}
}

enum ToastType { success, warning, error }
