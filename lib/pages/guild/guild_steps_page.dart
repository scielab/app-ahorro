import 'package:app/controllers/auth/auth_controller.dart';
import 'package:app/controllers/guild/guild_controller.dart';
import 'package:app/pages/guild/guild_detail_page.dart';
import 'package:app/utils/dimension.dart';
import 'package:app/widgets/big_text.dart';
import 'package:app/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuildStepsPage extends StatefulWidget {
  final int idcourse;
  const GuildStepsPage({super.key, required this.idcourse});

  @override
  State<GuildStepsPage> createState() => _GuildStepsPageState();
}

class _GuildStepsPageState extends State<GuildStepsPage> {
  final guildController = Get.find<GuildController>();
  final auth = Get.find<AuthController>();
  late var user;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initializeCourse();
    });
    user = auth.user.value;
    super.initState();
  }

  void initializeCourse() async {
    // inicializacion de historial
    print(widget.idcourse);
    
    await guildController.getDataModuleCourse(widget.idcourse);
    await guildController.existHistoryDetailCourse(user.uid,widget.idcourse.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        
          body: Obx(() {
            //print(guildController.isLoadingModule);
            if(!guildController.isLoadingModule) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
            var data = guildController.currentCourse;
            return CustomScrollView(
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
                                  begin: Alignment(0.0, 2),
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
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  BigText(
                                    title: data!.name,
                                  ),
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
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(32.0),
                                  topRight: Radius.circular(32.0))),
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
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 30),
                            child: const BigText(title: "Detalles del Curso")),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 10),
                          child: const Row(
                            children: [
                              SmallText(title: "Capitulos"),
                              Spacer(),
                              SmallText(title: "Total"),
                            ],
                          ),
                        ),
                        if(guildController.isLoadingCurrentHistory.value) 
                        ...List.generate(
                            data!.modules.length,
                            (index) => GuildItemWidget(
                                title: "Lesson",
                                size: data.modules[index].n_lesson,
                                completed: guildController.historyController.completedLesson(data.modules[index].id.toString()),
                                callback: () {
                                  Get.to(() => GuildDetailPage(
                                      currentLesson: data.modules[index]),
                                      transition: Transition.rightToLeft);
                                })),
                        if(!guildController.isLoadingCurrentHistory.value)
                        const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ]),
                    ),
                  ],
                );
          }
          }
        ),

        );
  }
}

class GuildItemWidget extends StatelessWidget {
  final VoidCallback callback;
  final String title;
  final int size;
  final bool completed;

  const GuildItemWidget(
      {super.key,
      required this.title,
      required this.size,
      required this.callback,
      this.completed = false
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => callback(),
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 5),
                blurRadius: 10,
                spreadRadius: 1),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
              child: const Icon(
                Icons.credit_score_outlined,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BigText(title: title,size: Dimension.font16,),
                SmallText(title: "$size Lesson",size: Dimension.font16,),
              ],
            ),
            const Spacer(),
            BadgeTarget(completed: completed),
          ],
        ),
      ),
    );
  }
}

class BadgeTarget extends StatelessWidget {
  final bool completed;
  const BadgeTarget({super.key, required this.completed});

  @override
  Widget build(BuildContext context) {
    return !completed
        ? Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.blue),
            child: Row(
              children: [
                SmallText(
                  title: "No Completado",
                  color: Colors.white,
                  size: Dimension.font16,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.white,
                )
              ],
            ))
        : Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.green),
            child: const Row(
              children: [
                SmallText(
                  title: "Completado",
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.white,
                )
              ],
            ));
  }
}
