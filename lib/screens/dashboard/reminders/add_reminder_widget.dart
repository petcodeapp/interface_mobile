import 'package:flutter/material.dart';
import 'package:petcode_app/utils/string_helper.dart';
import 'package:petcode_app/utils/style_constants.dart';

class AddReminderWidget extends StatefulWidget {
  @override
  _AddReminderWidgetState createState() => _AddReminderWidgetState();
}

class _AddReminderWidgetState extends State<AddReminderWidget> {
  TextEditingController _reminderNameController;
  TextEditingController _reminderStartDateController;
  TextEditingController _reminderEndDateController;

  String _repeatValue;

  DateTime _reminderStartDate;
  DateTime _reminderEndDate;

  @override
  void initState() {
    _reminderNameController = new TextEditingController();
    _reminderStartDateController = new TextEditingController();
    _reminderEndDateController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(
        left: width * 0.1,
        right: width * 0.1,
        top: height * 0.03,
        bottom: height * 0.02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width * 0.9,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add a New Reminder',
                    style: StyleConstants.blackThinTitleTextMedium,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text('Name', style: StyleConstants.blackThinTitleTextXS),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Name',
                      hintStyle: TextStyle(fontSize: 14.0),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text('When', style: StyleConstants.blackThinTitleTextXS),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    controller: _reminderStartDateController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Start Date',
                      hintStyle: TextStyle(fontSize: 14.0),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    onTap: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2019),
                              lastDate: DateTime(2050))
                          .then((DateTime selectedDate) {
                        setState(() {
                          _reminderStartDateController =
                              new TextEditingController(
                                  text: StringHelper.getDateStringNoYear(
                                      selectedDate));
                          _reminderStartDate = selectedDate;
                        });
                      });
                    },
                    readOnly: true,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text('Repeat', style: StyleConstants.blackThinTitleTextXS),
                  SizedBox(
                    height: 8.0,
                  ),
                  Container(
                    height: height * 0.076,
                    width: width * 0.9 - 16,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                      child: DropdownButton<String>(
                          value: _repeatValue ?? 'Never',
                          underline: SizedBox.shrink(),
                          isExpanded: true,
                          items: <String>[
                            'Never',
                            'Daily',
                            'Weekly',
                            'Monthly',
                            'Yearly'
                          ].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: (String value) {
                            setState(() {
                              _repeatValue = value;
                            });
                          }),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text('Until', style: StyleConstants.blackThinTitleTextXS),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    controller: _reminderEndDateController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'End Date',
                      hintStyle: TextStyle(fontSize: 14.0),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    onTap: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2019),
                              lastDate: DateTime(2021))
                          .then((DateTime selectedDate) {
                        setState(() {
                          _reminderEndDateController =
                              new TextEditingController(
                                  text: StringHelper.getDateStringNoYear(
                                      selectedDate));
                          _reminderEndDate = selectedDate;
                        });
                      });
                    },
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        decoration: BoxDecoration(
                          color: StyleConstants.blue,
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        height: height * 0.06,
                        width: width * 0.5,
                        child: Center(
                            child: Text(
                          'Set Reminder',
                          style: StyleConstants.whiteThinTitleTextSmall,
                        )),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
