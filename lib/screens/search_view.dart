import '/screens/common_widgets.dart';
import 'package:flutter/material.dart';
import '/modals/movie.dart';

class MovieSearch extends SearchDelegate<Movie?> {
  MovieSearch()
      : super(
          searchFieldLabel: 'Search for a movie, TV show or a person',
        );

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF000000)),
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white24, fontFamily: 'Poppins'),
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
      textTheme: const TextTheme(
        headline6: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
      ),
      colorScheme: const ColorScheme(
        primary: Color(0xFFF57C00),
        primaryContainer: Color(0xFF8f4700),
        secondary: Color(0xFF202124),
        secondaryContainer: Color(0xFF141517),
        surface: Color(0xFFF57C00),
        background: Color(0xFF202124),
        error: Color(0xFFFF0000),
        onPrimary: Color(0xFF202124),
        onSecondary: Color(0xFF141517),
        onSurface: Color(0xFF141517),
        onBackground: Color(0xFFF57C00),
        onError: Color(0xFFFFFFFF),
        brightness: Brightness.dark,
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Color(0xFFF57C00),
        selectionHandleColor: Color(0xFFFFFFFF),
        selectionColor: Colors.white12,
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(
          Icons.clear,
          color: Color(0xFFF57C00),
        ),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: Color(0xFFF57C00)),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchWidget(
      query: query,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      color: const Color(0xFF202124),
      child: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          SizedBox(
            width: 50,
            height: 50,
            child: Icon(
              Icons.search,
              size: 50,
              color: Color(0xFFF57C00),
            ),
          ),
          Text(
            'Enter a term to search.',
            style: TextStyle(fontFamily: 'Poppins'),
          ),
        ],
      )),
    );
  }
}
