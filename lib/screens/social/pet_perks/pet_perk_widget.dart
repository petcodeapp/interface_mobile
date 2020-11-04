import 'package:petcode_app/models/PetPerk.dart';
import 'package:petcode_app/providers/notifications_provider.dart';
import 'package:petcode_app/screens/social/pet_perks/pet_perk_description_widget.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PetPerkWidget extends StatelessWidget {
  PetPerkWidget({Key key, this.updateProvider, this.petPerk}) : super(key: key);

  final bool updateProvider;
  final PetPerk petPerk;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        _showPetPerks(context, height, width, petPerk);
        if (updateProvider != null && updateProvider) {
          print('update');
          Provider.of<NotificationsProvider>(context, listen: false)
              .clearIndex();
        }
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        //height: height * 0.2,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 6.0,
                offset: Offset(0, 3),
              ),
            ]),
        child: Stack(
          children: [
            Positioned(
              right: -5.0,
              child: Container(
                // height: height * 0.2,
                //color: Colors.red,
                //width: height * 0.2,
                child: Stack(
                  children: [
                    Container(
                      height: height * 0.08,
                       //width: height * 0.08,
                        //color: Colors.blue,
                        child: Image.asset('assets/navigation_images/right_tag.png'),
                    ),
                    Positioned(
                        top: width * 0.045,
                        right: width * 0.018,
                        child: Container(
                            //color: Colors.blue,
                            child: Text(
                              '${petPerk.discountAmount}%',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20.0),
                            ))),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: height * 0.14,
                    width: height * 0.14,
                    decoration: BoxDecoration(
                      color: StyleConstants.yellow,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Center(
                      child: Container(
                          width: height * 0.12,
                          height: height * 0.12,
                          child: Image.asset('assets/images/petsmartlogo.png')),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: width * 0.6,
                        child: Text(
                          petPerk.storeName,
                          style: TextStyle(
                            color: StyleConstants.blue,
                            fontWeight: FontWeight.w600,
                            fontSize: 22.0,
                          ),
                        ),
                      ),
                      Container(
                        width: width * 0.6,
                        child: Text(
                          petPerk.description,
                          style: StyleConstants.blackThinDescriptionTextSmall
                              .copyWith(
                                  fontSize: 15.0,
                                  color: StyleConstants.grey,
                                  fontWeight: FontWeight.w500),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPetPerks(
      BuildContext context, double height, double width, PetPerk petPerk) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
      ),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: height * 0.6,
          child: PetPerkDescriptionWidget(
            currentPetPerk: petPerk,
          ),
        );
      },
    );
  }
}