import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterConfig test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'FlutterConfig Test demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String testEntry = '';
  String secondTestEntry = '';
  String brokenTestEntry = '';
  bool _enabled = true;

  void _loadEnvVariables() {
    setState(() {
      try {
        testEntry = FlutterConfig.get('TEST_ENTRY');
        secondTestEntry = FlutterConfig.get('SECOND_TEST_ENTRY');
        brokenTestEntry = FlutterConfig.get('BROKEN_TEST_ENTRY');

        if (testEntry.isNotEmpty ||
            secondTestEntry.isNotEmpty ||
            brokenTestEntry.isNotEmpty) {
          _enabled = false;
        }
      } catch (e) {
        print(e);
      }
    });
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
          children: <Widget>[
            Text(
              'TEST_ENTRY: \n$testEntry\n',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            Text(
              'SECOND_TEST_ENTRY: \n$secondTestEntry\n',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            Text(
              'BROKEN_TEST_ENTRY: \n$brokenTestEntry\n',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              onPressed: _enabled ? _loadEnvVariables : null,
              style: _enabled
                  ? ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    )
                  : ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.grey),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                    ),
              child: const Text('Load ENV Variables'),
            ),
            Text(
              'Modifying variables in \'.env\' will not take effect until application is rebuilt.',
              style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
