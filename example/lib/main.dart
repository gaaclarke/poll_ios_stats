import 'package:flutter/material.dart';
import 'dart:async';
import 'package:poll_ios_stats/poll_ios_stats.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PollIosStats _poller = PollIosStats();
  double _dirtyMemoryUsage = -1;
  double _ownedSharedMemoryUsage = -1;
  double _timeSinceStartup = -1;

  @override
  void initState() {
    super.initState();
    loadStats();
  }

  Future<void> loadStats() async {
    MemoryUsage memoryUsage = await _poller.pollMemoryUsage();
    if (!mounted) return;
    setState(() {
      _dirtyMemoryUsage = memoryUsage.dirtyMemoryUsage;
      _ownedSharedMemoryUsage = memoryUsage.ownedSharedMemoryUsage;
    });
    StartupTime startupTime = await _poller.pollStartupTime();
    if (!mounted) return;
    setState(() {
      Duration diff = DateTime.now().difference(DateTime.fromMicrosecondsSinceEpoch(startupTime.startupTime));
      _timeSinceStartup = (diff.inMicroseconds / 1000000.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            Text('dirty memory: $_dirtyMemoryUsage MB\n'),
            Text('owned shared memory: $_ownedSharedMemoryUsage MB\n'),
            Text('time since startup: $_timeSinceStartup s\n'),
          ],
        )),
      ),
    );
  }
}
