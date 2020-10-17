import 'package:flutter/material.dart';
import 'package:petcode_app/models/Reminder.dart';
import 'package:petcode_app/providers/current_pet_provider.dart';
import 'package:petcode_app/screens/dashboard/reminders/add_reminder_widget.dart';
import 'package:petcode_app/screens/dashboard/reminders/reminder_widget.dart';
import 'package:petcode_app/utils/hero_icons2.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/widgets/change_pet_dropdown.dart';
import 'package:provider/provider.dart';

class RemindersScreen extends StatelessWidget {
  void _addReminder(BuildContext context, double height) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0)),
        ),
        builder: (BuildContext context) {
          return Container(
            height: height * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
            ),
            child: AddReminderWidget(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    CurrentPetProvider currentPetProvider =
        Provider.of<CurrentPetProvider>(context);
    List<Reminder> allReminders = currentPetProvider.currentPet.reminders;

    allReminders.sort((Reminder reminderA, Reminder reminderB) {
      if (reminderA.startDate == null) {
        return -1;
      } else if (reminderB.startDate == null) {
        return 1;
      } else {
        return reminderA.startDate.compareTo(reminderB.startDate);
      }
    });

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: StyleConstants.blue,
        onPressed: () => _addReminder(context, height),
      ),
      backgroundColor: StyleConstants.blue,
      body: Container(
        height: height,
        decoration: BoxDecoration(
          gradient: StyleConstants.bgGradient,
        ),
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: height * 0.15,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.1, vertical: height * 0.02),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ChangePetDropdown(),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: IconButton(
                          icon: Icon(HeroIcons2.left_arrow_1, size: 25.0, color: Colors.white,),
                          onPressed: () => Navigator.pop(context),
                        ),
                      )
                    ],
                  )
              ),
            ),
            Expanded(
              child: Container(
                height: height * 0.5,
                width: width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0))),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                  child: ListView.builder(
                    itemCount: allReminders.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          ReminderWidget(
                            currentReminder: allReminders[index],
                          ),
                          SizedBox(
                            height: height * 0.02,
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),


            )
          ],
        ),
      ),
    );
  }
}
