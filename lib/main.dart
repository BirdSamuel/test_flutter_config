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
  String noQuoteEntry = '';
  String firstTestEntry = '';
  String secondTestEntry = '';
  String thirdTestEntry = '';
  String exampleUrl = '';
  bool _enabled = true;

  void _loadEnvVariables() {
    setState(() {
      // Separating out gets in case any fail
      try {
        noQuoteEntry = FlutterConfig.get('NO_QUOTE_ENTRY');
      } catch (e) {
        print(e);
      }

      try {
        firstTestEntry = FlutterConfig.get('FIRST_TEST_ENTRY');
      } catch (e) {
        print(e);
      }

      try {
        secondTestEntry = FlutterConfig.get('SECOND_TEST_ENTRY');
      } catch (e) {
        print(e);
      }

      try {
        thirdTestEntry = FlutterConfig.get('THIRD_TEST_ENTRY');
      } catch (e) {
        print(e);
      }

      try {
        exampleUrl = FlutterConfig.get('EXAMPLE_URL');
      } catch (e) {
        print(e);
      }

      // Disable retry, just for user knowledge sake
      if (noQuoteEntry.isNotEmpty ||
          secondTestEntry.isNotEmpty ||
          secondTestEntry.isNotEmpty ||
          thirdTestEntry.isNotEmpty ||
          exampleUrl.isNotEmpty) {
        _enabled = false;
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
              'NO_QUOTE_ENTRY: \n$noQuoteEntry\n',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            Text(
              'FIRST_TEST_ENTRY: \n$firstTestEntry\n',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            Text(
              'SECOND_TEST_ENTRY: \n$secondTestEntry\n',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            Text(
              'THIRD_TEST_ENTRY: \n$thirdTestEntry\n',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            Text(
              'EXAMPLE_URL: \n$exampleUrl\n',
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
