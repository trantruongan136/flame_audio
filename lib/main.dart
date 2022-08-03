import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var isMusicOn = true.obs;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play('bgm.mp3');
    FlameAudio.audioCache.load('bgm.mp3');
    return SafeArea(
      // bottom: false,
      child: Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/330.jpg"),
                  fit: BoxFit.fill
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: Scrollbar(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(5),
                  itemCount: 150,
                  itemBuilder: (BuildContext context, index){
                    return const Center(
                      child: Text('data',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                        ),
                      ),
                    );
                  }),
              ),
            ),
            Positioned.fill(
              bottom: -25,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(50, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(200)
                    )
                  ),
                  onPressed: (){
                    FlameAudio.play('setting_sound.wav');
                    _scaffoldKey.currentState?.showBottomSheet(

                      (context){
                        return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Obx(() => TextButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      (isMusicOn == true.obs ) ? MaterialStateProperty.all(Colors.green):MaterialStateProperty.all(Colors.blue)),
                              onPressed: () {
                                if(isMusicOn == true.obs){
                                  FlameAudio.bgm.pause();
                                }else{
                                  FlameAudio.bgm.resume();
                                }
                                FlameAudio.play('click.wav');
                                isMusicOn.value = !isMusicOn.value;
                              },
                              child: (isMusicOn == true.obs) ? const Text(
                                "Turn music OFF",
                                style: TextStyle(color: Colors.white),
                              ):const Text(
                                "Turn music ON",
                                style: TextStyle(color: Colors.white),))),
                                IconButton(
                                    onPressed: () {
                                      FlameAudio.play('setting_sound.wav');
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.close)),
                        ],
                      );
                      },
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                      ),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * .7
                      ),
                      );
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 18),
                    child: Icon(Icons.menu_rounded,
                    ),
                  ),
                ),
              ))
          ],
        ),
      ),
    );
  }
}
