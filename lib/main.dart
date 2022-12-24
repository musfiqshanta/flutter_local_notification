import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:local_notification_package/second.dart';
import 'Notification.dart';
import 'package:timezone/data/latest_all.dart' as tz;

void main() {
  tz.initializeTimeZones();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/second": (context) => SecondScreen(
              payload: "payload",
            ),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final LocalNotification service = LocalNotification();
  @override
  void initState() {
    service.initialize();
    listenToNotification();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  setState(() {});
                  await service.showNotification();
                },
                child: Text("Show Notification")),
            ElevatedButton(
                onPressed: () async {
                  await service.showScadual();
                },
                child: Text("Show Interverl Notification")),
            ElevatedButton(
                onPressed: () async {
                  await service.showNotificationWithPayload(
                      id: 1,
                      title: "Hello",
                      body: "Nothing shows",
                      payload: "Payload");
                },
                child: Text("Show Playload"))
          ],
        ),
      ),
    );
  }

  void listenToNotification() =>
      service.onNotificationClick.stream.listen(onNoticationListener);

  void onNoticationListener(String? payload) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) => SecondScreen(
                  payload: payload,
                ))));
  }
}
