import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() => runApp(CurrentMonthAppointments());

class CurrentMonthAppointments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ScheduleExample();
}

class ScheduleExample extends State<MyApp> {
  CalendarDataSource _dataSource;

  List<Appointment> _currentMonthAppointments;

  @override
  void initState() {
    _dataSource = _getCalendarDataSource();
    _currentMonthAppointments = <Appointment>[];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          RaisedButton(
            child: Text('Get current month appointment details'),
            onPressed: _showDialog,
          ),
          Expanded(
            child: Scrollbar(
              child: SfCalendar(
                view: CalendarView.month,
                dataSource: _dataSource,
                onViewChanged: viewChanged,
              ),
            ),
          ),
        ],
      ),
    ));
  }

  _AppointmentDataSource _getCalendarDataSource() {
    List<Appointment> appointmentDetails = <Appointment>[];

    appointmentDetails.add(Appointment(
        startTime: DateTime.now().add(Duration(days: 1)),
        endTime: DateTime.now().add(Duration(days: 1, hours: 1)),
        subject: 'Meeting',
        color: Colors.red,
        isAllDay: true));
    appointmentDetails.add(Appointment(
      startTime: DateTime.now().add(Duration(days: 2)),
      endTime: DateTime.now().add(Duration(days: 2, hours: 1)),
      subject: 'Planning',
      color: Colors.teal,
      startTimeZone: '',
      endTimeZone: '',
    ));
    appointmentDetails.add(Appointment(
      startTime: DateTime.now().add(Duration(days: 22)),
      endTime: DateTime.now().add(Duration(days: 22, hours: 1)),
      subject: 'General Meeting',
      color: Colors.teal,
    ));
    appointmentDetails.add(Appointment(
        startTime: DateTime.now().add(Duration(days: 1)),
        endTime: DateTime.now().add(Duration(days: 1, hours: 1)),
        subject: 'Plan Execution',
        color: Colors.cyan,
        isAllDay: true));
    appointmentDetails.add(Appointment(
      startTime: DateTime.now().add(Duration(days: 2)),
      endTime: DateTime.now().add(Duration(days: 2, hours: 1)),
      subject: 'Project Plan',
      color: Colors.tealAccent,
    ));
    appointmentDetails.add(Appointment(
      startTime: DateTime.now().add(Duration(days: 22)),
      endTime: DateTime.now().add(Duration(days: 22, hours: 1)),
      subject: 'Scrum',
      color: Colors.orangeAccent,
      startTimeZone: '',
      endTimeZone: '',
    ));
    appointmentDetails.add(Appointment(
        startTime: DateTime.now().add(Duration(days: 1)),
        endTime: DateTime.now().add(Duration(days: 1, hours: 1)),
        subject: 'Meeting',
        color: Colors.indigo,
        isAllDay: true));
    appointmentDetails.add(Appointment(
      startTime: DateTime.now().add(Duration(days: 2)),
      endTime: DateTime.now().add(Duration(days: 2, hours: 1)),
      subject: 'Support',
      color: Colors.red,
    ));
    appointmentDetails.add(Appointment(
      startTime: DateTime.now().add(Duration(days: 22)),
      endTime: DateTime.now().add(Duration(days: 22, hours: 1)),
      subject: 'Performance Check',
      color: Colors.teal,
    ));
    appointmentDetails.add(Appointment(
      startTime: DateTime.now().add(Duration(days: 22)),
      endTime: DateTime.now().add(Duration(days: 22, hours: 1)),
      subject: 'Project Completion',
      color: Colors.yellow,
    ));

    return _AppointmentDataSource(appointmentDetails);
  }

  void viewChanged(ViewChangedDetails viewChangedDetails) {
    _currentMonthAppointments = GetVisibleAppointments(viewChangedDetails
        .visibleDates[viewChangedDetails.visibleDates.length ~/ 2].month);
  }

  List<Appointment> GetVisibleAppointments(int visibleDates) {
    List<Appointment> visibleAppointment = <Appointment>[];
    for (int j = 0; j < _dataSource.appointments.length; j++) {
      if (visibleDates == _dataSource.appointments[j].startTime.month) {
        visibleAppointment.add(_dataSource.appointments[j]);
      }
    }
    return visibleAppointment;
  }

  _showDialog() async {
    await showDialog(
      context: context,
      // ignore: deprecated_member_use
      child: new AlertDialog(
        title: Container(
          child: Text("Visible dates contains " +
              _currentMonthAppointments.length.toString() +
              " appointments"),
        ),
        contentPadding: const EdgeInsets.all(16.0),
        content: ListView.builder(
            itemCount: _currentMonthAppointments.length,
            itemBuilder: (BuildContext context, int index) {
              return new Text(_currentMonthAppointments[index].subject);
            }),
        actions: <Widget>[
          new FlatButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
    );
  }

}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
