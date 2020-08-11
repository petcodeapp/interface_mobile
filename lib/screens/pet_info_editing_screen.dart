import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petcode_app/models/Owner.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/services/database_service.dart';
import 'package:petcode_app/services/firebase_storage_service.dart';
import 'package:petcode_app/services/image_picker_service.dart';
import 'package:petcode_app/utils/string_helper.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/utils/validator_helper.dart';
import 'package:petcode_app/widgets/circular_check_box.dart';
import 'package:provider/provider.dart';

class PetInfoEditingScreen extends StatefulWidget {
  PetInfoEditingScreen({Key key, this.currentPet, this.petImage})
      : super(key: key);

  final Pet currentPet;
  final ImageProvider petImage;

  @override
  _PetInfoEditingScreenState createState() => _PetInfoEditingScreenState();
}

class _PetInfoEditingScreenState extends State<PetInfoEditingScreen> {
  DatabaseService _databaseService;
  TextEditingController _nameInputController;
  TextEditingController _speciesInputController;
  TextEditingController _breedInputController;
  TextEditingController _colorInputController;
  TextEditingController _temperamentInputController;
  TextEditingController _additionalInfoInputController;

  /*
  TextEditingController _owner1NameInputController;
  TextEditingController _owner1EmailInputController;
  TextEditingController _owner1PhoneInputController;
  TextEditingController _owner1AddressInputController;

  TextEditingController _owner2NameInputController;
  TextEditingController _owner2EmailInputController;
  TextEditingController _owner2PhoneInputController;
  TextEditingController _owner2AddressInputController;
  */

  File chosenImageFile;
  ImageProvider updatedImage;

  bool _isServiceAnimal;
  bool _isAdopted;

  DateTime _birthDate;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _isServiceAnimal = widget.currentPet.isServiceAnimal;
    _isAdopted = widget.currentPet.isAdopted;
    updatedImage = widget.petImage;
    _birthDate = widget.currentPet.birthday.toDate();
    setUpInputControllers();
  }

  _handleImage(ImageSource source) async {
    final imagePickerService =
        Provider.of<ImagePickerService>(context, listen: false);

    File imageFile = await imagePickerService.pickImage(source);
    Navigator.pop(context);
    if (imageFile != null) {
      setState(() {
        chosenImageFile = imageFile;
        updatedImage = FileImage(imageFile);
      });
    }
  }

  _androidDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Add Photo'),
          children: <Widget>[
            SimpleDialogOption(
              child: Text('Take Photo'),
              onPressed: () => _handleImage(ImageSource.camera),
            ),
            SimpleDialogOption(
              child: Text('Choose From Gallery'),
              onPressed: () => _handleImage(ImageSource.gallery),
            ),
            SimpleDialogOption(
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.redAccent,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  _showSelectImageDialog() {
    return _androidDialog();
  }

  @override
  Widget build(BuildContext context) {
    _databaseService = Provider.of<DatabaseService>(context);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: StyleConstants.blue,
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.white),
        ),
        leading: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                onTap: () async {
                  if (_formKey.currentState.validate()) {
                    Pet updatedPet = widget.currentPet;

                    updatedPet.name = _nameInputController.text.trim();
                    updatedPet.species = _speciesInputController.text.trim();
                    updatedPet.breed = _breedInputController.text.trim();
                    updatedPet.birthday = Timestamp.fromDate(_birthDate);
                    updatedPet.color = _colorInputController.text.trim();
                    updatedPet.temperament = _temperamentInputController.text.trim();
                    updatedPet.isAdopted = _isAdopted;
                    updatedPet.isServiceAnimal = _isServiceAnimal;
                    updatedPet.additionalInfo = _additionalInfoInputController.text.trim();

                    if (widget.petImage != updatedImage) {
                      FirebaseStorageService firebaseStorageService =
                          Provider.of<FirebaseStorageService>(context,
                              listen: false);
                      String updatedProfileUrl = await firebaseStorageService
                          .uploadPetImage(chosenImageFile, updatedPet.pid);
                      updatedPet.profileUrl = updatedProfileUrl;
                    }

                    _databaseService.updatePet(widget.currentPet);
                    Navigator.pop(context);


                    /*
                    Owner contact_1 = new Owner(
                      name: _owner1NameInputController.text.trim(),
                      email: _owner1EmailInputController.text.trim(),
                      phoneNumber: _owner1PhoneInputController.text.trim(),
                      address: _owner1AddressInputController.text.trim(),
                    );

                    updatedPet.contact_1 = contact_1;

                    if (!owner2IsNull()) {
                      Owner contact_2 = new Owner(
                        name: _owner2NameInputController.text.trim(),
                        email: _owner2EmailInputController.text.trim(),
                        phoneNumber: _owner2PhoneInputController.text.trim(),
                        address: _owner2AddressInputController.text.trim(),
                      );

                      updatedPet.contact_2 = contact_2;
                    } else {
                      updatedPet.contact_2 = null;
                    }

                    */
                  }
                },
                child: Text(
                  'Done',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            //height: height,
            width: width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * 0.02,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      height: 150.0,
                      width: 150.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Image(
                        image: updatedImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  GestureDetector(
                    onTap: _showSelectImageDialog,
                    child: Text(
                      'Change Pet Photo',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Name',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      Spacer(),
                      Container(
                        height: height * 0.07,
                        width: width * 0.7,
                        child: TextFormField(
                          validator: (value) =>
                              ValidatorHelper.petNameValidator(value),
                          controller: _nameInputController,
                          decoration: InputDecoration(
                            hintText: 'Name',
                            hintStyle: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Species',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      Spacer(),
                      Container(
                        height: height * 0.07,
                        width: width * 0.7,
                        child: TextFormField(
                          validator: (value) =>
                              ValidatorHelper.petSpeciesValidator(value),
                          controller: _speciesInputController,
                          decoration: InputDecoration(
                            hintText: 'Species',
                            hintStyle: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Breed',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      Spacer(),
                      Container(
                        height: height * 0.07,
                        width: width * 0.7,
                        child: TextFormField(
                          validator: (value) =>
                              ValidatorHelper.petBreedValidator(value),
                          controller: _breedInputController,
                          decoration: InputDecoration(
                            hintText: 'Breed',
                            hintStyle: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Birthday',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      Spacer(),
                      Container(
                          height: height * 0.07,
                          width: width * 0.58,
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: _birthDate == null ?
                                  Text('Please select a date') : Text(StringHelper.getDateStringNoYear(_birthDate), style: TextStyle(fontSize: 18.0),),
                          ),
                      ),
                      IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2019),
                                  lastDate: DateTime(2021))
                              .then((date) {
                            setState(() {
                              _birthDate = date;
                              print(_birthDate.toString());
                            });
                          });
                        },
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Color',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      Spacer(),
                      Container(
                        height: height * 0.07,
                        width: width * 0.7,
                        child: TextFormField(
                          validator: (value) =>
                              ValidatorHelper.petColorValidator(value),
                          controller: _colorInputController,
                          decoration: InputDecoration(
                            hintText: 'Color',
                            hintStyle: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Temperament',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      Spacer(),
                      Container(
                        height: height * 0.07,
                        width: width * 0.7,
                        child: TextFormField(
                          validator: (value) =>
                              ValidatorHelper.petBreedValidator(value),
                          controller: _temperamentInputController,
                          decoration: InputDecoration(
                            hintText: 'Temperament',
                            hintStyle: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Adopted',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      Spacer(),
                      Container(
                        height: height * 0.07,
                        width: width * 0.7,
                        child: CircularCheckBox(
                            value: _isAdopted,
                            onChanged: (bool value) {
                              setState(() {
                                _isAdopted = value;
                              });
                            }),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Service Animal',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      Spacer(),
                      Container(
                        height: height * 0.07,
                        width: width * 0.7,
                        child: CircularCheckBox(
                            value: _isServiceAnimal,
                            onChanged: (bool value) {
                              setState(() {
                                _isServiceAnimal = value;
                              });
                            }),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Additional Info',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      Spacer(),
                      Container(
                        //height: height * 0.07,
                        width: width * 0.7,
                        child: TextFormField(
                          validator: (value) =>
                              ValidatorHelper.petAddInfoValidator(value),
                          controller: _additionalInfoInputController,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: 'Additional Info',
                            hintStyle: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      )
                    ],
                  ),

                  Divider(),

                  /*
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Owner 1',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18.0),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Name',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      Spacer(),
                      Container(
                        //height: height * 0.07,
                        width: width * 0.7,
                        child: TextFormField(
                          validator: (value) =>
                              ValidatorHelper.firstNameValidator(value),
                          controller: _owner1NameInputController,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: 'Name',
                            hintStyle: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      Spacer(),
                      Container(
                        //height: height * 0.07,
                        width: width * 0.7,
                        child: TextFormField(
                          validator: (value) =>
                              ValidatorHelper.emailValidator(value),
                          controller: _owner1EmailInputController,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Phone Number',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      Spacer(),
                      Container(
                        //height: height * 0.07,
                        width: width * 0.7,
                        child: TextFormField(
                          validator: (value) =>
                              ValidatorHelper.phoneNumberValidator(value),
                          controller: _owner1PhoneInputController,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: 'Phone Number',
                            hintStyle: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Address',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      Spacer(),
                      Container(
                        //height: height * 0.07,
                        width: width * 0.7,
                        child: TextFormField(
                          validator: (value) =>
                              ValidatorHelper.addressValidator(value),
                          controller: _owner1AddressInputController,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: 'Address',
                            hintStyle: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      )
                    ],
                  ),
                  Divider(),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Owner 2',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18.0),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Name',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      Spacer(),
                      Container(
                        //height: height * 0.07,
                        width: width * 0.7,
                        child: TextFormField(
                          validator: (value) => !owner2IsNull()
                              ? ValidatorHelper.firstNameValidator(value)
                              : null,
                          controller: _owner2NameInputController,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: 'Name',
                            hintStyle: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      Spacer(),
                      Container(
                        //height: height * 0.07,
                        width: width * 0.7,
                        child: TextFormField(
                          validator: (value) => !owner2IsNull()
                              ? ValidatorHelper.emailValidator(value)
                              : null,
                          controller: _owner2EmailInputController,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Phone Number',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      Spacer(),
                      Container(
                        //height: height * 0.07,
                        width: width * 0.7,
                        child: TextFormField(
                          validator: (value) => !owner2IsNull()
                              ? ValidatorHelper.phoneNumberValidator(value)
                              : null,
                          controller: _owner2PhoneInputController,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: 'Phone Number',
                            hintStyle: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Address',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      Spacer(),
                      Container(
                        //height: height * 0.07,
                        width: width * 0.7,
                        child: TextFormField(
                          validator: (value) => !owner2IsNull()
                              ? ValidatorHelper.addressValidator(value)
                              : null,
                          controller: _owner2AddressInputController,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: 'Address',
                            hintStyle: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      )
                    ],
                  ),

                  */
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void setUpInputControllers() {
    _nameInputController =
        new TextEditingController(text: widget.currentPet.name);
    _breedInputController =
        new TextEditingController(text: widget.currentPet.breed);
    _temperamentInputController =
        new TextEditingController(text: widget.currentPet.temperament);
    _additionalInfoInputController =
        new TextEditingController(text: widget.currentPet.additionalInfo);
    _speciesInputController =
    new TextEditingController(text: widget.currentPet.species);

    _colorInputController =
    new TextEditingController(text: widget.currentPet.color);

    /*
    _owner1NameInputController =
        new TextEditingController(text: widget.currentPet.contact_1.name);
    _owner1EmailInputController =
        new TextEditingController(text: widget.currentPet.contact_1.email);
    _owner1PhoneInputController = new TextEditingController(
        text: widget.currentPet.contact_1.phoneNumber);
    _owner1AddressInputController =
        new TextEditingController(text: widget.currentPet.contact_1.address);

    _owner2NameInputController = new TextEditingController();
    _owner2EmailInputController = new TextEditingController();
    _owner2PhoneInputController = new TextEditingController();
    _owner2AddressInputController = new TextEditingController();

    if (widget.currentPet.contact_2 != null) {
      _owner2NameInputController.text = widget.currentPet.contact_2.name;
      _owner2EmailInputController.text = widget.currentPet.contact_2.email;
      _owner2PhoneInputController.text =
          widget.currentPet.contact_2.phoneNumber;
      _owner2AddressInputController.text = widget.currentPet.contact_2.address;
    }
  }

  bool owner2IsNull() {
    return _owner2NameInputController.text.trim().isEmpty &&
        _owner2EmailInputController.text.trim().isEmpty &&
        _owner2PhoneInputController.text.trim().isEmpty &&
        _owner2AddressInputController.text.trim().isEmpty;
  }
  */
  }
}
