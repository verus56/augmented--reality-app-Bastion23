
import 'dart:io';
import 'dart:ui';


import '/Posts/post_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../main.dart';
import '../homepage.dart';



class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {

  late CameraController _controller;
  bool _isCameraInitialized = false;
  String CapturedImage = "";


  Future<void> _onTap(TapUpDetails details) async {
    if(_controller.value.isInitialized) {
      var showFocusCircle = true;
      var x = details.localPosition.dx;
      var y = details.localPosition.dy;

      double fullWidth = MediaQuery.of(context).size.width;
      double cameraHeight = fullWidth * _controller.value.aspectRatio;

      double xp = x / fullWidth;
      double yp = y / cameraHeight;

      Offset point = Offset(xp,yp);
      print("point : $point");

      // Manually focus
      await _controller.setFocusPoint(point);

      // Manually set light exposure
      //controller.setExposurePoint(point);

      setState(() {
        Future.delayed(const Duration(seconds: 2)).whenComplete(() {
          setState(() {
            showFocusCircle = false;
          });
        });
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = CameraController(cameras[0], ResolutionPreset.max);
    _controller.initialize().then((_){
      if(!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if(e is CameraException){
        switch(e.code){
          case 'CameraAccessDenied':
            print("access was denied");
            break;
          default:
            print(e.description);
            break;
        }
      }
    });
  }




  @override
  Widget build(BuildContext context) {
    final ScreenHeight = MediaQuery.of(context).size.height;
    final ScreenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(0),
          child: Center(
            child: CapturedImage == '' ? Stack(
              children: [
                GestureDetector(
                  onTapUp: (details){
                    _onTap(details);
                  },
                  child: Container(
                    height: ScreenHeight,
                    width: double.infinity,
                    decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                    ) ,
                    child: CameraPreview(_controller),
                  ),
                ),
                Positioned(
                    top: 10,left: ScreenWidth /2 -125,
                    child: Container(
                        height: 30,
                        width: 250,
                        decoration: BoxDecoration(
                            color: Color(0xFFebebeb).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(30)
                        ),
                        child: Center(
                          child:Text("SnapPost",style: GoogleFonts.quicksand(
                              letterSpacing: 1,
                              textStyle: TextStyle(color: Colors.white,fontSize: 22,)
                          )
                          ),
                        )
                    )
                ),
                Positioned(
                    bottom: 100,left: ScreenWidth /2-110,
                    child: InkWell(
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.black,
                        ),
                        child: Icon(Icons.add_to_photos_outlined,color: Colors.white,),
                      ),
                      onTap: (){
                        selectImageFromGallery();
                      },
                    )
                ),
                Positioned(
                    bottom: 100,left: ScreenWidth /2-40,
                    child: InkWell(
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color: Colors.white,
                              width: 5,
                            )
                        ),
                        child: Center(
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                    color: Colors.white,
                                    width: 2
                                )
                            ),
                          ),
                        ),
                      ),
                      onTap: () async{
                        if(!_controller.value.isInitialized){
                          return null;
                        }
                        if(_controller.value.isTakingPicture){
                          return null;
                        }

                        try{
                          await _controller.setFlashMode(FlashMode.off);
                          XFile file = await _controller.takePicture();
                          //File f = File(Picfile.path);
                          //var CompressedFile = await FlutterImageCompress.compressWithFile(f);
                          setState(() {
                            CapturedImage = file.path;
                          });

                          //Navigator.push(context,MaterialPageRoute(builder: (context)=> ImagePreview(file)));
                        }on CameraException catch (e){
                          debugPrint("Error occoured while taking pic : $e");
                          return null;
                        }
                      },
                    )
                ),
                Positioned(
                    bottom: 100,left: ScreenWidth /2+60,
                    child: InkWell(
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.black,
                        ),
                        child: Icon(Icons.flip_camera_android,color: Colors.white,),
                      ),
                      onTap: () async{

                      },
                    )
                ),
              ],
            ) : ShowImage(ScreenHeight, ScreenWidth, CapturedImage),
          ),
        )
    );
  }

  Future<bool> _onBackPressed() async {
    return await showDialog(
        context: context, builder: (context) => pagen());
  }


  Widget ShowImage(ScreenHeight,ScreenWidth, CapturedImage){
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: 8,right: 8),
            height: ScreenHeight,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child:  FittedBox(
              child: Image.file(File(CapturedImage)),
              fit: BoxFit.cover,
            ),
          ) ,
          Positioned(
              bottom: 50,left: ScreenWidth /2 - 150,
              child: InkWell(
                child: Container (
                    width: 300,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFFffffff).withOpacity(1),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Post Snap",style: TextStyle(fontSize: 25,),),
                            SizedBox(width: 15,),
                            Icon(Icons.send_rounded,color: Colors.black,size: 30,)
                          ],
                        ),
                      ),
                    )
                ),
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PostScreen(CapturedImage)));
                },
              )
          ),
        ],
      ),
    );
  }
  Future selectImageFromGallery() async{
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery,imageQuality: 60);
    if(file != null){
      print("File path: "+file.path);
      setState(() {
        if(file.path != null){
          CapturedImage = file.path;
        }
      });
      return file.path;
    }else{
      return '';
    }
  }

}




