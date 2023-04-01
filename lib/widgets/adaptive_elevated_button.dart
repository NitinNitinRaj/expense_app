import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback handler;
  const AdaptiveElevatedButton(
      {super.key, required this.text, required this.handler});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            color: Theme.of(context).primaryColor,
            onPressed: handler,
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          )
        : ElevatedButton(
            onPressed: handler,
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          );
  }
}
