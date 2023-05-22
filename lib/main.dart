// main.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
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

SharedPreferences? prefs;
bool? flagShowTandC = true;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // Obtain shared preferences.
  prefs = await SharedPreferences.getInstance();

  flagShowTandC = prefs!.getBool('showTandC');

  debugPrint("Show T&C: " + flagShowTandC.toString());
  // If I could not read it I assume T&C have not veen already accepted
  if (flagShowTandC == null) flagShowTandC = true;
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
        // Locale('es', ''), // Spanish
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

  late BuildContext bc;
  bool tcAccepted = false;

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

  showHint(BuildContext context, String title, String body) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(fontSize: 16.0),
          ),
          content: SizedBox(
              width: 400,
              height: 400,
              child: SingleChildScrollView(
                child: Text(
                  body,
                  style: TextStyle(fontSize: 14.0),
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

  showTandC(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            AppLocalizations.of(context)!.txtImportantNotice,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.deepOrange,
                fontSize: 14.0,
                fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
              width: 400,
              height: 400,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.txtReadCarefully,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      AppLocalizations.of(context)!.txtAppPurpose,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await launchUrl(Uri.parse('https://www.heart.org'));
                      },
                      child: Text(
                        'American Heart Association',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      AppLocalizations.of(context)!.txtFundamentalsLocation,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await launchUrl(Uri.parse('https://playbook.heart.org/lifes-simple-7/'));
                      },
                      child: Text(
                        AppLocalizations.of(context)!.txtLifeSimple7Objective,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          actions: [
            TextButton(
              onPressed: () {
                debugPrint("Cancelando...");
                // Gracefully quit the app
                // Según leí, Apple no lo permite pero esto, de alguna manera, lo logra.
                // FlutterExitApp.exitApp(iosForceExit: true);
                FlutterExitApp.exitApp();
              },
              child: Text('Reject'),
            ),
            TextButton(
              onPressed: () {
                debugPrint("Aceptando...");
                prefs!.setBool('showTandC', false);
                Navigator.of(context).pop();
              },
              child: Text('Accept'),
            ),
          ],
        );
      },
    );
  }

  ////////////////////////////////////////////////////////////////
  void myFunction() {
    debugPrint('Widget built 1!');
    showTandC(bc);
  }

  @override
  void initState() {
    super.initState();
    debugPrint("En intiState $showTandC");

    if (flagShowTandC != false) {
      // Register a callback to execute after the widget is built
      WidgetsBinding.instance.addPostFrameCallback((_) => myFunction());
    }
  }

////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    // final double screenHeight = MediaQuery.of(context).size.height;

    final gridColumnWidth = (screenWidth - 16.0) / 4.0;

    debugPrint('Ancho de pantalla: ${screenWidth.toString()}');

    // Acomodo el tamaño del font de acuerdo con el ancho de la pantalla
    final fontSize = screenWidth / 75.0;

    bc = context;

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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    await launchUrl(Uri.parse('https://playbook.heart.org/lifes-simple-7/'));
                  },
                  child: Text(
                    AppLocalizations.of(context)!.txtFundamentalsLocation,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.blue,
                    ),
                  ),
                ),
                SizedBox(
                  height: fontSize / 2,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start, // los quiero tados juntitos sin espacios intermedios
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
                                textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: CupertinoColors.black)),
                          ),
                          '3': Container(
                            width: gridColumnWidth,
                            child: Text(AppLocalizations.of(context)!.poor,
                                textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: CupertinoColors.black)),
                          ),
                          '2': Container(
                            width: gridColumnWidth,
                            child: Text(AppLocalizations.of(context)!.intermediate,
                                textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: CupertinoColors.black)),
                          ),
                          '1': Container(
                            width: gridColumnWidth,
                            child: Text(AppLocalizations.of(context)!.ideal,
                                textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: CupertinoColors.black)),
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
                              style: TextStyle(fontWeight: FontWeight.bold, color: CupertinoColors.black),
                            ),
                          ),
                        ),
                        '3': Container(
                          width: gridColumnWidth,
                          child: Text(
                            AppLocalizations.of(context)!.poorSmokingStatus,
                            textAlign: TextAlign.center,
                            style: _textStylePobre,
                          ),
                        ),
                        '2': Container(
                          width: gridColumnWidth,
                          child: Text(
                            AppLocalizations.of(context)!.intermSmokingStatus,
                            textAlign: TextAlign.center,
                            style: _textStyleInterm,
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
                            child: GestureDetector(
                              child: Text(AppLocalizations.of(context)!.metricBMI,
                                  style: TextStyle(fontWeight: FontWeight.bold, color: CupertinoColors.black)),
                              onLongPress: () {
                                debugPrint("Long pressed");
                                showHint(context, "Body Mass Index",
                                    "Represents appropriate energy balance (i.e., appropriate dietary quantity and PA to maintain normal body weight).");
                              },
                            ),
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
                            child: GestureDetector(
                              child: Text(AppLocalizations.of(context)!.metricPhysicalActivityLevel,
                                  style: TextStyle(fontWeight: FontWeight.bold, color: CupertinoColors.black)),
                              onLongPress: () {
                                debugPrint("Long pressed");
                                showHint(
                                  context,
                                  "Physical Activity",
                                  'Proposed questions to assess PA: \n'
                                      '(1) “On average, how many days per week do you engage in moderate to strenuous exercise (like a brisk walk)?”\n'
                                      '(2) “On average, how many minutes do you engage in exercise at this level?” \n'
                                      'Other options for assessing PA available.',
                                );
                              },
                            ),
                          ),
                        ),
                        '3': Container(
                          width: gridColumnWidth,
                          child: Text(
                            AppLocalizations.of(context)!.poorPhysicalActivityLevel,
                            textAlign: TextAlign.center,
                            style: _textStylePobre,
                          ),
                        ),
                        '2': Container(
                          width: gridColumnWidth,
                          child: Text(
                            AppLocalizations.of(context)!.intermPhysicalActivityLevel,
                            textAlign: TextAlign.center,
                            style: _textStyleInterm,
                          ),
                        ),
                        '1': Container(
                          width: gridColumnWidth,
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              AppLocalizations.of(context)!.idealPhysicalActivityLevel,
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
                            child: GestureDetector(
                              child: Text(AppLocalizations.of(context)!.metricHealthyDietScore,
                                  style: TextStyle(fontWeight: FontWeight.bold, color: CupertinoColors.black)),
                              onLongPress: () {
                                debugPrint("Long pressed");
                                showHint(context, "Healthy diet pattern",
                                    "In the context of a healthy dietary pattern that is consistent with a Dietary Approaches to Stop Hypertension (DASH)–type eating pattern, to consume ≥4.5 cups/d of fruits and vegetables, ≥2 servings/wk of fish, and ≥3 servings/d of whole grains and no more than 36 oz/wk of sugar-sweetened beverages and 1500 mg/d of sodium.");
                              },
                            ),
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
                            AppLocalizations.of(context)!.intermHealthyDietScore,
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
                            child: Text(AppLocalizations.of(context)!.metricTotalChoresterol,
                                style: TextStyle(fontWeight: FontWeight.bold, color: CupertinoColors.black)),
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
                            AppLocalizations.of(context)!.intermTotalChoresterol,
                            textAlign: TextAlign.center,
                            style: _textStyleInterm,
                          ),
                        ),
                        '1': Container(
                          width: gridColumnWidth,
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              AppLocalizations.of(context)!.idealTotalChoresterol,
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
                            child: Text(AppLocalizations.of(context)!.metricBloodPressure,
                                style: TextStyle(fontWeight: FontWeight.bold, color: CupertinoColors.black)),
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
                            child: Text(AppLocalizations.of(context)!.metricFastingBloodGlucose,
                                style: TextStyle(fontWeight: FontWeight.bold, color: CupertinoColors.black)),
                          ),
                        ),
                        '3': Container(
                          width: gridColumnWidth,
                          child: Text(
                            AppLocalizations.of(context)!.poorFastingBloodGlucose,
                            textAlign: TextAlign.center,
                            style: _textStylePobre,
                          ),
                        ),
                        '2': Container(
                          width: gridColumnWidth,
                          child: Text(
                            AppLocalizations.of(context)!.intermFastingBloodGlucose,
                            textAlign: TextAlign.center,
                            style: _textStyleInterm,
                          ),
                        ),
                        '1': Container(
                          width: gridColumnWidth,
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              AppLocalizations.of(context)!.idealFastingBloodGlucose,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.detailIndicator,
                          style: const TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                            color: CupertinoColors.black,
                          ),
                        ),
                        Text(
                          " BMI, body mass index; DBP, diastolic blood pressure; PA, physical activity; and SBP, systolic blood pressure",
                          style: const TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                            color: CupertinoColors.black,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Puntaje
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30.0, 10.0, 10.0, 0.0),
                          child: Text(
                            AppLocalizations.of(context)!.result + '${_puntaje.toStringAsFixed(1)}',
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: CupertinoColors.black,
                            ),
                          ),
                        ),
                        // Score
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 0.0),
                          child: Text(
                            AppLocalizations.of(context)!.score,
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: _scoreVisible ? CupertinoColors.black : CupertinoColors.systemBackground,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 0.0),
                          child: Text(
                            _score,
                            style: TextStyle(
                              fontSize: 15.0,
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
