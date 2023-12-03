import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/ui/theme.dart';

import '../../models/task.dart';

class TaskTile extends StatelessWidget {
  const TaskTile(this.task, {Key? key}) : super(key: key);
  final Task task;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: _getBgClr(task.color)),
        child: Row(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title!,
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.access_time_filled_rounded,
                          color: Colors.grey[200],
                          size: 18,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text('${task.startTime} - ${task.endTime}')
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(task.note!)
                  ],
                ),
              ),
            )),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              width: 0.5,
              color: Colors.grey[200]!.withOpacity(0.7),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    task.isCompleted == 0 ? 'TODO' : 'Completed',
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  )),
            )
          ],
        ));
  }

  _getBgClr(int? color) {
    switch (color) {
      case 0:
        return bluishClr;

      case 1:
        return pinkClr;

      case 2:
        return orangeClr;

      default:
        return bluishClr;
    }
  }
}
