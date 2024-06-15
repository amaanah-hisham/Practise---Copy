import 'dart:io';
import 'package:flutter/material.dart';
import 'package:practise/components/my_textfield.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  final FlutterContactPicker _contactPicker = new FlutterContactPicker();
  List<Contact>? _contacts;

  //For image picker
  Uint8List? _image;
  File? selectedImage;

  String? selectedMobileContact;

  //to fetch user info
  String fetchedUsername = '';
  String fetchedEmail = '';
  String fetchedMobile = '';
  String fetchedAddress = '';



  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        setState(() {
          fetchedEmail = userDoc['email'];
          fetchedUsername = userDoc['username'];
          fetchedMobile = userDoc['mobile'];
          fetchedAddress = userDoc['address'];
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.brown,
                        width: 1,
                      ),
                    ),
                    child: Stack(
                      children: [
                    _image != null ?
                     CircleAvatar(
                      radius: 100,
                      backgroundImage: MemoryImage(_image!)
                    ):const CircleAvatar(
                      radius: 100,
                      backgroundImage: AssetImage('lib/images/profile2.jpg'),
                      //NetworkImage("https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png")
                                          ),
                   ],
                  ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 30,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.brown[900],
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.add_a_photo,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () {
                          _showImagePicker(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              TextButton(
                onPressed: () {
                },
                child: Text(
                  'Edit Profile',
                  style: TextStyle(
                    color: Colors.brown[900],
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.only(left: 40),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Username',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.brown[900],
                    ),
                  ),
                ),
              ),
              MyTextField(
                controller: usernameController,
                hintText: fetchedUsername.isNotEmpty ? fetchedUsername : 'Username',
                obscureText: false,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))
                ],
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(left: 40),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Email',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.brown[900],
                    ),
                  ),
                ),
              ),
              MyTextField(
                controller: emailController,
                hintText: fetchedEmail.isNotEmpty ? fetchedEmail : 'Email',
                obscureText: false,
                validator: _validateEmail,
                inputType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(left: 40, right: 40),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Mobile',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.brown[900],
                    ),
                  ),
                ),
              ),
              Stack(
                children: [
                  MyTextField(
                    controller: mobileController,
                    hintText: fetchedMobile.isNotEmpty ? fetchedMobile : 'Mobile',
                    obscureText: false,
                    inputType: TextInputType.phone,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                  Positioned(
                    right: 30,
                    top: 12,
                    child: IconButton(
                      icon: const Icon(Icons.perm_contact_calendar_rounded, color: Colors.brown),
                      onPressed: () async {
                        Contact? contact = await _contactPicker.selectContact();
                        if (contact != null && contact.phoneNumbers!.isNotEmpty) {
                          setState(() {
                            selectedMobileContact = contact.phoneNumbers!.first;
                            mobileController.text = selectedMobileContact!;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(left: 40),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Address',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.brown[900],
                    ),
                  ),
                ),
              ),
              MyTextField(
                controller: addressController,
                hintText:  fetchedAddress.isNotEmpty ? fetchedAddress : 'Address',
                obscureText: false,
                inputType: TextInputType.phone,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),

              SizedBox(height: 23),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        // Save logic
                        print('Save button tapped');
                      }
                    },
                    child: Container(
                      width: 120,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.brown[900],
                        borderRadius: BorderRadius.circular(35),
                      ),
                      child: Center(
                        child: Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Cancel logic
                      print('Cancel button tapped');
                    },
                    child: Container(
                      width: 120,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.brown[900],
                        borderRadius: BorderRadius.circular(35),
                      ),
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  String? _validateEmail(String? value) {
    if (value != null && !value.contains('@')) {
      return 'Please enter a valid email';
    }
    return null;
  }

  void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
      // backgroundColor: Colors.white,
      context: context,
      builder: (builder) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child:SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height/5,
          child:Row(
            children:[
             Expanded(
              child: InkWell(
                onTap:(){
                  _chooseImageFromGallery();
                },
                child: const SizedBox(
                  child:Column(
                    children:[
                      Icon(Icons.image, size: 70, color: Colors.brown,),
                      Text("Gallery")
                    ],

                  ),
                ),
               ),
              ),

              Expanded(
               child:InkWell(
                onTap:(){
                  _chooseImageFromCamera();
                },
                child: const SizedBox(
                  child:Column(
                    children:[
                      Icon(Icons.camera_alt, size: 70,  color: Colors.brown,),
                      Text("Camera")
                    ],

                  ),
                ),
               ),
              ),
            ],
          ),
          ),
        );
      },
    );
  }

  Future _chooseImageFromGallery() async {
    final returnImage = await ImagePicker().pickImage(source:ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
        selectedImage = File(returnImage.path);
        _image = File(returnImage.path).readAsBytesSync();
    });

    Navigator.of(context).pop();
  }

  Future _chooseImageFromCamera() async {
    final returnImage = await ImagePicker().pickImage(source:ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });

    Navigator.of(context).pop();
  }

}
