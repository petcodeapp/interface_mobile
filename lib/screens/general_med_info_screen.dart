import 'package:flutter/material.dart';
import 'package:petcode_app/utils/hero_icons.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/widgets/change_pet_app_bar.dart';

class GeneralMedicalInfoScreen extends StatefulWidget {
  @override
  _GeneralMedicalInfoScreenState createState() => _GeneralMedicalInfoScreenState();
}

class _GeneralMedicalInfoScreenState extends State<GeneralMedicalInfoScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: ChangePetAppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.edit),
              color: Colors.white,
              iconSize: 30.0,
              onPressed: () {}
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.04,
              ),
              /*
              CircleAvatar(
                backgroundImage:  petService.petImages[widget.petIndex],
                radius: 60.0,
              ),*/

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text('Special Needs', style: StyleConstants.tinyGreyDescriptionText,),
              ),
              SizedBox(height: 10.0,),
              ListTile(
                leading: Icon(
                  HeroIcons.icon_user,
                  size: 30.0,
                ),
                title: Row(
                  children: [
                    Text('Heat Sensitivity, Depressed',style: StyleConstants.darkBlackDescriptionText) ??
                        Text(
                          'Special Needs',
                          style: StyleConstants.greyedOutText,
                        ),
                  ],
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 25.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Divider(
                  thickness: 2,
                ),
              ),

              SizedBox(height: 15.0,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text('Allergies', style: StyleConstants.tinyGreyDescriptionText,),
              ),
              SizedBox(height: 10.0,),
              ListTile(
                leading: Icon(
                  HeroIcons.icon_user,
                  size: 30.0,
                ),
                title: Row(
                  children: [
                    Text('Wheat',style: StyleConstants.darkBlackDescriptionText) ??
                        Text(
                          'Allergies',
                          style: StyleConstants.greyedOutText,
                        ),
                  ],
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 25.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Divider(
                  thickness: 2,
                ),
              ),

              SizedBox(height: 15.0,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text('Veterinarian Name', style: StyleConstants.tinyGreyDescriptionText,),
              ),
              SizedBox(height: 10.0,),
              ListTile(
                leading: Icon(
                  HeroIcons.icon_user,
                  size: 30.0,
                ),
                title: Row(
                  children: [
                    Text('Dr. Vet',style: StyleConstants.darkBlackDescriptionText) ??
                        Text(
                          'Veterinarian Name',
                          style: StyleConstants.greyedOutText,
                        ),
                  ],
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 25.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Divider(
                  thickness: 2,
                ),
              ),

              SizedBox(height: 15.0,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text('Veterinarian Phone Number', style: StyleConstants.tinyGreyDescriptionText,),
              ),
              SizedBox(height: 10.0,),
              ListTile(
                leading: Icon(
                  HeroIcons.icon_user,
                  size: 30.0,
                ),
                title: Row(
                  children: [
                    Text('650-772-9745',style: StyleConstants.darkBlackDescriptionText) ??
                        Text(
                          'Veterinarian Phone Number',
                          style: StyleConstants.greyedOutText,
                        ),
                  ],
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 25.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Divider(
                  thickness: 2,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
