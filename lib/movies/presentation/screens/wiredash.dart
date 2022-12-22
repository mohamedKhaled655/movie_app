

import 'package:flutter/material.dart';
import 'package:wiredash/wiredash.dart';

class WiredashApp extends StatelessWidget {

  final navigatorKey;
  final Widget child;

  const WiredashApp({Key? key,required this.navigatorKey,required this.child}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return Wiredash(
      navigatorKey: navigatorKey,
      secret: 'QaFtDDb62mDq8ZpYy-DvPyIO_Ka6j9KZ',
      projectId: 'movieapp-qmn057u',
      child: child,
    );
  }
}