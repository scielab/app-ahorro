import 'package:app/controllers/guild/guild_controller.dart';
import 'package:app/pages/guild/guild_steps_page.dart';
import 'package:app/widgets/base/card/card_secundary_widget.dart';
import 'package:app/widgets/big_text.dart';
import 'package:app/widgets/search/custom_delegate.dart';
import 'package:app/widgets/staggered_gird_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class GuildPage extends StatefulWidget {
  const GuildPage({super.key});

  @override
  State<GuildPage> createState() => _GuildPageState();
}

class _GuildPageState extends State<GuildPage> {
  late GuildController guildController;

  @override
  void initState() {
    guildController = Get.find<GuildController>();
    setDataCourses();
    super.initState();
  }

  void setDataCourses() async {
    await guildController.getDataNamesGuilds();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const BigText(title: "Happy Learn",size: 25,),
        actions: [
          GestureDetector(
            onTap: () {
              showSearch(
                context: context,
                delegate: CustomDelegate(
                  searchFieldLabel: 'Buscar...',
                  searchFieldStyle: const TextStyle(fontSize: 16.0),
                  searchFieldDecorationTheme:
                      const InputDecorationTheme(
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.search,size: 30,)),
          ),
        ],
      ),
      body: Obx(() {
       if(guildController.isLoading) {
        var data = guildController.listcourses;
        return Container(
          margin: const EdgeInsets.only(left: 10,right: 10,top: 20),
          child: StaggeredDualWidet(itemCount: data.length,builder: (context,index) {
            return GestureDetector(
              onTap: () {
                Get.to(() => GuildStepsPage(idcourse: data[index].id),transition: Transition.rightToLeft);
              
              },
              child: CardSecundaryWidget(title: data[index].name));
          },
          spacing: 10,
          aspectRatio: 0.8,),
          ); 
       } else {
        return const Center(
        child: CircularProgressIndicator());
       }
      }
      ),
    );
  }
}

