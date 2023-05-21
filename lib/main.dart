// main.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
import 'clod_segmented_control.dart';
// import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// https://phrase.com/blog/posts/flutter-localization/
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const TextStyle _textStylePobre = TextStyle(
  fontWeight: FontWeight.bold,
  color: CupertinoColors.destructiveRed,
);
const TextStyle _textStyleInterm = TextStyle(
  fontWeight: FontWeight.bold,
  color: CupertinoColors.activeOrange,
);
const TextStyle _textStyleIdeal = TextStyle(
  fontWeight: FontWeight.bold,
  color: CupertinoColors.activeGreen,
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      theme: CupertinoThemeData(
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(fontSize: 18.0),
        ),
      ),
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Score',
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''), // English
        Locale('es', ''), // Spanish
      ],
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  String? _selectedValueFuma;
  String? _selectedValueBMI;
  String? _selectedValueActiFis;
  String? _selectedValueDieta;
  String? _selectedValueColesterol;
  String? _selectedValuePresion;
  String? _selectedValueGlucemia;

  double _puntaje = 0.0;
  String _score = '';
  Color _colorScore = CupertinoColors.black;
  bool _scoreVisible = false;

  _computeScore() {
    debugPrint('***************** Calculando el score *****************');

    if (_selectedValueFuma != null &&
        _selectedValueBMI != null &&
        _selectedValueActiFis != null &&
        _selectedValueDieta != null &&
        _selectedValueColesterol != null &&
        _selectedValuePresion != null &&
        _selectedValueGlucemia != null) {
      _puntaje = (double.parse(_selectedValueFuma!) +
          double.parse(_selectedValueBMI!) +
          double.parse(_selectedValueActiFis!) +
          double.parse(_selectedValueDieta!) +
          double.parse(_selectedValueColesterol!) +
          double.parse(_selectedValuePresion!) +
          double.parse(_selectedValueGlucemia!)) /
          7;
      if (_puntaje == 1) {
        _score = AppLocalizations.of(context)!.ideal;
        _colorScore = CupertinoColors.systemTeal;
      } else if (_puntaje > 1.0 && _puntaje < 1.5) {
        _score = AppLocalizations.of(context)!.ideal;
        _colorScore = CupertinoColors.activeGreen;
      } else if (_puntaje >= 1.5 && _puntaje <= 2.0) {
        _score = AppLocalizations.of(context)!.intermediate;
        _colorScore = CupertinoColors.activeOrange;
      } else {
        _score = AppLocalizations.of(context)!.poor;
        _colorScore = CupertinoColors.destructiveRed;
      }
      _scoreVisible = true;
    }
    debugPrint('Puntaje: $_puntaje');
  }

  showHint(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'My Dialog',
            style: TextStyle(fontSize: 14.0),
          ),
          content: SizedBox(
              width: 400,
              height: 400,
              child: SingleChildScrollView(
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                      'Sed euismod, nulla a feugiat pulvinar, velit turpis dapibus '
                      'nibh, at varius velit tellus vel nunc. Nulla facilisi. '
                      'Vestibulum ante ipsum primis in faucibus orci luctus et '
                      'ultrices posuere cubilia curae; Vivamus lacinia dui non '
                      'magna tincidunt, vel imperdiet nisl tincidunt. Donec '
                      'tempor, velit eu rutrum congue, ante erat tristique justo, '
                      'nec interdum sapien neque eu neque.'
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                      'Sed euismod, nulla a feugiat pulvinar, velit turpis dapibus '
                      'nibh, at varius velit tellus vel nunc. Nulla facilisi. '
                      'Vestibulum ante ipsum primis in faucibus orci luctus et '
                      'ultrices posuere cubilia curae; Vivamus lacinia dui non '
                      'magna tincidunt, vel imperdiet nisl tincidunt. Donec '
                      'tempor, velit eu rutrum congue, ante erat tristique justo, '
                      'nec interdum sapien neque eu neque.'
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                      'Sed euismod, nulla a feugiat pulvinar, velit turpis dapibus '
                      'nibh, at varius velit tellus vel nunc. Nulla facilisi. '
                      'Vestibulum ante ipsum primis in faucibus orci luctus et '
                      'ultrices posuere cubilia curae; Vivamus lacinia dui non '
                      'magna tincidunt, vel imperdiet nisl tincidunt. Donec '
                      'tempor, velit eu rutrum congue, ante erat tristique justo, '
                      'nec interdum sapien neque eu neque.'
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                      'Sed euismod, nulla a feugiat pulvinar, velit turpis dapibus '
                      'nibh, at varius velit tellus vel nunc. Nulla facilisi. '
                      'Vestibulum ante ipsum primis in faucibus orci luctus et '
                      'ultrices posuere cubilia curae; Vivamus lacinia dui non '
                      'magna tincidunt, vel imperdiet nisl tincidunt. Donec '
                      'tempor, velit eu rutrum congue, ante erat tristique justo, '
                      'nec interdum sapien neque eu neque.'
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                      'Sed euismod, nulla a feugiat pulvinar, velit turpis dapibus '
                      'nibh, at varius velit tellus vel nunc. Nulla facilisi. '
                      'Vestibulum ante ipsum primis in faucibus orci luctus et '
                      'ultrices posuere cubilia curae; Vivamus lacinia dui non '
                      'magna tincidunt, vel imperdiet nisl tincidunt. Donec '
                      'tempor, velit eu rutrum congue, ante erat tristique justo, '
                      'nec interdum sapien neque eu neque.'
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                      'Sed euismod, nulla a feugiat pulvinar, velit turpis dapibus '
                      'nibh, at varius velit tellus vel nunc. Nulla facilisi. '
                      'Vestibulum ante ipsum primis in faucibus orci luctus et '
                      'ultrices posuere cubilia curae; Vivamus lacinia dui non '
                      'magna tincidunt, vel imperdiet nisl tincidunt. Donec '
                      'tempor, velit eu rutrum congue, ante erat tristique justo, '
                      'nec interdum sapien neque eu neque.'
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                      'Sed euismod, nulla a feugiat pulvinar, velit turpis dapibus '
                      'nibh, at varius velit tellus vel nunc. Nulla facilisi. '
                      'Vestibulum ante ipsum primis in faucibus orci luctus et '
                      'ultrices posuere cubilia curae; Vivamus lacinia dui non '
                      'magna tincidunt, vel imperdiet nisl tincidunt. Donec '
                      'tempor, velit eu rutrum congue, ante erat tristique justo, '
                      'nec interdum sapien neque eu neque.'
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                      'Sed euismod, nulla a feugiat pulvinar, velit turpis dapibus '
                      'nibh, at varius velit tellus vel nunc. Nulla facilisi. '
                      'Vestibulum ante ipsum primis in faucibus orci luctus et '
                      'ultrices posuere cubilia curae; Vivamus lacinia dui non '
                      'magna tincidunt, vel imperdiet nisl tincidunt. Donec '
                      'tempor, velit eu rutrum congue, ante erat tristique justo, '
                      'nec interdum sapien neque eu neque.',
                  style: TextStyle(fontSize: 12.0),
                ),
              )),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    // final double screenHeight = MediaQuery.of(context).size.height;

    final gridColumnWidth = (screenWidth - 16.0) / 4.0;

    debugPrint(screenWidth.toString());

    // Acomodo el tamaño del font de acuerdo con el ancho de la pantalla
    final fontSize = screenWidth / 50.0;

    return DefaultTextStyle(
      style: TextStyle(fontSize: fontSize),
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(AppLocalizations.of(context)!.appTitle),
        ),
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment
                      .start, // los quiero tados juntitos sin espacios intermedios
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AbsorbPointer(
                      child: ClodSegmentedControl(
                        unselectedColor: CupertinoColors.inactiveGray,
                        // selectedColor: CupertinoColors.activeOrange,
                        children: {
                          '0': Container(
                            width: gridColumnWidth,
                            child: Text(AppLocalizations.of(context)!.metric,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: CupertinoColors.black)),
                          ),
                          '3': Container(
                            width: gridColumnWidth,
                            child: Text(AppLocalizations.of(context)!.poor,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: CupertinoColors.black)),
                          ),
                          '2': Container(
                            width: gridColumnWidth,
                            child: Text(
                                AppLocalizations.of(context)!.intermediate,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: CupertinoColors.black)),
                          ),
                          '1': Container(
                            width: gridColumnWidth,
                            child: Text(AppLocalizations.of(context)!.ideal,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: CupertinoColors.black)),
                          ),
                        },
                        onValueChanged: (String value) {
                          setState(() {
                            _selectedValueFuma = value;
                          });
                        },
                      ),
                    ),
                    // Fuma
                    ClodSegmentedControl(
                      selectedColor: CupertinoColors.link,
                      groupValue: _selectedValueFuma,
                      children: {
                        '0': Container(
                          width: gridColumnWidth,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(6.0, 0, 0, 0),
                            child: Text(
                              AppLocalizations.of(context)!.metricSmokingStatus,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: CupertinoColors.black),
                            ),
                          ),
                        ),
                        '3': Container(
                          width: gridColumnWidth,
                          child: GestureDetector(
                            child: Text(
                              AppLocalizations.of(context)!.poorSmokingStatus,
                              textAlign: TextAlign.center,
                              style: _textStylePobre,
                            ),
                            onLongPress: () {
                              debugPrint("Long pressed");

                              showHint(context);
                            },
                          ),
                        ),
                        '2': Container(
                          width: gridColumnWidth,
                          child: GestureDetector(
                            child: Text(
                              AppLocalizations.of(context)!.intermSmokingStatus,
                              textAlign: TextAlign.center,
                              style: _textStyleInterm,
                            ),
                            onLongPress: () {
                              debugPrint("Long pressed");

                              showHint(context);
                            },
                          ),
                        ),
                        '1': Container(
                          width: gridColumnWidth,
                          child: Text(
                            AppLocalizations.of(context)!.idealSmokingStatus,
                            textAlign: TextAlign.center,
                            style: _textStyleIdeal,
                          ),
                        ),
                      },
                      onValueChanged: (String value) {
                        setState(() {
                          _selectedValueFuma = value;
                        });
                        _computeScore();
                      },
                    ),
                    // BMI
                    ClodSegmentedControl(
                      selectedColor: CupertinoColors.link,
                      groupValue: _selectedValueBMI,
                      children: {
                        '0': Container(
                          width: gridColumnWidth,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(6.0, 0, 0, 0),
                            child: Text(AppLocalizations.of(context)!.metricBMI,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: CupertinoColors.black)),
                          ),
                        ),
                        '3': Container(
                          width: gridColumnWidth,
                          child: Text(
                            AppLocalizations.of(context)!.poorBMI,
                            textAlign: TextAlign.center,
                            style: _textStylePobre,
                          ),
                        ),
                        '2': Container(
                          width: gridColumnWidth,
                          child: Text(
                            AppLocalizations.of(context)!.intermBMI,
                            textAlign: TextAlign.center,
                            style: _textStyleInterm,
                          ),
                        ),
                        '1': Container(
                          width: gridColumnWidth,
                          child: Text(
                            AppLocalizations.of(context)!.idealBMI,
                            textAlign: TextAlign.center,
                            style: _textStyleIdeal,
                          ),
                        ),
                      },
                      onValueChanged: (String value) {
                        setState(() {
                          _selectedValueBMI = value;
                        });
                        _computeScore();
                      },
                    ),
                    //Actividad física
                    ClodSegmentedControl(
                      selectedColor: CupertinoColors.link,
                      groupValue: _selectedValueActiFis,
                      children: {
                        '0': Container(
                          width: gridColumnWidth,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(6.0, 0, 0, 0),
                            child: Text(
                                AppLocalizations.of(context)!
                                    .metricPhysicalActivityLevel,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: CupertinoColors.black)),
                          ),
                        ),
                        '3': Container(
                          width: gridColumnWidth,
                          child: Text(
                            AppLocalizations.of(context)!
                                .poorPhysicalActivityLevel,
                            textAlign: TextAlign.center,
                            style: _textStylePobre,
                          ),
                        ),
                        '2': Container(
                          width: gridColumnWidth,
                          child: Text(
                            AppLocalizations.of(context)!
                                .intermPhysicalActivityLevel,
                            textAlign: TextAlign.center,
                            style: _textStyleInterm,
                          ),
                        ),
                        '1': Container(
                          width: gridColumnWidth,
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              AppLocalizations.of(context)!
                                  .idealPhysicalActivityLevel,
                              textAlign: TextAlign.center,
                              style: _textStyleIdeal,
                            ),
                          ),
                        ),
                      },
                      onValueChanged: (String value) {
                        setState(() {
                          _selectedValueActiFis = value;
                        });
                        _computeScore();
                      },
                    ),
                    // Dieta sanda
                    ClodSegmentedControl(
                      selectedColor: CupertinoColors.link,
                      groupValue: _selectedValueDieta,
                      children: {
                        '0': Container(
                          width: gridColumnWidth,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(6.0, 0, 0, 0),
                            child: Text(
                                AppLocalizations.of(context)!
                                    .metricHealthyDietScore,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: CupertinoColors.black)),
                          ),
                        ),
                        '3': Container(
                          width: gridColumnWidth,
                          child: Text(
                            AppLocalizations.of(context)!.poorHealthyDietScore,
                            textAlign: TextAlign.center,
                            style: _textStylePobre,
                          ),
                        ),
                        '2': Container(
                          width: gridColumnWidth,
                          child: Text(
                            AppLocalizations.of(context)!
                                .intermHealthyDietScore,
                            textAlign: TextAlign.center,
                            style: _textStyleInterm,
                          ),
                        ),
                        '1': Container(
                          width: gridColumnWidth,
                          child: Text(
                            AppLocalizations.of(context)!.idealHealthyDietScore,
                            textAlign: TextAlign.center,
                            style: _textStyleIdeal,
                          ),
                        ),
                      },
                      onValueChanged: (String value) {
                        setState(() {
                          _selectedValueDieta = value;
                        });
                        _computeScore();
                      },
                    ),
                    // Colesterol
                    ClodSegmentedControl(
                      selectedColor: CupertinoColors.link,
                      groupValue: _selectedValueColesterol,
                      children: {
                        '0': Container(
                          width: gridColumnWidth,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(6.0, 0, 0, 0),
                            child: Text(
                                AppLocalizations.of(context)!
                                    .metricTotalChoresterol,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: CupertinoColors.black)),
                          ),
                        ),
                        '3': Container(
                          width: gridColumnWidth,
                          child: Text(
                            AppLocalizations.of(context)!.poorTotalChoresterol,
                            textAlign: TextAlign.center,
                            style: _textStylePobre,
                          ),
                        ),
                        '2': Container(
                          width: gridColumnWidth,
                          child: Text(
                            AppLocalizations.of(context)!
                                .intermTotalChoresterol,
                            textAlign: TextAlign.center,
                            style: _textStyleInterm,
                          ),
                        ),
                        '1': Container(
                          width: gridColumnWidth,
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              AppLocalizations.of(context)!
                                  .idealTotalChoresterol,
                              textAlign: TextAlign.center,
                              style: _textStyleIdeal,
                            ),
                          ),
                        ),
                      },
                      onValueChanged: (String value) {
                        setState(() {
                          _selectedValueColesterol = value;
                        });
                        _computeScore();
                      },
                    ),
                    // Presión
                    ClodSegmentedControl(
                      selectedColor: CupertinoColors.link,
                      groupValue: _selectedValuePresion,
                      children: {
                        '0': Container(
                          width: gridColumnWidth,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(6.0, 0, 0, 0),
                            child: Text(
                                AppLocalizations.of(context)!.metricBloodPressure,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: CupertinoColors.black)),
                          ),
                        ),
                        '3': Container(
                          width: gridColumnWidth,
                          child: Text(
                            AppLocalizations.of(context)!.poorBloodPressure,
                            textAlign: TextAlign.center,
                            style: _textStylePobre,
                          ),
                        ),
                        '2': Container(
                          width: gridColumnWidth,
                          child: Text(
                            AppLocalizations.of(context)!.intermBloodPressure,
                            textAlign: TextAlign.center,
                            style: _textStyleInterm,
                          ),
                        ),
                        '1': Container(
                          width: gridColumnWidth,
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              AppLocalizations.of(context)!.idealBloodPressure,
                              textAlign: TextAlign.center,
                              style: _textStyleIdeal,
                            ),
                          ),
                        ),
                      },
                      onValueChanged: (String value) {
                        setState(() {
                          _selectedValuePresion = value;
                        });
                        _computeScore();
                      },
                    ),
                    // Glucemia
                    ClodSegmentedControl(
                      selectedColor: CupertinoColors.link,
                      groupValue: _selectedValueGlucemia,
                      children: {
                        '0': Container(
                          width: gridColumnWidth,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(6.0, 0, 0, 0),
                            child: Text(
                                AppLocalizations.of(context)!
                                    .metricFastingBloodGlucose,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: CupertinoColors.black)),
                          ),
                        ),
                        '3': Container(
                          width: gridColumnWidth,
                          child: Text(
                            AppLocalizations.of(context)!
                                .poorFastingBloodGlucose,
                            textAlign: TextAlign.center,
                            style: _textStylePobre,
                          ),
                        ),
                        '2': Container(
                          width: gridColumnWidth,
                          child: Text(
                            AppLocalizations.of(context)!
                                .intermFastingBloodGlucose,
                            textAlign: TextAlign.center,
                            style: _textStyleInterm,
                          ),
                        ),
                        '1': Container(
                          width: gridColumnWidth,
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              AppLocalizations.of(context)!
                                  .idealFastingBloodGlucose,
                              textAlign: TextAlign.center,
                              style: _textStyleIdeal,
                            ),
                          ),
                        ),
                      },
                      onValueChanged: (String value) {
                        setState(() {
                          _selectedValueGlucemia = value;
                        });
                        _computeScore();
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Puntaje
                        Padding(
                          padding:
                          const EdgeInsets.fromLTRB(30.0, 10.0, 10.0, 0.0),
                          child: Text(
                            AppLocalizations.of(context)!.result +
                                '${_puntaje.toStringAsFixed(1)}',
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: CupertinoColors.black,
                            ),
                          ),
                        ),
                        // Score
                        Padding(
                          padding:
                          const EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 0.0),
                          child: Text(
                            AppLocalizations.of(context)!.score,
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: _scoreVisible
                                  ? CupertinoColors.black
                                  : CupertinoColors.systemBackground,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 0.0),
                          child: Text(
                            _score,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: _colorScore,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
