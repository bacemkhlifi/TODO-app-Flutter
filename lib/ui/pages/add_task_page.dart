import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/controllers/task_controller.dart';
import 'package:todo/ui/pages/home_page.dart';
import 'package:todo/ui/theme.dart';

import '../../models/task.dart';
import '../widgets/button.dart';
import '../widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _startDate = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String _endDate = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();

  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String _selectedRepeat = 'None';
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];

  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add task',
          style: headingStyle,
        ),
        backgroundColor: context.theme.backgroundColor,
        elevation: 0,
        leading: IconButton(
            color: Get.isDarkMode ? primaryClr : darkGreyClr,
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 24,
            )),
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage('images/person.jpeg'),
            radius: 18,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InputField(
              title: 'Title',
              hint: "Enter title here",
              controller: _titleController,
            ),
            InputField(
              title: 'Note',
              hint: "Enter title Note",
              controller: _noteController,
            ),
            InputField(
              title: 'Date',
              hint: DateFormat.yMd().format(_selectedDate),
              widget: IconButton(
                  onPressed: () {
                    _getDateFromUser();
                  },
                  icon: const Icon(Icons.calendar_today_outlined,
                      color: Colors.grey)),
            ),
            Row(
              children: [
                Expanded(
                  child: InputField(
                    title: 'Start Date',
                    hint: _startDate,
                    widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(true);
                        },
                        icon: const Icon(Icons.alarm, color: Colors.grey)),
                  ),
                ),
                Expanded(
                  child: InputField(
                    title: 'End Date',
                    hint: _endDate,
                    widget: IconButton(
                        onPressed: () {_getTimeFromUser(false);},
                        icon: const Icon(Icons.alarm, color: Colors.grey)),
                  ),
                )
              ],
            ),
            InputField(
                title: 'Remind',
                hint: "$_selectedRemind mintes early",
                widget: DropdownButton(
                  dropdownColor: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(10),
                  items: remindList
                      .map<DropdownMenuItem<String>>(
                          (e) => DropdownMenuItem<String>(
                              value: e.toString(),
                              child: Text(
                                '$e',
                                style: Get.isDarkMode
                                    ? TextStyle(color: Colors.white)
                                    : TextStyle(color: Colors.grey),
                              )))
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRemind = int.parse(newValue!);
                    });
                  },
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: SubTitleStyle,
                  underline: Container(
                    height: 0,
                  ),
                )),
            InputField(
                title: 'Repeat',
                hint: "$_selectedRepeat",
                widget: DropdownButton(
                  dropdownColor: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(10),
                  items: repeatList
                      .map<DropdownMenuItem<String>>(
                          (e) => DropdownMenuItem<String>(
                              value: e.toString(),
                              child: Text(
                                '$e',
                                style: Get.isDarkMode
                                    ? TextStyle(color: Colors.white)
                                    : TextStyle(color: Colors.grey),
                              )))
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRepeat = newValue!;
                    });
                  },
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: SubTitleStyle,
                  underline: Container(
                    height: 0,
                  ),
                )),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _colorPalette(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyButton(
                      label: 'Create Task',
                      onTap: () {
                        _validateDate();
                      }),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Column _colorPalette() {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              'Color',
              style: titleStyle,
            )),
        const SizedBox(
          height: 10,
        ),
        Wrap(
            children: List.generate(
          3,
          (index) => GestureDetector(
            onTap: () {
              setState(() {
                _selectedColor = index;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: CircleAvatar(
                child: _selectedColor == index
                    ? Icon(Icons.done, color: Colors.white, size: 16)
                    : null,
                backgroundColor: index == 0
                    ? primaryClr
                    : index == 1
                        ? pinkClr
                        : orangeClr,
                radius: 14,
              ),
            ),
          ),
        ))
      ],
    );
  }

  _validateDate() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTaskToDb();
      Get.to(HomePage());
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar('required', '',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: Colors.pink,
          icon: const Icon(
            Icons.warning_amber_outlined,
            color: Colors.red,
          ));
    }
  }

  _addTaskToDb() async {
   await _taskController.addTask(
        task: Task(
            title: _titleController.text,
            note: _noteController.text,
            isCompleted: 0,
            date: DateFormat.yMd().format(_selectedDate),
            startTime: _startDate,
            endTime: _endDate,
            color: _selectedColor,
            remind: _selectedRemind,
            repeat: _selectedRepeat));

    print('done');
  }

  _getTimeFromUser(bool isStartTime) async{
 TimeOfDay? _pickedTime = await showTimePicker(context: context, initialTime: isStartTime?TimeOfDay.fromDateTime(DateTime.now())
        :TimeOfDay.fromDateTime(DateTime.now().add(const Duration(minutes: 15))));
       
       String _formattedTime = _pickedTime!.format(context);
    if (isStartTime) {
      setState(() {
      _startDate = _formattedTime;
      });
    } else  if (!isStartTime) {
      setState(() {
      _endDate = _formattedTime;
      });
    }
    else {
      print('something wrong');
    }
  }


  _getDateFromUser() async {
    DateTime? _pickedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2021),
        lastDate: DateTime(2030));
    if (_pickedDate != null) {
      setState(() {
        _selectedDate = _pickedDate;
      });
    }
  }
}
