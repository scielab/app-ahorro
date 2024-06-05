import 'dart:math';
import 'package:app/controllers/activity/activity_controller.dart';
import 'package:app/pages/activity/activity_detail.dart';
import 'package:app/pages/home_page.dart';
import 'package:app/utils/dimension.dart';
import 'package:app/widgets/base/card/card_primary_widget.dart';
import 'package:app/widgets/base/card/card_rutine_widget.dart';
import 'package:app/widgets/big_text.dart';
import 'package:app/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});
  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  final ActivityControlller activityController = Get.find<ActivityControlller>();
  
  // late BannerAd? _bannerAd;
  // bool isLoaded = false;
  // final adUnitId = Platform.isAndroid
  //   ? 'ca-app-pub-3940256099942544/6300978111'
  //   : 'ca-app-pub-3940256099942544/2934735716';
  

  @override
  void initState() {
    //loadAd();
    super.initState();
  }


  // void loadAd() {
  //   _bannerAd = BannerAd(
  //     adUnitId: adUnitId,
  //     request: const AdRequest(),
  //     size: AdSize.banner,
  //     listener: BannerAdListener(
  //       // Called when an ad is successfully received.
  //       onAdLoaded: (ad) {
  //         debugPrint('$ad loaded.');
  //         setState(() {
  //           isLoaded = true;
  //         });
  //       },
  //       // Called when an ad request failed.
  //       onAdFailedToLoad: (ad, err) {
  //         debugPrint('BannerAd failed to load: $err');
  //         // Dispose the ad here to free resources.
  //         ad.dispose();
  //       },
  //     ),
  //   )..load();
  // }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Actividades"),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: const Icon(
              Icons.notifications_sharp,
              size: 30,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // if(_bannerAd != null)
              //   Align(
              //     alignment: Alignment.center,
              //     child: SizedBox(
              //       width: _bannerAd!.size.width.toDouble(),
              //       height: _bannerAd!.size.height.toDouble(),
              //       child: AdWidget(ad: _bannerAd!),
              //     ),
              //   ),
                
              const BigText(title: "Tus rutinas"),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.calendar_today),
                  const SizedBox(width: 10),
                  SmallText(title: "Hoy", size: Dimension.font20,),
                ],
              ),
              const SizedBox(height: 20),
              Obx(() {
                var data = activityController.getTodayRutines();
                return Column(
                  children: List.generate(
                      data.length,
                      (index) => GestureDetector(
                            onTap: () {
                              if(data[index].type == "lecture") {
                                int randomIndex = Random().nextInt(activityController.recommended.length);
                                Get.to(() => ActivityDetailPage(content: activityController.recommended[randomIndex]));
                              } else if(data[index].type == 'budget') {
                                Get.to(() => const HomePage());
                              }
                            },
                            child: CardRutinePrimeryWidget(
                              title: data[index].name,
                            ),
                          )),
                );
              }),
              const SizedBox(
                height: 20,
              ),
              const BigText(title: "Tu plan para hoy"),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => Column(
                  children: List.generate(
                      activityController.recommended.length,
                      (index) => GestureDetector(
                            onTap: () {
                              Get.to(() => ActivityDetailPage(content: activityController.recommended[index]));
                            },
                            child: CardPrimeryWidget(
                              title: activityController.names[index]['title'],
                            ),
                          )),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}