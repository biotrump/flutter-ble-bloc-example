// Copyright 2017, Paul DeMarco.
// All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'widgets/widgets.dart';

void main() {
  runApp(FlutterBlueApp());
}

class FlutterBlueApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.lightBlue,
      home: StreamBuilder<BluetoothState>(
          stream: FlutterBlue.instance.state,
          initialData: BluetoothState.unknown,
          builder: (c, snapshot) {
            final state = snapshot.data;
            if (state == BluetoothState.on) {//bluetooth is turned on in a phone.
              return FindDevicesScreen();
            }
            return BluetoothOffScreen(state: state);  //bluetooth is turned off in a phone.
          }),
    );
  }
}

//bluetooth is turned off in a phone, so show the bluetooth off screen.
class BluetoothOffScreen extends StatelessWidget {
  const BluetoothOffScreen({Key key, this.state}) : super(key: key);
  //state == "BluetoothState.xxxx", the real state index is @15 from the beginning.
  //state.toString().substring(15) ==> the bluetooth state in string format.
  final BluetoothState state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon( //show an icon.s
              Icons.bluetooth_disabled,
              size: 200.0,
              color: Colors.white54,
            ),
            //state == "BluetoothState.xxxx", the real state index is @15 from the beginning.
            //state.toString().substring(15) ==> the bluetooth state in string format.
            Text(
              'Bluetooth Adapter is ${state != null ? state.toString().substring(15) : 'not available'}.',
              style: Theme.of(context)
                  .primaryTextTheme
                  .subtitle1
                  .copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
