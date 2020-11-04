import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:petcode_app/providers/all_pets_provider.dart';
import 'package:petcode_app/providers/provider_state.dart';
import 'package:petcode_app/screens/dashboard/dashboard_screen/header_circle_painter.dart';
import 'package:petcode_app/screens/dashboard/dashboard_screen/navigation_row.dart';
import 'package:petcode_app/screens/dashboard/dashboard_screen/no_pets_indicator.dart';
import 'package:petcode_app/screens/dashboard/dashboard_screen/pets_carousel_widget.dart';
import 'package:petcode_app/screens/dashboard/dashboard_screen/upcoming_events_widget.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = StyleConstants.height;
    double width = StyleConstants.width;

    AllPetsProvider allPetsProvider = Provider.of<AllPetsProvider>(context);

    if (allPetsProvider.allPets == null) {
      return Scaffold(
        body: Center(
          child: SpinKitDualRing(size: 30.0, color: StyleConstants.yellow),
        ),
      );
    } else if (allPetsProvider.allPets.length == 0 &&
        allPetsProvider.providerState == ProviderState.Idle) {
      return Scaffold(
        body: NoPetsAvailableIndicator(),
      );
    } else {
      return Scaffold(
        backgroundColor: StyleConstants.blue,
        body: SingleChildScrollView(
          child: Container(
            width: width,
            decoration: BoxDecoration(
                //gradient: StyleConstants.bgGradient,
                ),
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: height * 0.13,
                      width: width,
                      child: Stack(
                        children: [
                          Positioned(
                              top: height * 0.08,
                              left: width * 0.08,
                              child: Text(
                                'Dashboard',
                                style: StyleConstants.whiteThinTitleText,
                              )),
                          CustomPaint(
                            painter: HeaderCirclePainter(),
                            child: Container(),
                          ),
                          Positioned(
                            top: height * 0.055,
                            right: width * 0.06,
                            child: Image.asset(
                              'assets/images/onboarding/pawlogohighres.png',
                              fit: BoxFit.cover,
                              width: width * 0.15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0))),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: height * 0.02,
                            ),
                            PetsCarouselWidget(),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: NavigationRow(),
                            ),
                            Flexible(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomRight,
                                    end: Alignment.topLeft,
                                    colors: [
                                      const Color(0xffB3E1EE),
                                      Colors.white
                                    ],
                                    stops: [0.05, 0.95],
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.035),
                                      child: UpcomingEventsWidget(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}