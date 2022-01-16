import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:vconapp/core/styles/size.dart';
import 'package:vconapp/core/styles/text_field_style.dart';
import 'package:vconapp/core/styles/text_style.dart';
import 'package:vconapp/core/utils/global_value.dart';

class MainFeatureScreen extends StatefulWidget {
  const MainFeatureScreen({Key? key}) : super(key: key);

  @override
  _MainFeatureScreenState createState() => _MainFeatureScreenState();
}

class _MainFeatureScreenState extends State<MainFeatureScreen> {

  bool isCreateRoom = true;
  String version = "";
  String buildNumber = "";

  final TextEditingController _displayNameInput = TextEditingController();
  final TextEditingController _subjectInput = TextEditingController();
  final TextEditingController _roomCodeInput = TextEditingController();
  final _formKeyJoin = GlobalKey<FormState>();
  final _formKeyCreate = GlobalKey<FormState>();

  Future _createRoom() async {
    var code = Random().nextInt(999999) + 100000;
    var code2 = DateTime.now().millisecond;

    Map<FeatureFlagEnum, bool> featureFlags = {
      FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
      FeatureFlagEnum.CALL_INTEGRATION_ENABLED: false,
      FeatureFlagEnum.PIP_ENABLED: false,
    };

    var options = JitsiMeetingOptions(room: "$code$code2")
      ..serverURL = serverUrl
      ..subject = _subjectInput.text
      ..userDisplayName = _displayNameInput.text
      ..audioOnly = false
      ..audioMuted = false
      ..videoMuted = false
      ..featureFlags.addAll(featureFlags)
      ..webOptions = {
        "roomName": "$code$code2",
        "width": "100%",
        "height": "100%",
        "enableWelcomePage": false,
        "chromeExtensionBanner": null,
        "userInfo": {"displayName": _displayNameInput.text}
      };

    await JitsiMeet.joinMeeting(
      options,
      listener: JitsiMeetingListener(
          onConferenceWillJoin: (message) {
            debugPrint("${options.room} will join with message: $message");
          },
          onConferenceJoined: (message) {
            debugPrint("${options.room} joined with message: $message");
          },
          onConferenceTerminated: (message) {
            debugPrint("${options.room} terminated with message: $message");
          },
          genericListeners: [
            JitsiGenericListener(
                eventName: 'readyToClose',
                callback: (dynamic message) {
                  debugPrint("readyToClose callback");
                }),
          ]),
    );
  }

  Future _joinRoom() async {
    Map<FeatureFlagEnum, bool> featureFlags = {
      FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
      FeatureFlagEnum.CALL_INTEGRATION_ENABLED: false,
      FeatureFlagEnum.PIP_ENABLED: false,
    };

    var options = JitsiMeetingOptions(room: _roomCodeInput.text.split("/").last)
      ..serverURL = serverUrl
      ..userDisplayName = _displayNameInput.text
      ..audioOnly = false
      ..audioMuted = false
      ..videoMuted = false
      ..featureFlags.addAll(featureFlags)
      ..webOptions = {
        "roomName": _roomCodeInput.text.split("/").last,
        "width": "100%",
        "height": "100%",
        "enableWelcomePage": false,
        "chromeExtensionBanner": null,
        "userInfo": {"displayName": _displayNameInput.text}
      };

    await JitsiMeet.joinMeeting(
      options,
      listener: JitsiMeetingListener(
          onConferenceWillJoin: (message) {
            debugPrint("${options.room} will join with message: $message");
          },
          onConferenceJoined: (message) {
            debugPrint("${options.room} joined with message: $message");
          },
          onConferenceTerminated: (message) {
            debugPrint("${options.room} terminated with message: $message");
          },
          genericListeners: [
            JitsiGenericListener(
                eventName: 'readyToClose',
                callback: (dynamic message) {
                  debugPrint("readyToClose callback");
                }),
          ]),
    );
  }

  Future _getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
  }

  @override
  void initState() {
    _getPackageInfo();
    super.initState();
  }

  @override
  void dispose() {
    _subjectInput.dispose();
    _displayNameInput.dispose();
    _roomCodeInput.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Vcon", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),),
      //   centerTitle: true,
      //   backgroundColor: Colors.white,
      // ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: autoSizedWidth(context, 0.1)),
          color: Colors.blue,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Image.asset(
                'assets/homeimage.png',
                fit: BoxFit.cover,
                width: 300,
              ),

              const SizedBox(height: 50,),

              // SizedBox(height: autoSizedHeight(context, 0.35),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      setState(() {
                        isCreateRoom = true;
                      });
                    },
                    child: Container(
                      width: autoSizedWidth(context, 0.4),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                          color: (isCreateRoom) ? Colors.blue :  Colors.white
                      ),
                      child: Text(
                        "Create",
                        style: TextStyle(
                            color: isCreateRoom ? Colors.white : Colors.blue,
                            fontSize: 16
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      setState(() {
                        isCreateRoom = false;
                      });
                    },
                    child: Container(
                      width: autoSizedWidth(context, 0.4),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          color: (!isCreateRoom) ? Colors.blue :  Colors.white
                      ),
                      child: Text(
                        "Join",
                        style: TextStyle(
                            color: !isCreateRoom ? Colors.white : Colors.blue,
                            fontSize: 16
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30,),

              (isCreateRoom) ?
              _createRoomWidget() :
              _joinRoomWidget(),

              const SizedBox(height: 30,),

              Text(
                "Version $version",
                style: textLabelStyle(color: Colors.white),
              ),
            ],
          )
      ),
    );
  }

  Widget _joinRoomWidget(){
    return Form(
      key: _formKeyJoin,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Display Name",
            style: textLabelStyle(color: Colors.white),
          ),
          const SizedBox(height: 5,),
          TextFormField(
            controller: _displayNameInput,
            textInputAction: TextInputAction.done,
            textAlign: TextAlign.center,
            validator: (value){
              if(value!.isEmpty){
                return "Display Name cannot be empty";
              }
            },
            decoration: textFieldStyle(hint: "Display Name"),
          ),
          const SizedBox(height: 10,),
          Text(
            "Room URL/Code",
            style: textLabelStyle(color: Colors.white),
          ),
          const SizedBox(height: 5,),
          TextFormField(
            controller: _roomCodeInput,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            validator: (value){
              if(value!.isEmpty){
                return "Room Code cannot be empty";
              }
            },
            decoration: textFieldStyle(hint: "Room URL/Code"),
          ),
          const SizedBox(height: 30,),
          ElevatedButton(
            onPressed: () {
              if(_formKeyJoin.currentState!.validate()){
                _joinRoom();
              }
            },
            child: const Text("Join a Room",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18
              ),
            ),
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                side: const BorderSide(width: 3, color: Colors.lightBlueAccent),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10),)
                ),
                primary: Colors.white,
                shadowColor: Colors.white
            ),

          )
        ],
      ),
    );
  }

  Widget _createRoomWidget(){
    return Form(
      key: _formKeyCreate,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Display Name",
            style: textLabelStyle(color: Colors.white),
          ),
          const SizedBox(height: 5,),
          TextFormField(
            controller: _displayNameInput,
            textInputAction: TextInputAction.done,
            textAlign: TextAlign.center,
            validator: (value){
              if(value!.isEmpty){
                return "Display Name cannot be empty";
              }
            },
            decoration: textFieldStyle(hint: "Display Name"),
          ),
          const SizedBox(height: 10,),
          Text(
            "Subject",
            style: textLabelStyle(color: Colors.white),
          ),
          const SizedBox(height: 5,),
          TextFormField(
            controller: _subjectInput,
            textInputAction: TextInputAction.done,
            textAlign: TextAlign.center,
            validator: (value){
              if(value!.isEmpty){
                return "Subject cannot be empty";
              }
            },
            decoration: textFieldStyle(hint: "Subject"),
          ),
          const SizedBox(height: 30,),
          ElevatedButton(
            onPressed: () {
              if(_formKeyCreate.currentState!.validate()){
                _createRoom();
              }
            },
            child: const Text("Create a Room",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18
              ),
            ),
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                side: const BorderSide(width: 3, color: Colors.lightBlueAccent),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10),)
                ),
                primary: Colors.white,
                shadowColor: Colors.white
            ),

          )
        ],
      ),
    );
  }
}


