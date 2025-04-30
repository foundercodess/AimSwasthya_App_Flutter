// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter/material.dart';
//
// class SignInScreen extends StatefulWidget {
//   @override
//   _SignInScreenState createState() => _SignInScreenState();
// }
//
// class _SignInScreenState extends State<SignInScreen> {
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   bool isSigningIn = false;
//
//   Future<User?> _signInWithGoogle() async {
//     setState(() {
//       isSigningIn = true; // Show loading indicator
//     });
//
//     try {
//       // Trigger the Google Sign-In process
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       if (googleUser == null) {
//         setState(() {
//           isSigningIn = false;
//         });
//         return null;
//       }
//
//       // Obtain the Google authentication details
//       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//
//       // Create a new credential
//       final OAuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//
//       // Sign in to Firebase with the credential
//       final UserCredential userCredential = await _auth.signInWithCredential(credential);
//       setState(() {
//         isSigningIn = false;
//       });
//
//       return userCredential.user;
//     } catch (e) {
//       setState(() {
//         isSigningIn = false;
//       });
//       print('Error during Google sign-in: $e');
//       return null;
//     }
//   }
//
//   Future<void> _signOut() async {
//     setState(() {
//       isSigningIn = false; // Reset signing-in state
//     });
//     await _googleSignIn.signOut();
//     await _auth.signOut();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Google Sign-In with Firebase')),
//       body: Center(
//         child: isSigningIn
//             ? const CircularProgressIndicator()
//             : Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () async {
//                 final User? user = await _signInWithGoogle();
//                 if (user != null) {
//                   print('User signed in: ${user.displayName}');
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('Signed in as ${user.displayName}')),
//                   );
//                 } else {
//                   print('Sign-in failed or was canceled.');
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('Sign-in failed or was canceled')),
//                   );
//                 }
//               },
//               child: const Text('Sign in with Google'),
//             ),
//             ElevatedButton(
//               onPressed: _signOut,
//               child: const Text('Sign out'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:mime/mime.dart';
import 'package:aim_swasthya/res/api_urls.dart';
import 'package:aim_swasthya/view_model/user/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class UploadFileToS3 extends StatefulWidget {
  const UploadFileToS3({super.key});

  @override
  State<UploadFileToS3> createState() => _UploadFileToS3State();
}

class _UploadFileToS3State extends State<UploadFileToS3> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  File? _image;

  final ImagePicker _picker = ImagePicker();

  // Select the Image
  Future<void> _selectImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      print('filepath: ${pickedFile.path}');
    }
  }

  // Get Presigned URL for the file we are supposed to upload (here image file).
  //My api requires fileType and fileName. So, I've passed those in the data in post call.
  Future<String?> _getPresignedUrl(File file) async {
    try {
      String fileType = file.path.endsWith('.png') ||
              file.path.endsWith('.jpg') ||
              file.path.endsWith('.jpeg')
          ? 'image'
          : 'video';

      print('Filetype: $fileType');

      String fileName = 'file.${file.path.split('.').last}';
      print("object: $fileName");
      // Response presignedUrlResponse = await Dio().post(
      //   'http://3.7.71.4:3000/getS3SignedUrl',
      //   data: {
      //     'fileType': fileType,
      //     'fileName': fileName,
      //   },
      //   // options: Options(headers: {'Authorization': "Auth Token"}),
      // );
      final bearerToken = await UserViewModel().getBeToken();

      final response = await Dio().post(
        PatientApiUrl.getImageUrl,
        options: Options(headers: {
          "Authorization": "Bearer $bearerToken",
          "Content-Type": "application/json",
        }),
        data: {
          "fileName": fileName,
          "fileType": fileType,
        },
      );

      final data = response.data;
      debugPrint("🔍 API Response: $data");

      // debugPrint("hii: ${presignedUrlResponse.data['body-json']['body']}");
      return response.data['presigned_url'];
    } catch (error) {
      debugPrint('Error getting pre signed url: $error');
      return null;
    }
  }

  // Now, uploading that file to the received presigned url
  // Future<String?> _uploadFileToPresignedUrl(
  //     File file, String presignedUrl) async {
  //   try {
  //     List<int> fileBytes = await file.readAsBytes();
  //
  //     var request = http.Request('PUT', Uri.parse(presignedUrl));
  //
  //     String contentTypeString = file.path.endsWith('.png') ||
  //             file.path.endsWith('.jpg') ||
  //             file.path.endsWith('.jpeg')
  //         ? 'image'
  //         : 'video';
  //
  //     // Send request headers
  //     request.headers['Content-Type'] = contentTypeString;
  //
  //     // Send file bytes
  //     request.bodyBytes = fileBytes;
  //
  //     // Send the request
  //     var response = await request.send();
  //
  //     if (response.statusCode == 200) {
  //       print('File uploaded successfully');
  //       return presignedUrl.split('?').first;
  //     } else {
  //       print('Failed to upload the file: ${response.reasonPhrase}');
  //       return null;
  //     }
  //   } catch (error) {
  //     print('Error uploading file: $error');
  //     return null;
  //   }
  // }

  Future<String?> _uploadFileToPresignedUrl(File file, String presignedUrl) async {
    try {
      List<int> fileBytes = await file.readAsBytes();

      final mimeType = lookupMimeType(file.path) ?? 'application/octet-stream';

      var request = http.Request('PUT', Uri.parse(presignedUrl));
      request.headers['Content-Type'] = mimeType;
      request.bodyBytes = fileBytes;

      var response = await request.send();

      if (response.statusCode == 200) {
        print('✅ File uploaded successfully');
        return presignedUrl.split('?').first;
      } else {
        print('❌ Failed to upload the file: ${response.statusCode}');
        print('Response body: ${await response.stream.bytesToString()}');
        return null;
      }
    } catch (error) {
      print('🔥 Error uploading file: $error');
      return null;
    }
  }

  // Submitting the title, description and image file
  Future<void> _submit() async {
    String title = _titleController.text;
    String description = _descriptionController.text;

    try {
      String? presignedUrl = await _getPresignedUrl(_image!);

      if (presignedUrl != null) {
        // Just to check what presignedURL we have received
        print('PresignedURL Received: $presignedUrl');

        String? uploadedUrl =
            await _uploadFileToPresignedUrl(_image!, presignedUrl);

        if (uploadedUrl != null) {
          Response response = await Dio().post('Your API for posting data',
              data: {
                "title": title,
                "description": description,
                "thumbImage": uploadedUrl,
              },
              // options: Options(headers: {'Authorization': "Auth Token"})
              );

          print('response on submit: $response');

          setState(() {
            _titleController.clear();
            _descriptionController.clear();
            _image = null;

            // After Successful upload, showing a dialog
            showDialog(
              context: context,
              builder: ((context) {
                return AlertDialog(
                  title: const Text("File Uploaded Successfully"),
                  content: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 100,
                        color: Colors.green,
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Okay"),
                    ),
                  ],
                );
              }),
            );
          });
        } else {
          print('Failed to Submit data');
        }
      } else {
        print('Failed to get presigned URL');
      }
    } catch (error) {
      print('Error submitting data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload File to S3'),
        backgroundColor: Theme.of(context).primaryColorLight,
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          children: [
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Enter a title and select a file to upload',
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
            const SizedBox(
              height: 30,
            ),

            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Enter a title',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                ),
                maxLines: 10,
              ),
            ),

            const SizedBox(
              height: 30.0,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Select Image',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  onTap: _selectImage,
                  child: Container(
                    width: 200,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: _image != null
                        ? Image.file(
                            _image!,
                            width: 200,
                            height: 100,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.add),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 40,
            ),

            // Button to submit the data
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.blue,
                ),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.all(16),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              onPressed: _submit,
              child: const Text(
                'Submit',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
