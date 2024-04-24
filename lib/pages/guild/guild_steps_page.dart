

import 'package:app/controllers/guild/guild_controller.dart';
import 'package:app/pages/guild/guild_detail_page.dart';
import 'package:app/widgets/big_text.dart';
import 'package:app/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuildStepsPage extends StatefulWidget {
  const GuildStepsPage({super.key});

  @override
  State<GuildStepsPage> createState() => _GuildStepsPageState();
}



class _GuildStepsPageState extends State<GuildStepsPage> {
  final guildController = Get.find<GuildController>();

  @override
  void initState() {
    guildController.loadJsonData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var data = guildController.datalist;
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: <Widget>[
          SliverAppBar(
            stretch: true,
            onStretchTrigger: () {
              // Function callback for stretch
              return Future<void>.value();
            },
            expandedHeight: 250.0,
            flexibleSpace:  FlexibleSpaceBar(
              stretchModes: const <StretchMode>[
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle,
              ],
              centerTitle: true,
              background: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  const Image(
                    image: NetworkImage(
                        'https://img.freepik.com/vector-gratis/pagos-prestamos-estudiantiles-diferidos-concepto-abstracto-ilustracion-vectorial-paquete-estimulo-coronavirus-pausa-o-suspension-pago-obligaciones-financieras-metafora-abstracta-crisis-economica_335657-2935.jpg?w=826&t=st=1713211349~exp=1713211949~hmac=8690d8e98d65cc96369a360db6b4f67047f61e49bf4b052480338d294d5fc4b4'),
                    fit: BoxFit.cover,
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.0, 0.5),
                        end: Alignment.center,
                        colors: <Color>[
                          Color(0x60000000),
                          Color(0x00000000),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 80,
                    left: 30,
                    right: 30,
                 
                    child: Row(
                        children: [
                          // GestureDetector(
                          //   onTap: () {
                          //     Get.back();
                          //   },
                          //   child: const Icon(Icons.arrow_back,size: 30,)),
                          const SizedBox(width: 10,),
                          const BigText(title: "Course Details",),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white,
                            ),
                            child: const Icon(Icons.search,color: const Color.fromARGB(255, 47, 47, 47),),
                          )
                          
                        ],
                      ),
                    ),
                  
                ],
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0.0),
              child: Container(
                height: 32.0,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32.0),
                    topRight: Radius.circular(32.0)
                  )
                ),
                child: Container(
                  width: 40.0,
                  height: 5.0,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
              ),

            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: const EdgeInsets.only(left: 20,right: 20,bottom: 30),
                child: const BigText(title: "Basic English for CLass")),

              Container(
                margin: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
                child: const Row(
                  children: [
                    SmallText(title: "Chapter"),
                    Spacer(),
                    SmallText(title: "14 in total"),
                  ],
                ),
              ),
              ...List.generate(data.length, (index) => GuildItemWidget(title: "Lesson",size: data[index].length,callback: () {
                Get.to(() => GuildDetailPage());
              }))

            ]),
          ),
        ],
      ),
    );
  }
}


class GuildItemWidget extends StatelessWidget {
  final VoidCallback callback;
  final String title;
  final int size;

  const GuildItemWidget({super.key,required this.title, required this.size, required this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => callback(),
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
        decoration: BoxDecoration(
          color: Colors.pink[50],
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BigText(title: title),
                SmallText(title: "$size Lesson")
              ],
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios_outlined)
          ],
        ),
      ),
    );
  }
}

