import 'package:flutter/material.dart';
import 'package:petcode_app/models/UpcomingEvent.dart';
import 'package:petcode_app/providers/all_pets_provider.dart';
import 'package:petcode_app/providers/notifications_provider.dart';
import 'package:petcode_app/screens/dashboard/dashboard_screen/glowing_reminder_widget.dart';
import 'package:petcode_app/screens/dashboard/dashboard_screen/reminder_widget.dart';
import 'package:petcode_app/screens/dashboard/reminders/reminders_screen.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';

class UpcomingEventsWidget extends StatefulWidget {
  @override
  _UpcomingEventsWidgetState createState() => _UpcomingEventsWidgetState();
}

class _UpcomingEventsWidgetState extends State<UpcomingEventsWidget> {
  @override
  Widget build(BuildContext context) {
    double height = StyleConstants.height;
    double width = StyleConstants.width;

    AllPetsProvider allPetsProvider = Provider.of<AllPetsProvider>(context);
    List<UpcomingEvent> allPetUpcomingEvents =
        allPetsProvider.getAllPetReminders();

    NotificationsProvider notificationsProvider =
        Provider.of<NotificationsProvider>(context);

    int reminderIndex = -1;
    if (notificationsProvider.currentAction == 'reminder expired') {
      reminderIndex = int.tryParse(notificationsProvider.params);
    }

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: height * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'Upcoming',
              style: StyleConstants.blackThinTitleTextMedium.copyWith(
                  fontWeight: FontWeight.bold, fontSize: width * 0.055),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          allPetUpcomingEvents.length == 0
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 6.0,
                              offset: Offset(0, 3),
                            ),
                          ]),
                      height: height * 0.2,
                      width: width * 0.7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'You have no upcoming',
                            style: TextStyle(
                                color: StyleConstants.lightBlack,
                                fontWeight: FontWeight.w400,
                                fontSize: 20.0),
                          ),
                          Text(
                            'events scheduled',
                            style: TextStyle(
                                color: StyleConstants.lightBlack,
                                fontWeight: FontWeight.w400,
                                fontSize: 20.0),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (_) => RemindersScreen())),
                            child: Container(
                                height: height * 0.05,
                                width: width * 0.35,
                                decoration: BoxDecoration(
                                    color: StyleConstants.blue,
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 6.0,
                                        color: Colors.black.withOpacity(0.2),
                                        offset: Offset(0, 3),
                                      )
                                    ]),
                                child: Center(
                                    child: Text(
                                  'Schedule',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500),
                                ))),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.1,
                    ),
                  ],
                )
              : remindersList(
                  allPetUpcomingEvents, reminderIndex, width, height),
        ],
      ),
    );
  }

  Widget remindersList(List<UpcomingEvent> allPetUpcomingEvents,
      int reminderIndex, double width, double height) {
    List<Widget> reminderWidgets = <Widget>[];
    for (int i = 0; i < allPetUpcomingEvents.length; i++) {
      if (i == reminderIndex) {
        reminderWidgets.add(
          Padding(
            padding: EdgeInsets.fromLTRB(
                width * 0.012, 0, width * 0.012, height * 0.024),
            child: GlowingReminderWidget(
              completed: false,
              name: allPetUpcomingEvents[i].name,
              date: allPetUpcomingEvents[i].date != null
                  ? allPetUpcomingEvents[i].date.toDate()
                  : null,
            ),
          ),
        );
      } else {
        reminderWidgets.add(
          Padding(
            padding: EdgeInsets.fromLTRB(
                width * 0.012, 0, width * 0.012, height * 0.024),
            child: ReminderWidget(
              completed: false,
              name: allPetUpcomingEvents[i].name,
              date: allPetUpcomingEvents[i].date != null
                  ? allPetUpcomingEvents[i].date.toDate()
                  : null,
            ),
          ),
        );
      }
    }
    return Container(
      width: width,
      child: Column(
        children: reminderWidgets,
        mainAxisSize: MainAxisSize.min,
      ),
    );
  }
}
