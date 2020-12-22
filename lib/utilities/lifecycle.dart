// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
//  import 'package:report_app/main.dart';
//  import 'system.dart';

// import '../lib/utilities/system_lifecyle_listener.dart';

// abstract class LifecycleState<T extends StatefulWidget> extends State<T> with RouteAware {
//   @override
//   void initState() {
//     print('LifeCycleState.initState');
//     super.initState();

//     SystemLifecycleListener.instance.addCallback(handleLifecycleCallback);

//    SchedulerBinding.instance.addPostFrameCallback((_) {
//      onFirstFrame();
//    });
//   }

//   @override
//   void didChangeDependencies() {
//     routeObserver.subscribe(this, ModalRoute.of(context));
//     super.didChangeDependencies();
//   }

//   @override
//   void dispose() {
//     routeObserver.unsubscribe(this);
//     SystemLifecycleListener.instance.removeCallback(handleLifecycleCallback);
//     super.dispose();
//   }

//   void handleLifecycleCallback(AppLifecycle lifecycle) {
//     if (lifecycle == AppLifecycle.onResume) {
//       onResume();
//     } else if (lifecycle == AppLifecycle.onPause) {
//       onPause();
//     }
//   }

//   void onResume() {
//     print('LifeCycleState.onResume');
//   }

//   void onPause() {
//     print('LifeCycleState.onPause');
//   }

//   void onFirstFrame() {
//     print('LifeCycleState.onFirstFrame');
//   }

//   @override
//   void didPopNext() {
//     print('LifeCycleState.didPopNext');
// 	  super.didPopNext();

//     SystemLifecycleListener.instance.addCallback(handleLifecycleCallback);
//     hideKeyboard();
//     onResume();
//   }

//   @override
//   void didPushNext() {
//    print('LifeCycleState.didPushNext');
// 	  super.didPushNext();

//     SystemLifecycleListener.instance.removeCallback(handleLifecycleCallback);
//   hideKeyboard();
//     onPause();
//   }

//   @override
//   void didPop() {
//     print('LifeCycleState.didPop');
//     super.didPop();
//   }

//   @override
//   void didPush() {
//     print('LifeCycleState.didPush');
//     super.didPush();
//   }
// }
