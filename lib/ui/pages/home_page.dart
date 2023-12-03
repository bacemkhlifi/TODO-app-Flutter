import 'dart:async';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo/controllers/task_controller.dart';
import 'package:todo/services/notification_services.dart';
import 'package:todo/services/theme_services.dart';
import 'package:todo/ui/pages/add_task_page.dart';
import 'package:todo/ui/pages/notification_screen.dart';
import 'package:todo/ui/size_config.dart';
import 'package:todo/ui/widgets/task_tile.dart';

import '../../models/task.dart';
import '../theme.dart';
import '../widgets/button.dart';
import '../widgets/input_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDated = DateTime.now();
  final TaskController _taskController = Get.put(TaskController());
  late Future<void> _initStateFuture;
@override
void initState() {
  super.initState();
  _initStateFuture = _initialize();
  
}

Future<void> _initialize() async {
  await _taskController.getTasks();
  print('Tasks loaded');
}


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    
    return Scaffold(
      appBar: _appBar(context),
      body: Column(
        children: [
          _addTaskBar(),
          _dateBar(),
          const SizedBox(
            height: 6,
          ),
       FutureBuilder(
            future: _initStateFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return _showTasks();
              } else {
                return CircularProgressIndicator();
              }
            },
          ),

        ],
      ),
    );
  }

   _noTaskMsg() {
    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: _onRefresh,
          child: SingleChildScrollView(
            child: Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 70.0),
                  child: SvgPicture.asset(
                    'images/task.svg',
                    color: primaryClr.withOpacity(0.5),
                    height: 90,
                    semanticsLabel: 'Task',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 20.0),
                  child: Text(
                    'You do not have any tasks yet! \nAdd new tasks to make your days productive.',
                    style: SubTitleStyle,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  _showTasks() {
    return Expanded(
      child: 
         GetBuilder<TaskController>(
          builder: (_) {
            if (_taskController.taskList.isEmpty) {
              return _noTaskMsg();
            } else {
              return RefreshIndicator(
                onRefresh: _onRefresh,
                child: Obx((){
                  return ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      var reversedIndex = _taskController.taskList.length - 1 - index;
                      var task = _taskController.taskList[reversedIndex];
                   //     NotifyHelper().displayNotification(Stringtitle: "test", body: "body");
                
                /* var date = DateFormat.jm().parse(task.startTime!);
                 var myTime = DateFormat('HH:mm').format(date);
                  var hour = myTime.toString().split(':')[0];
                 var minutes = myTime.toString().split(':')[1];
                NotifyHelper().schduleNotification(int.parse(hour),int.parse(minutes),task);*/
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: (){showBottomSheet(context,task);},
                          child: TaskTile(task)),
                      );
                    },
                    itemCount: _taskController.taskList.length,
                    scrollDirection: Axis.vertical,
                  );
                }
                
                   
                ),
              );
            }
          },
        ),
     
    );
  }


Future<void>_onRefresh()async{
  _taskController.getTasks();
}

  Container _dateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 6, left: 20),
      child: DatePicker(
        DateTime.now(),
        initialSelectedDate: DateTime.now(),
        width: 80,
        height: 100,
        selectionColor: primaryClr,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        dayTextStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
        monthTextStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
        onDateChange: (newDate) {
          setState(() {
            _selectedDated = newDate;
          });
        },
      ),
    );
  }

  Container _addTaskBar() {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: SubHeadingStyle,
              ),
              Text(
                'Today',
                style: headingStyle,
              )
            ],
          ),
          MyButton(
              label: '+ Add Task',
              onTap: () async {
                await Get.to(const AddTaskPage());
              }),
        ],
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text(
        '',
        style: headingStyle,
      ),
      backgroundColor: context.theme.backgroundColor,
      elevation: 0,
      leading: IconButton(
          color: Get.isDarkMode ? primaryClr : darkGreyClr,
          onPressed: () {
            ThemeServices().switchTheme();
          },
          icon: Icon(
            Get.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            size: 24,
          )),
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage('images/person.jpeg'),
          radius: 18,
        )
      ],
    );
  }

  _buildBottomSheet(
      {required String label,
      required Function() onTap,
      required Color clr,
      bool isClose = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 65,
        decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: isClose
                  ? Get.isDarkMode
                      ? Colors.grey[600]!
                      : Colors.grey[300]!
                  : clr,
            ),
            borderRadius: BorderRadius.circular(20),
            color: isClose ? Colors.transparent : clr),
        child: Center(
          child: Text(label,
              style: isClose
                  ? titleStyle
                  : titleStyle.copyWith(color: Colors.white)),
        ),
      ),
    );
  }

  showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(18.0),
        child: Column(
          children: [
            task.isCompleted == 1
                ? Container()
                : _buildBottomSheet(
                    label: 'Complete Task',
                    onTap: () async{
                    _taskController.markTaskCompleted(task.id!);
                    Get.back();
                    },
                    clr: primaryClr),
            Divider(
              color: Colors.grey,
            ),
            _buildBottomSheet(
                label: 'Delete Task ',
                onTap: () {
                 _taskController.deleteTasks(task);
                  Get.back();
                },
                clr: primaryClr),
            Divider(
              color: Colors.grey,
            ),
            _buildBottomSheet(
                label: 'Cancel',
                onTap: () {
                  Get.back();
                },
                clr: primaryClr),
          ],
        ),
      ),
    ));
  }
}
