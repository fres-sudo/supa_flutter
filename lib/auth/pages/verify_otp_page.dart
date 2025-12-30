import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hux/hux.dart';
import 'package:supa_flutter/core/misc/extensions.dart';
import 'package:supa_flutter/core/routes/app_router.gr.dart';
import 'package:supa_flutter/core/ui/device.dart';

@RoutePage()
class VerifyOtpPage extends StatefulWidget {
  const VerifyOtpPage({super.key});

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  Timer? _timer;
  int _start = 60;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer?.cancel();
    setState(() {
      _start = 60;
      _canResend = false;
    });
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            _canResend = true;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  String get _timerText {
    final minutes = (_start ~/ 60).toString().padLeft(2, '0');
    final seconds = (_start % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Sizes.edgeInsetsPhone),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          spacing: Sizes.lg,
          children: [
            Text("Verify OTP".hardcoded(),
                style: Theme.of(context).textTheme.titleLarge?.bold),
            HuxOtpInput(
              length: 6,
              onCompleted: (value) => print("OTP: $value"),
            ),
            const SizedBox(height: Sizes.sm),
            HuxButton(
              onPressed: () => context.router.replaceAll([const RootRoute()]),
              child: Text('Continue'.hardcoded()),
            ),
            HuxButton(
              onPressed: _canResend ? startTimer : null,
              variant: HuxButtonVariant.ghost,
              child: Text(
                _canResend
                    ? 'Resend OTP'.hardcoded()
                    : 'Resend OTP in $_timerText'.hardcoded(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
