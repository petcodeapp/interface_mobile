import 'package:flutter/material.dart';
import 'package:petcode_app/models/Owner.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/utils/style_constants.dart';

class PetInfoScreen extends StatelessWidget {
  PetInfoScreen({Key key, this.currentPet}) : super(key: key);
  final Pet currentPet;

  double height;
  double width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: StyleConstants.blue,
      body: SingleChildScrollView(
        child: Container(
          height: height * 1.5,
          child: Stack(
            children: [
              Container(
                height: height * 0.4,
                child: Image.asset(
                  'assets/images/puppyphoto.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                height: height * 0.15,
                child: Container(
                  width: width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        color: Colors.white,
                        iconSize: 30.0,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        color: Colors.white,
                        iconSize: 30.0,
                        onPressed: () {
                          print('edit');
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: height * 0.35,
                child: Container(
                  width: width,
                  child: Column(
                    children: [
                      Container(
                        width: width * 0.85,
                        decoration: BoxDecoration(
                          color: StyleConstants.white,
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Reggie',
                                style: StyleConstants.blackTitleText,
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Temperament: ',
                                    style: StyleConstants.blackDescriptionText,
                                  ),
                                  Text(
                                    'Chill',
                                    style:
                                        StyleConstants.blackThinDescriptionText,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Service Animal: ',
                                    style: StyleConstants.blackDescriptionText,
                                  ),
                                  Text(
                                    'No',
                                    style:
                                        StyleConstants.blackThinDescriptionText,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Additional Notes: ',
                                    style: StyleConstants.blackDescriptionText,
                                  ),
                                  Flexible(
                                    child: Text(
                                      'Eats a lot, likes cat food',
                                      style: StyleConstants
                                          .blackThinDescriptionText,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'View Recent Scans: ',
                                    style: StyleConstants.blackDescriptionText,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      print('See recent scans');
                                    },
                                    icon: Icon(Icons.place),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.07,
                      ),
                      Container(
                        width: width * 0.85,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, height * 0.01),
                          child: Text(
                            'Owner 1',
                            style: StyleConstants.whiteTitleText,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      createOwnerWidget(Owner(
                          name: 'Name',
                          phoneNumber: '1234567890',
                          email: 'owneremail@email.com',
                          address: '43 Wyndehaven Lakes Dr.')),
                      SizedBox(
                        height: height * 0.07,
                      ),
                      Container(
                        width: width * 0.85,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, height * 0.01),
                          child: Text(
                            'Owner 2',
                            style: StyleConstants.whiteTitleText,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      createOwnerWidget(Owner(
                          name: 'Name2',
                          phoneNumber: '1234567890',
                          email: 'owner2email@email.com',
                          address: '43 Wyndehaven Lakes Dr.asdfdafdsaf')),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget createOwnerWidget(Owner owner) {
    return Container(
      width: width * 0.85,
      //height: height * 0.15,
      decoration: BoxDecoration(
        color: StyleConstants.white,
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Container(
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                owner.name,
                style: StyleConstants.blackTitleTextSmall,
              ),
              SizedBox(
                height: height * 0.008,
              ),
              Text(
                owner.email,
                style: StyleConstants.blackDescriptionText,
              ),
              SizedBox(
                height: height * 0.008,
              ),
              Text(
                owner.phoneNumber,
                style: StyleConstants.blackDescriptionText,
              ),
              SizedBox(
                height: height * 0.008,
              ),
              Text(
                owner.address,
                style: StyleConstants.blackDescriptionText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
