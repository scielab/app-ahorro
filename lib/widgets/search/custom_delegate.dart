import 'package:app/pages/guild/guild_steps_page.dart';
import 'package:app/utils/dimension.dart';
import 'package:app/widgets/big_text.dart';
import 'package:app/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:get/get.dart';


class CustomDelegate extends SearchDelegate {
  final List<Map<String,dynamic>> searchList = [];
  final TextEditingController _controller;

  List<dynamic> asks = [];
  bool _dataLoaded = false;

  Future<void> _loadDataCourses() async {
    if(!_dataLoaded) {
      try {
        String jsonString = await rootBundle.loadString('assets/data/content.json');
        List<dynamic> jsonData = json.decode(jsonString);
        for(var item in jsonData) {
          var form = {
            'name': item['name'],
            'id': item['id']
          };
          searchList.add(form);
        }
        _dataLoaded = true;
      } catch (e) {
        print("Error al cargar los datos");
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


  // Este proporciona el buton para volver hacia atras
  @override
  Widget buildLeading(BuildContext context) =>
      IconButton(onPressed: () {
        close(context, null);
      }, icon: const Icon(Icons.keyboard_backspace_rounded, color: Color.fromARGB(255, 106, 106, 106)));


  // Este porporciona suferneicas 
  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
        future: _loadDataCourses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar los datos'));
          } else {


            final List<Map<String,dynamic>> suggestionList = query.isEmpty
                ? searchList : searchList.where((result) => result['name'].toLowerCase().contains(query.toLowerCase())).toList();
            return ListView.builder(
              itemCount: suggestionList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    print("Click");
                    // Lo mandamos a detail Guild desde aqui
                    Get.to(() => GuildStepsPage(idcourse: suggestionList[index]['id']));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 20,right: 20, bottom: 20),
                    child: Row(
                      children: [
                        const Icon(Icons.arrow_drop_down_outlined),
                        const SizedBox(width: 20,),
                        BigText(title: suggestionList[index]['name'],size: Dimension.font20,),
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

  // Este es Respondable de mostrar los resultados de la busqueda
  @override
  Widget buildResults(BuildContext context) {
    List<Map<String,dynamic>> matchQuery = [];
    for (var ask in searchList) {
      if (ask['name'].toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(ask);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            print("Click");
            // Lo mandamos a detail Guild desde aqui
            Get.to(() => GuildStepsPage(idcourse: matchQuery[index]['id']));
          },
          child: Container(
            margin: const EdgeInsets.only(left: 20,right: 20, bottom: 20),
            child: Row(
              children: [
                const Icon(Icons.arrow_drop_down_outlined),
                const SizedBox(width: 20,),
                BigText(title: matchQuery[index]['name'],size: Dimension.font20,),
              ],
            ),
          ),
        );
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
