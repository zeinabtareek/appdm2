import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:uuid/uuid.dart';

import 'maps_screens/controller/map_controller.dart';

MapController mapController=MapController();

String kGoogleApiKey =mapController.ApiKey;


void main() => runApp(const RoutesWidget());

final customTheme = ThemeData(
  primarySwatch: Colors.blue,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.blue,
    brightness: Brightness.dark,
    accentColor: Colors.redAccent,
  ),

  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4.00)),
    ),

    contentPadding: EdgeInsets.symmetric(
      vertical: 12.50,
      horizontal: 10.00,
    ),
  ),
);

class RoutesWidget extends StatelessWidget {
  const RoutesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: customTheme,
      routes: {
        '/': (_) =>   test(),
        '/search': (_) => CustomSearchScaffold(),
      },
    );
  }
}

class test extends StatefulWidget {

  @override
  _testState createState() => _testState();
}

class _testState extends State<test> {
  Mode _mode = Mode.overlay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildDropdownMenu(),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _handlePressButton,
              child: const Text('Search places'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/search');
              },
              child: const Text('Custom'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownMenu() {
    return DropdownButton<Mode>(
      value: _mode,
      items: const <DropdownMenuItem<Mode>>[
        DropdownMenuItem<Mode>(
          value: Mode.overlay,
          child: Text('Overlay'),
        ),
        DropdownMenuItem<Mode>(
          value: Mode.fullscreen,
          child: Text('Fullscreen'),
        ),
      ],
      onChanged: (m) {
        if (m != null) {
          setState(() => _mode = m);
        }
      },
    );
  }







  Future<void> _handlePressButton() async {
    void onError(PlacesAutocompleteResponse response) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.errorMessage ?? 'Unknown error'),
        ),
      );
    }

    // show input autocomplete with selected mode
    // then get the Prediction selected


    final p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      onError: onError,
      mode: _mode,
      language: 'en',
      components: [Component(Component.country, 'eg')],
    );

    await displayPrediction(p, ScaffoldMessenger.of(context));
  }
}

Future<void> displayPrediction(Prediction? p, ScaffoldMessengerState messengerState) async {
  if (p == null) {
    return;
  }

  // get detail (lat/lng)
  final _places = GoogleMapsPlaces(
    apiKey: kGoogleApiKey,
    apiHeaders: await const GoogleApiHeaders().getHeaders(),
  );

  final detail = await _places.getDetailsByPlaceId(p.placeId!);
  final geometry = detail.result.geometry!;
  final lat = geometry.location.lat;
  final lng = geometry.location.lng;

  messengerState.showSnackBar(
    SnackBar(
      content: Text('${p.description} - $lat/$lng'),
    ),
  );
}



// custom scaffold that handle search
// basically your widget need to extends [GooglePlacesAutocompleteWidget]
// and your state [GooglePlacesAutocompleteState]



class CustomSearchScaffold extends PlacesAutocompleteWidget {
  CustomSearchScaffold({Key? key})
      : super(
    key: key,
    apiKey: kGoogleApiKey,
    sessionToken: const Uuid().v4(),
    language: 'ar',
    components: [Component(Component.country, 'eg')],
  );

  @override
  _CustomSearchScaffoldState createState() => _CustomSearchScaffoldState();
}






class _CustomSearchScaffoldState extends PlacesAutocompleteState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:   AppBarPlacesAutoCompleteTextField(
          textStyle: null,
          textDecoration: null,
         ),
      ),
      body: PlacesAutocompleteResult(
        onTap: (p) => displayPrediction(p, ScaffoldMessenger.of(context)),
        logo: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [FlutterLogo()],
        ),
      ),
    );
  }



  @override
  void onResponseError(PlacesAutocompleteResponse response) {
    super.onResponseError(response);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(response.errorMessage ?? 'Unknown error')),
    );
  }
  @override
  void onResponse(PlacesAutocompleteResponse response) {
    super.onResponse(response);
    if (response.predictions.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Got answer')),
      );
    }
  }




}