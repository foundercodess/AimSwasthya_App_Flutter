import 'dart:convert';

import 'package:aim_swasthya/repo/user/ai_search_repo.dart';
import 'package:aim_swasthya/res/popUp_const.dart';
import 'package:aim_swasthya/utils/const_config.dart';
import 'package:aim_swasthya/view_model/user/patient_home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:url_launcher/url_launcher.dart';

import '../../model/user/ai_search_model.dart';
import '../../res/size_const.dart';
import '../../utils/show_server_error.dart';

class VoiceSymptomSearchViewModel extends ChangeNotifier {
  final _aiSearchRepo = AiSearchRepo();
  final stt.SpeechToText _speech = stt.SpeechToText();
  final searchCon = TextEditingController();
  bool _isListening = false;
  String _voiceInput = '';
  List<String> _voiceSearchResults = [];
  List<String> _selectedSymptoms = [];
  String _symptomsData = '';
  String get symptomsData => _symptomsData;

  bool get isListening => _isListening;
  String get voiceInput => _voiceInput;
  List<String> get voiceSearchResults => _voiceSearchResults;
  List<String> get selectedSymptoms => _selectedSymptoms;

  VoiceSymptomSearchViewModel() {
    searchCon.addListener(_onTextChanged);
  }
  void _onTextChanged() {
    notifyListeners();
  }

  clearValues() {
    _selectedSymptoms = [];
    _voiceSearchResults = [];
    notifyListeners();
  }

  toggleSelectedSymptoms(String symptoms) {
    if (_selectedSymptoms.contains(symptoms)) {
      _selectedSymptoms.remove(symptoms);
    } else {
      _selectedSymptoms.add(symptoms);
    }
    notifyListeners();
  }

  // Future<void> initSpeech( BuildContext context ,{bool singleSearch = false}) async {
  //   print("kdjfjrfj");
  //  try {
  //     await _speech.initialize(
  //       onStatus: (status) {
  //         if (status == 'done') {
  //           print("dgedygeyudgede");
  //           _isListening = false;
  //           notifyListeners();
  //           print("hfhyufrgruyef");
  //           startListening(singleSearch:singleSearch);
  //         }
  //       },
  //       onError: (error) {
  //         print("ajididiuddheded${error}");
  //         _isListening = false;
  //         notifyListeners();
  //       },
  //     );
  //   } catch(e){
  //    showCupertinoDialog(
  //        context: context,
  //        builder: (context) {
  //          return ActionOverlay(
  //            height: Sizes.screenHeight/4.7,
  //            padding: EdgeInsets.only(left: Sizes.screenWidth*0.03,right:Sizes.screenWidth*0.03,top: Sizes.screenHeight*0.02),
  //            text: "Microphone Access Required",
  //            subtext: " We’re having trouble accessing your microphone. Please change your setting on 'speech recognition and synthesis from google' application",
  //            noLabel: "Cancel",
  //            yesLabel: "Proceed",
  //            onTap: () {
  //              Navigator.pop(context);
  //             Config. launchUrlExternal("https://play.google.com/store/apps/details?id=com.google.android.tts");
  //            },
  //          );
  //        });
  //    print("error during mic init $e");
  //  }
  // }
  // Future<void> initSpeech(BuildContext context, {bool singleSearch = false}) async {
  //   print("Initializing speech recognition...");
  //
  //   try {
  //     var permissionStatus = await Permission.microphone.request();
  //     if (!permissionStatus.isGranted) {
  //       throw Exception("Microphone permission not granted");
  //     }
  //
  //     bool isAvailable = await _speech.initialize(
  //       onStatus: (status) {
  //         print("Speech status: $status");
  //
  //         if (status == 'done' || status == 'notListening') {
  //           _isListening = false;
  //           notifyListeners();
  //
  //           if (!singleSearch) {
  //             Future.delayed(Duration(milliseconds: 300), () {
  //               startListening(singleSearch: singleSearch);
  //             });
  //           }
  //         }
  //       },
  //       onError: (error) {
  //         print("Speech error: ${error.errorMsg}");
  //         _isListening = false;
  //         notifyListeners();
  //       },
  //     );
  //
  //     if (!isAvailable) {
  //       throw Exception("Speech recognition is not available on this device");
  //     }
  //
  //     // Everything ready — start listening
  //     startListening(singleSearch: singleSearch);
  //
  //   } catch (e) {
  //     print("Error during speech init: $e");
  //
  //     showCupertinoDialog(
  //       context: context,
  //       builder: (context) {
  //         return ActionOverlay(
  //           height: Sizes.screenHeight / 4.7,
  //           padding: EdgeInsets.only(
  //             left: Sizes.screenWidth * 0.03,
  //             right: Sizes.screenWidth * 0.03,
  //             top: Sizes.screenHeight * 0.02,
  //           ),
  //           text: "Microphone Access Required",
  //           subtext: "We’re having trouble accessing your microphone. Please make sure microphone permissions are enabled and 'Speech Services by Google' is installed and updated.",
  //           noLabel: "Cancel",
  //           yesLabel: "Proceed",
  //           onTap: () {
  //             Navigator.pop(context);
  //             Config.launchUrlExternal("https://play.google.com/store/apps/details?id=com.google.android.tts");
  //           },
  //         );
  //       },
  //     );
  //   }
  // }

  Future<bool?> initSpeech(BuildContext context) async {
    try {
      bool available = await _speech.initialize(
        onStatus: (status) {
          if (status == 'done') {
            _isListening = false;
            notifyListeners();
          }
        },
        onError: (error) {
          _isListening = false;
          notifyListeners();
          debugPrint("Speech error: $error");
        },
      );

      if (!available) {
        showSpeechUnavailableDialog(context);
        return false;
      }
      return true;
    } catch (e) {
      debugPrint("Speech initialization failed: $e");
      showSpeechUnavailableDialog(context);
      return false;
    }
  }

  void launchPlayServices() async {
    const url =
        "https://play.google.com/store/apps/details?id=com.google.android.tts";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  void showSpeechUnavailableDialog(BuildContext context) {
    showCupertinoDialog(
        context: context,
        builder: (_) => ActionOverlay(
              height: Sizes.screenHeight / 3.8,
              padding: EdgeInsets.only(
                  left: Sizes.screenWidth * 0.03,
                  right: Sizes.screenWidth * 0.03,
                  top: Sizes.screenHeight * 0.02),
              onTap: () {
                Navigator.pop(context);
                launchPlayServices();
              },
              yesLabel: "Open Play Store",
              noLabel: "Cancel",
              text: 'Speech Recognition Not Available',
              subtext:
                  "This device doesn't support speech recognition or Google Play Services may be missing or updating.  Please check your device settings.",
            ));
  }

  // Future<void> initSpeech() async {
  //   await _speech.initialize(
  //     onStatus: (status) {
  //       if (status == 'done') {
  //         _isListening = false;
  //         notifyListeners();
  //       }
  //     },
  //     onError: (error) {
  //       _isListening = false;
  //       notifyListeners();
  //     },
  //   );
  // }
  //

  void startListening({bool singleSearch = false}) async {
    _isListening = true;
    notifyListeners();
    await _speech.listen(onResult: (result) {
      _voiceInput = result.recognizedWords;
      if (_voiceInput.isEmpty) return;
      if (singleSearch) {
        performSingleWordSearch(_voiceInput);
      } else {
        performSearch(_voiceInput);
      }
      notifyListeners();
    });
  }

  void stopListening() async {
    await _speech.stop();
    _isListening = false;
    notifyListeners();
  }

  void performSearch(String query) {
    _voiceSearchResults.add(query);
    notifyListeners();
  }

  String _singleSearchWord = '';
  String get singleSearchWord => _singleSearchWord;

  void performSingleWordSearch(String query) {
    _singleSearchWord = '';
    final words = query.trim().split(' ');
    if (words.isNotEmpty) {
      _singleSearchWord = words.first;
      _speech.stop();
      notifyListeners();
    }
  }

  setSearchedValAndPerformSearch() {
    searchCon.text = _singleSearchWord;
    notifyListeners();
  }

  void removeSearchedItem(String item) {
    _voiceSearchResults.remove(item);
    notifyListeners();
  }

  void clearInput() {
    _voiceInput = '';
    _voiceSearchResults = [];
    _singleSearchWord = '';
    notifyListeners();
  }

  GetAiSuggestionModel? _aiSearchData;
  GetAiSuggestionModel? get aiSearchData => _aiSearchData;
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool v) {
    _loading = v;
    notifyListeners();
  }

  setAiSearchData(GetAiSuggestionModel? data) {
    _aiSearchData = data;
    notifyListeners();
  }


  Future<void> aiSearchApi(context, {bool isVoiceSearchReq = true}) async {
    setLoading(true);
    setAiSearchData(null);

    final locationData =
        Provider.of<PatientHomeViewModel>(context, listen: false)
            .selectedLocationData;

    if (locationData == null) {
      debugPrint("Location data not found");
      return;
    }
    double latitude =
        double.tryParse(locationData.latitude?.toString() ?? '0') ?? 0.0;
    double longitude =
        double.tryParse(locationData.longitude?.toString() ?? '0') ?? 0.0;
    final symptoms = isVoiceSearchReq
        ? _voiceSearchResults.join(" ")
        : _selectedSymptoms.join(' ');
    _symptomsData = isVoiceSearchReq
        ? _voiceSearchResults.join(" ~ ")
        : _selectedSymptoms.join('~ ');
    debugPrint("symptoms $symptoms");
    Map data = {
      "symptoms": symptoms,
      "lat": latitude.toStringAsFixed(5),
      "lon": longitude.toStringAsFixed(5),
    };
    print("ansjnsj${jsonEncode(data)}");
    _aiSearchRepo.aiSearch(data).then((value) {
      if (value.success == true) {
        clearValues();
        setAiSearchData(value);
      }
      setLoading(false);
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }

  void showSpeechErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Speech Service Unavailable"),
        content: const Text(
            "Your device doesn't support speech recognition or permission is denied. "
            "Please enable it from settings or download Google's Voice Search service."),
        actions: [
          TextButton(
            onPressed: () {
              openAppSettings();
              Navigator.pop(context);
            },
            child: const Text("Open Settings"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }
}
