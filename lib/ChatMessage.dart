import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';

class Chatmessage extends StatelessWidget {
  const Chatmessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: ChatScreen(),
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late ScrollController _scrollController1;
  late ScrollController _scrollController2;
  late ScrollController _scrollController3;
  late AnimationController _animationController1;
  late AnimationController _animationController2;
  late FlutterTts flutterTts;
  late VideoPlayerController _videoPlayerController;
  final List<String> buttonTexts = [
    "Small Garden Ideas 🌱",
    "Workout Playlist Mix 🎧",
    "Imagine a Cat 🐈",
    "Nail Art Reels 💅",
    "Suggest Fun Facts 😃",
    "Romantic Poetry 📝",
    "What Is Python? 🤔",
    "World War 1 History 🪖",
    "Foods For Bulking 🍌",
    "Types Of Fishes 🐠"
  ];

  // Custom texts for the buttons

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    _scrollController1 = ScrollController();
    _scrollController2 = ScrollController();
    _scrollController3 = ScrollController();
    _animationController1 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    )..repeat(); // Infinite animation

    _animationController1.addListener(() {
      // Automatically scroll buttons to simulate movement
      if (_scrollController1.hasClients) {
        _scrollController1.jumpTo(_scrollController1.offset + 5);
      }
      if (_scrollController3.hasClients) {
        _scrollController3.jumpTo(_scrollController3.offset + 5);
      }
    });
    _animationController2 =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat();

    _animationController2.addListener(() {
      if (_scrollController2.hasClients) {
        _scrollController2.jumpTo(_scrollController2.offset - 7);

        // Check if the second column has scrolled to the start
        if (_scrollController2.offset <= 0) {
          _scrollController2
              .jumpTo(_scrollController2.position.maxScrollExtent); // Loop back
        }
      }
    });
    _videoPlayerController = VideoPlayerController.asset('assets/output2.webm')
      ..initialize().then((_) {
        setState(() {}); // Ensure the video is loaded before displaying
        _videoPlayerController.setLooping(true); // Loop the video
        _videoPlayerController.play(); // Start playing the video
      });
  }

  Future<void> _speak(String text) async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);

    await flutterTts.speak(text);
  }

  @override
  void dispose() {
    _animationController1.dispose();
    _scrollController1.dispose();
    _scrollController2.dispose();
    _scrollController3.dispose();
    flutterTts.stop();
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double devicewidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              icon: Icon(Icons.menu,size: 32,)
            );
          },
        ),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
              onPressed: () async {
                // await GoogleSignIn().signOut();
                // FirebaseAuth.instance.signOut();
                _scaffoldKey.currentState?.openEndDrawer();
              },
              icon: Image.asset("assets/OD_icon-removebg-preview.png",
                  height: 32, width: 32)),
        ],
      ),
      drawer: FullscreenDrawer(),
      endDrawer: rightsidedrawer(),
      body: GestureDetector(
        onTap: () {
          _speak(
              "Hello ${FirebaseAuth.instance.currentUser!.displayName!}. I am ZEDD, Your ultimate Smart campanion");
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.only(top: deviceHeight * 0.1)),
              Expanded(
                  child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage("assets/Z-img.png"),
                      height: deviceHeight * 0.08,
                      width: devicewidth * 0.08,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Zedd",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
                SizedBox(
                  height: deviceHeight * 0.02,
                ),
                Text(
                    "Hello ${FirebaseAuth.instance.currentUser!.displayName!}!",
                    style: TextStyle(color: Colors.white, fontSize: 24)),
              ])),

              SizedBox(
                height: deviceHeight * 0.1,
              ),
              Container(
                color: Colors.transparent,
                height: deviceHeight * 0.3,
                width: deviceHeight * 0.3,
                child: Lottie.asset(
                  'assets/wow.json',
                  width: 200, // Specify width if needed
                  height: 200, // Specify height if needed
                  fit: BoxFit.fill, // Adjust how the animation fits
                ),
                // child: _videoPlayerController.value.isInitialized
                //     ? AspectRatio(
                //         aspectRatio: _videoPlayerController.value.aspectRatio,
                //         child: VideoPlayer(_videoPlayerController),
                //       )
                //     : const CircularProgressIndicator(), // Display loading indicator until video is loaded
              ),
              SizedBox(
                height: deviceHeight * 0.01,
              ),
              // SizedBox(
              //     child: Column(children: [
              //   Container(
              //     child: SingleChildScrollView(
              //       scrollDirection: Axis.horizontal,
              //       controller:
              //           _scrollController1, // Controller for automatic scrolling
              //       child: Row(
              //         children: List.generate(
              //           1000, // Simulate an infinitely long list of buttons
              //           (index) {
              //             int buttonIndex = index %
              //                 buttonTexts.length; // Loop through button texts
              //             return Padding(
              //               padding: const EdgeInsets.symmetric(horizontal: 6),
              //               child: Container(
              //                 decoration: BoxDecoration(
              //                     gradient: LinearGradient(colors: [
              //                       Color(0xFF000928),
              //                       Color(0xFF000A2C)
              //                     ]),
              //                     borderRadius: BorderRadius.circular(16),
              //                     border: const GradientBoxBorder(
              //                         gradient: LinearGradient(colors: [
              //                       Color(0xFF40475E),
              //                       Color.fromARGB(255, 35, 38, 46)
              //                     ]))),
              //                 child: ElevatedButton(
              //                   onPressed: () {}, // Add your button action here
              //                   child: Text(
              //                     buttonTexts[buttonIndex],
              //                     style: TextStyle(color: Colors.white),
              //                   ), // Display custom text
              //                   style: ButtonStyle(
              //                     shape: MaterialStateProperty.all<
              //                             RoundedRectangleBorder>(
              //                         RoundedRectangleBorder(
              //                             borderRadius:
              //                                 BorderRadius.circular(16))),
              //                     backgroundColor:
              //                         MaterialStateProperty.all<Color>(
              //                             Colors.transparent),
              //                     foregroundColor:
              //                         MaterialStateProperty.all<Color>(
              //                             Colors.transparent),
              //                     shadowColor: MaterialStateProperty.all<Color>(
              //                         Colors.transparent),
              //                   ),
              //                 ),
              //               ),
              //             );
              //           },
              //         ),
              //       ),
              //     ),
              //   ),
              //   SizedBox(
              //     height: 10,
              //   ),
              //   Container(
              //     child: SingleChildScrollView(
              //       scrollDirection: Axis.horizontal,
              //       controller:
              //           _scrollController2, // Controller for automatic scrolling
              //       child: Row(
              //         children: List.generate(
              //           1000, // Simulate an infinitely long list of buttons
              //           (index) {
              //             int buttonIndex = index %
              //                 buttonTexts.length; // Loop through button texts
              //             return Padding(
              //               padding: const EdgeInsets.symmetric(horizontal: 6),
              //               child: Container(
              //                 decoration: BoxDecoration(
              //                     gradient: LinearGradient(colors: [
              //                       Color(0xFF000928),
              //                       Color(0xFF000A2C)
              //                     ]),
              //                     borderRadius: BorderRadius.circular(16),
              // border: const GradientBoxBorder(
              //     gradient: LinearGradient(colors: [
              //   Color(0xFF40475E),
              //   Color.fromARGB(255, 35, 38, 46)
              // ]))),
              //                 child: ElevatedButton(
              //                   onPressed: () {}, // Add your button action here
              //                   child: Text(
              //                     buttonTexts[buttonIndex],
              //                     style: TextStyle(color: Colors.white),
              //                   ), // Display custom text
              //                   style: ButtonStyle(
              //                     shape: MaterialStateProperty.all<
              //                             RoundedRectangleBorder>(
              //                         RoundedRectangleBorder(
              //                             borderRadius:
              //                                 BorderRadius.circular(16))),
              //                     backgroundColor:
              //                         MaterialStateProperty.all<Color>(
              //                             Colors.transparent),
              //                     foregroundColor:
              //                         MaterialStateProperty.all<Color>(
              //                             Colors.transparent),
              //                     shadowColor: MaterialStateProperty.all<Color>(
              //                         Colors.transparent),
              //                   ),
              //                 ),
              //               ),
              //             );
              //           },
              //         ),
              //       ),
              //     ),
              //   ),
              //   SizedBox(
              //     height: 10,
              //   ),
              //   Container(
              //     child: SingleChildScrollView(
              //       scrollDirection: Axis.horizontal,
              //       controller:
              //           _scrollController3, // Controller for automatic scrolling
              //       child: Row(
              //         children: List.generate(
              //           1000, // Simulate an infinitely long list of buttons
              //           (index) {
              //             int buttonIndex = index %
              //                 buttonTexts.length; // Loop through button texts
              //             return Padding(
              //               padding: const EdgeInsets.symmetric(horizontal: 6),
              //               child: Container(
              //                 decoration: BoxDecoration(
              // gradient: LinearGradient(colors: [
              //   Color(0xFF000928),
              //   Color(0xFF000A2C)
              // ]),
              //                     borderRadius: BorderRadius.circular(16),
              //                     border: const GradientBoxBorder(
              //     gradient: LinearGradient(colors: [
              //   Color(0xFF40475E),
              //   Color.fromARGB(255, 35, 38, 46)
              // ]))),
              //                 child: ElevatedButton(
              //                   onPressed: () {}, // Add your button action here
              //                   child: Text(
              //                     buttonTexts[buttonIndex],
              //                     style: TextStyle(color: Colors.white),
              //                   ), // Display custom text
              //                   style: ButtonStyle(
              //                     shape: MaterialStateProperty.all<
              //                             RoundedRectangleBorder>(
              //                         RoundedRectangleBorder(
              //                             borderRadius:
              //                                 BorderRadius.circular(16))),
              //                     backgroundColor:
              //                         MaterialStateProperty.all<Color>(
              //                             Colors.transparent),
              //                     foregroundColor:
              //                         MaterialStateProperty.all<Color>(
              //                             Colors.transparent),
              //                     shadowColor: MaterialStateProperty.all<Color>(
              //                         Colors.transparent),
              //                   ),
              //                 ),
              //               ),
              //             );
              //           },
              //         ),
              //       ),
              //     ),
              //   )
              // ])),
            ],
          ),
        ),
      ),
    );
  }
}
class rightsidedrawer extends StatefulWidget {
 const rightsidedrawer({Key? key, this.user}) : super(key: key);
  final User? user;
  @override
  State<rightsidedrawer> createState() => _rightsidedrawerState();
}

class _rightsidedrawerState extends State<rightsidedrawer> {
  CameraController? _cameraController;
  List<CameraDescription>? cameras;
  bool _isCameraInitialized = false;

   void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    if (cameras != null && cameras!.isNotEmpty) {
      _cameraController = CameraController(
        cameras![0], // Use the first camera (usually the rear camera)
        ResolutionPreset.medium,
      );

      await _cameraController?.initialize();
      setState(() {
        _isCameraInitialized = true;
      });
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
        double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Drawer(
      backgroundColor: Colors.black,
        width: double.infinity,
        child: Center(
          
          child: Column(
            
            children: [
              
            Padding(
              padding: const EdgeInsets.all(30),
              child: Container(
                
                width: double.infinity,
                height: deviceHeight*0.9,
                decoration: BoxDecoration(
                  
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.grey.withOpacity(0.2),
                ),
                child: _isCameraInitialized
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CameraPreview(_cameraController!),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
              ),
            ),
          ]),
        ),
      
      

    );
  }
}

class FullscreenDrawer extends StatefulWidget {
  const FullscreenDrawer({Key? key, this.user}) : super(key: key);
  final User? user;

  @override
  State<FullscreenDrawer> createState() => _FullscreenDrawerState();
}




class _FullscreenDrawerState extends State<FullscreenDrawer> {
  List<Map<String, dynamic>> drawerelements = [
    {"name": "Profile Settings", "ficon": Icons.settings},
    {"name": "Conversation History", "ficon": Icons.history},
    {"name": "About Us", "ficon": Icons.info_outline},
    {"name": "Help", "ficon": Icons.help_outline},
  ];

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    // Fetch the high-quality Google profile picture by appending "?sz=1024" for better resolution
    String profileImageUrl =
        "${FirebaseAuth.instance.currentUser!.photoURL}?sz=1024";

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Blur effect on the background
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.transparent,
            ),
          ),
          Drawer(
            backgroundColor: Colors.transparent,
            width: double.infinity,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
              child: Column(
                children: [
                  SizedBox(height: deviceHeight * 0.1),
                  // Profile Picture Section
                  Stack(
                    children: [
                     Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Color(0xFF1E1E1E), // Placeholder background
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // Square-shaped profile image container
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              width: 100,
                              height: 100, // Square shape
                              child: Image.network(
                                profileImageUrl,
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded /
                                              (loadingProgress.expectedTotalBytes ?? 1)
                                          : null,
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(Icons.account_circle,
                                      size: 80, color: Colors.white); // Fallback icon
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          // User Info
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello,",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  
                                ),
                              ),
                              
                              Text(
                                "${FirebaseAuth.instance.currentUser!.displayName}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          ),
                          
                        ],
                      ),
                    ),
                     Positioned(
                        top: 10,
                        right: 10,
                        child: IconButton(
                          icon: Icon(Icons.close, color: Colors.white,size: 32,),
                          onPressed: () {
                            Navigator.pop(context); // Close the drawer
                          },
                        ),
                      ),
                ]),
                  
                  // Menu items
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Color(0xFF1E1E1E),
                          ),
                          child: ListTile(
                          
                            leading: Icon(
                              drawerelements[index]["ficon"],
                              color: Colors.white,
                            ),
                            title: Text(
                              drawerelements[index]["name"]!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 20);
                      },
                      itemCount: drawerelements.length,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
