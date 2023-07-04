import 'dart:async';
import 'dart:io' show Platform;

import 'package:draw_circle/time/circular_countdown_timer.dart';
import 'package:draw_circle/timer_status.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Set the preferred orientations
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle, // Set the App title
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const MyHomePage(title: appTitle), // Set the App home page title
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int _duration = 10;
  final CountDownController _controller = CountDownController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Center(
        child: CircularCountDownTimer(
          // Countdown duration in Seconds.
          duration: _duration,

          // Countdown initial elapsed Duration in Seconds.
          initialDuration: 0,

          // Controls (i.e Start, Pause, Resume, Restart) the Countdown Timer.
          controller: _controller,

          // Width of the Countdown Widget.
          width: MediaQuery.of(context).size.width / 2,

          // Height of the Countdown Widget.
          height: MediaQuery.of(context).size.height / 2,

          // Ring Color for Countdown Widget.
          ringColor: Colors.grey[300]!,

          // Ring Gradient for Countdown Widget.
          ringGradient: null,

          // Filling Color for Countdown Widget.
          fillColor: Colors.purpleAccent[100]!,

          // Filling Gradient for Countdown Widget.
          fillGradient: null,

          // Background Color for Countdown Widget.
          backgroundColor: Colors.purple[500],

          // Background Gradient for Countdown Widget.
          backgroundGradient: null,

          // Border Thickness of the Countdown Ring.
          strokeWidth: 20.0,

          // Begin and end contours with a flat edge and no extension.
          strokeCap: StrokeCap.round,

          // Text Style for Countdown Text.
          textStyle: const TextStyle(
            fontSize: 33.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),

          // Text Align for Countdown Text.
          textAlign: TextAlign.justify,

          // Format for the Countdown Text.
          textFormat: CountdownTextFormat.S,

          // Handles Countdown Timer (true for Reverse Countdown (max to 0), false for Forward Countdown (0 to max)).
          isReverse: true,

          // Handles Animation Direction (true for Reverse Animation, false for Forward Animation).
          isReverseAnimation: true,

          // Handles visibility of the Countdown Text.
          isTimerTextShown: true,

          // Handles the timer start.
          autoStart: false,

          // This Callback will execute when the Countdown Starts.
          onStart: () {
            // Here, do whatever you want
            debugPrint('Countdown Started');
          },

          // This Callback will execute when the Countdown Ends.
          onComplete: () {
            // Here, do whatever you want
            debugPrint('Countdown Ended');
          },

          // This Callback will execute when the Countdown Changes.
          onChange: (String timeStamp) {
            // Here, do whatever you want
            debugPrint('Countdown Changed $timeStamp');
          },

          /* 
            * Function to format the text.
            * Allows you to format the current duration to any String.
            * It also provides the default function in case you want to format specific moments
              as in reverse when reaching '0' show 'GO', and for the rest of the instances follow 
              the default behavior.
          */
          timeFormatterFunction: (defaultFormatterFunction, duration) {
            if (duration.inSeconds == 0) {
              // only format for '0'
              return "Start";
            } else {
              // other durations by it's default format
              return Function.apply(defaultFormatterFunction, [duration]);
            }
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 30,
          ),
          _button(
            title: "Start",
            onPressed: () => _controller.start(),
          ),
          const SizedBox(
            width: 10,
          ),
          _button(
            title: "Pause",
            onPressed: () => _controller.pause(),
          ),
          const SizedBox(
            width: 10,
          ),
          _button(
            title: "Resume",
            onPressed: () => _controller.resume(),
          ),
          const SizedBox(
            width: 10,
          ),
          _button(
            title: "Restart",
            onPressed: () => _controller.restart(duration: _duration),
          ),
        ],
      ),
    );
  }

  Widget _button({required String title, VoidCallback? onPressed}) {
    return Expanded(
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.purple),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

// class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
//   Timer? _countdownTimer; // Countdown Timer
//   TimerStatus _timerStatue = TimerStatus.set; // The timer's current  Status
//   Duration _timerDuration = const Duration(
//       hours: 0,
//       minutes: 3,
//       seconds:
//           0); // The Countdown timer duration (the initial/default value is 3 minutes)
//   int _restTimerDurationInSeconds =
//       3 * 60; // The rest time (till countdown to 0) duration in seconds
//   String _countdownTimerDurationAsString =
//       '0:3:0'; // The countdown timer duration as string
//   String _leftControlButtonText =
//       'Start'; // The left control button's text: 'Start' -> 'Pause' -> 'Resume'
//   IconData _leftControlButtonIcon =
//       Icons.play_arrow; // The left control button's icon (Play Arrow)
//   final String _rightControlButtonText =
//       'Set Timer'; // The right control button's text: 'Set Timer'
//   final IconData _rightControlButtonIcon =
//       Icons.restore; // The left control button's icon (Restore)

//   // Start the countdown timer
//   void _startCountdownTimer({int? seconds}) {
//     const oneSecondPeriod = Duration(seconds: 1);

//     // Check the null safety of the "_countdownTimer", then Check if it is active!
//     if ((_countdownTimer != null) && (_countdownTimer!.isActive)) {
//       _countdownTimer!.cancel(); // Cancel/stop the countdown timer
//     }

//     // Creates a new repeating timer
//     _countdownTimer = Timer.periodic(
//       oneSecondPeriod,
//       (Timer timer) {
//         // Check if the timer is already started
//         if (_timerStatue == TimerStatus.started) {
//           setState(() {
//             // Update the UI
//             _restTimerDurationInSeconds--; // Update the rest duration value
//             _countdownTimerDurationAsString = _durationAsString(
//                 duration: Duration(
//                     seconds:
//                         _restTimerDurationInSeconds)); // Get the rest duration as formatted string (hh:mm:ss/00:03:00)
//           });
//         }

//         // Check if counting down is finished (done)
//         if (_restTimerDurationInSeconds == 0) {
//           setState(() {
//             // Update the UI
//             _timerStatue = TimerStatus.finished;
//             _leftControlButtonText = 'Start';
//             _leftControlButtonIcon = Icons.play_arrow;

//             timer
//                 .cancel(); // Cancel the countdown timer (it is not needed anymore)
//           });
//         }
//       },
//     );
//   }

//   // Return the provided duration as a string hh:mm:ss/00:03:00
//   String _durationAsString({required Duration duration}) {
//     String twoDigitHours = _twoDigits(number: duration.inHours); // Hours
//     String twoDigitMinutes =
//         _twoDigits(number: duration.inMinutes.remainder(60)); // Minutes
//     String twoDigitSeconds =
//         _twoDigits(number: duration.inSeconds.remainder(60)); // Seconds
//     return '$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds';
//   }

//   // Return two digits of provided number (as string)
//   String _twoDigits({int? number}) {
//     return number.toString().padLeft(2, '0');
//   }

//   // On press the left control button
//   void _leftControlButtonOnPressed() {
//     // Set -> Start -> Pause -> Resume
//     switch (_timerStatue) {
//       case TimerStatus.set: // Start Now
//         _restTimerDurationInSeconds = _timerDuration.inSeconds;
//         _startCountdownTimer(seconds: _restTimerDurationInSeconds);
//         _timerStatue = TimerStatus.started;
//         setState(() {
//           _countdownTimerDurationAsString = _durationAsString(
//               duration: Duration(seconds: _restTimerDurationInSeconds));
//           _leftControlButtonText = 'Pause';
//           _leftControlButtonIcon = Icons.pause;
//         });
//         break;
//       case TimerStatus.started: // Stop Now
//         _timerStatue = TimerStatus.paused;

//         setState(() {
//           _leftControlButtonText = 'Resume';
//           _leftControlButtonIcon = Icons.play_arrow;
//         });
//         break;
//       case TimerStatus.paused: // Resume Now
//         // Pause the Timer Now (started -> paused)
//         _timerStatue = TimerStatus.started;
//         setState(() {
//           _leftControlButtonText = 'Pause';
//           _leftControlButtonIcon = Icons.pause;
//         });
//         break;
//       case TimerStatus.finished: // Restart
//         _restTimerDurationInSeconds = _timerDuration.inSeconds;
//         _startCountdownTimer(seconds: _restTimerDurationInSeconds);
//         _timerStatue = TimerStatus.started;
//         setState(() {
//           _leftControlButtonText = 'Pause';
//           _leftControlButtonIcon = Icons.pause;
//         });
//         break;
//     }
//   }

//   // On press the right control button
//   void _rightControlButtonOnPressed() {
//     setState(() {
//       _timerStatue = TimerStatus.set;
//       _leftControlButtonText = 'Start';
//       _leftControlButtonIcon = Icons.play_arrow;
//     });
//   }

//   @override
//   void dispose() {
//     //cancel the countdown timer before disposing the screen
//     _countdownTimer!.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     bool isMobile =
//         false; // is the App running on a mobile platform (Android or iOS)

//     // Check the App running platform (is it Android, iOS, or Web)
//     try {
//       if ((Platform.isAndroid) || (Platform.isIOS)) {
//         isMobile = true; // Mobile (Android or iOS)
//       } else {
//         isMobile = false; // Desktop most likely
//       }
//     } catch (e) {
//       isMobile = false; // Probably the App is running on the web
//     }
//     // Set the circular progress indicator dimensions according on the running platform
//     double circularProgressIndicatorDimensions = isMobile
//         ? MediaQuery.of(context).size.width - 64 // Mobile platform
//         : circularProgressIndicatorDimensionsForWeb; // Web/Desktop platform

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title!),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: <Widget>[
//           Padding(
//             padding: edgeInsetsPadding,
//             child: _timerStatue == TimerStatus.set
//                 ? ConstrainedBox(
//                     constraints: BoxConstraints(
//                       minWidth: circularProgressIndicatorDimensions,
//                       maxWidth: double.infinity,
//                       minHeight: circularProgressIndicatorDimensions,
//                       maxHeight: double.infinity,
//                     ),
//                     child: CupertinoTimerPicker(
//                         mode: CupertinoTimerPickerMode.hms,
//                         initialTimerDuration:
//                             _timerDuration, // Set the initial timer duration
//                         onTimerDurationChanged: (Duration duration) {
//                           _timerDuration =
//                               duration; // Update the timer duration
//                         }),
//                   )
//                 : Stack(children: <Widget>[
//                     ConstrainedBox(
//                       constraints: BoxConstraints(
//                         minWidth: circularProgressIndicatorDimensions,
//                         maxWidth: double.infinity,
//                         minHeight: circularProgressIndicatorDimensions,
//                         maxHeight: double.infinity,
//                       ),
//                       child: Center(
//                         child: Text(
//                           _countdownTimerDurationAsString,
//                           style: countdownDurationTextStyle,
//                         ),
//                       ),
//                     ),
//                     Center(
//                       child: ConstrainedBox(
//                         constraints: BoxConstraints(
//                           minWidth: circularProgressIndicatorDimensions,
//                           maxWidth: double.infinity,
//                           minHeight: circularProgressIndicatorDimensions,
//                           maxHeight: double.infinity,
//                         ),
//                         child: CircularProgressIndicator(
//                           strokeWidth: 24,
//                           backgroundColor:
//                               circularProgressIndicatorStartupColor,
//                           valueColor: const AlwaysStoppedAnimation<Color>(
//                               circularProgressIndicatorHeadColor),
//                           value: 1 -
//                               (_restTimerDurationInSeconds /
//                                   _timerDuration.inSeconds) +
//                               0.002,
//                         ),
//                       ),
//                     ),
//                     Center(
//                       child: ConstrainedBox(
//                         constraints: BoxConstraints(
//                           minWidth: circularProgressIndicatorDimensions,
//                           maxWidth: double.infinity,
//                           minHeight: circularProgressIndicatorDimensions,
//                           maxHeight: double.infinity,
//                         ),
//                         child: CircularProgressIndicator(
//                           strokeWidth: 24,
//                           value: 1 -
//                               (_restTimerDurationInSeconds /
//                                   _timerDuration.inSeconds),
//                           valueColor: AlwaysStoppedAnimation<Color>(
//                               (_timerStatue != TimerStatus.finished)
//                                   ? circularProgressIndicatorValueColor
//                                   : circularProgressIndicatorDoneColor),
//                           semanticsLabel: 'Counting down',
//                           semanticsValue:
//                               '$_restTimerDurationInSeconds seconds left',
//                         ),
//                       ),
//                     ),
//                   ]),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Visibility(
//                 visible: (_timerStatue == TimerStatus.finished) ? false : true,
//                 child: Padding(
//                   padding: elevatedButtonPadding,
//                   child: ElevatedButton.icon(
//                     icon: Icon(_leftControlButtonIcon),
//                     label: Text(
//                       _leftControlButtonText,
//                       style: elevatedButtonTextStyle,
//                     ),
//                     onPressed: _leftControlButtonOnPressed,
//                   ),
//                 ),
//               ),
//               Visibility(
//                 visible: (_timerStatue == TimerStatus.set) ? false : true,
//                 child: Padding(
//                   padding: elevatedButtonPadding,
//                   child: ElevatedButton.icon(
//                     icon: Icon(_rightControlButtonIcon),
//                     label: Text(
//                       _rightControlButtonText, // -> Pause -> Resume
//                       style: elevatedButtonTextStyle,
//                     ),
//                     onPressed: _rightControlButtonOnPressed,
//                   ),
//                 ),
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }