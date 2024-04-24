import 'package:app/widgets/big_text.dart';
import 'package:app/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';


class CustomDelegate extends SearchDelegate {
  final TextEditingController _controller;

  List<dynamic> asks = [];
  bool _dataLoaded = false;

  Future<void> _loadDataIfNeeded() async {
    if (!_dataLoaded) {
      try {
        String jsonString = await rootBundle.loadString('assets/query.json');
        List<dynamic> jsonData = json.decode(jsonString);
        for (var item in jsonData) {
          asks.add(item['topic']);
        }
        _dataLoaded = true;
      } catch (e) {
        print('Error al cargar datos: $e');
      }
    }
  }
 
 CustomDelegate({
    String? searchFieldLabel,
    TextStyle? searchFieldStyle,
    InputDecorationTheme? searchFieldDecorationTheme,
    TextInputType? keyboardType,
    TextInputAction textInputAction = TextInputAction.search,
  }) : _controller = TextEditingController();

  @override
  Widget buildLeading(BuildContext context) =>
      IconButton(onPressed: () {
        close(context, null);
      }, icon: const Icon(Icons.keyboard_backspace_rounded, color: Color.fromARGB(255, 106, 106, 106)));



  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
        future: _loadDataIfNeeded(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar los datos'));
          } else {
            final List<dynamic> suggestionList = query.isEmpty
                ? asks : asks.where((result) => result.toLowerCase().contains(query.toLowerCase())).toList();
            return ListView.builder(
              itemCount: suggestionList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    print("Click");
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 20,right: 20, bottom: 20),
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 185, 38, 27),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        const SizedBox(width: 20,),
                        BigText(title: suggestionList[index],size: 16,),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      );
  }


  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var ask in asks) {
      if (ask.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(ask);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return BigText(title: result);
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) => <Widget>[
        GestureDetector(
          onTap: () {
            showResults(context);
          },
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            child: const Icon(Icons.search),
          ),
        )
      ];
}
