import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/ui/size_config.dart';
import 'package:todo/ui/theme.dart';

class InputField extends StatelessWidget {
  const InputField(
      {Key? key,
      required this.title,
      required this.hint,
      this.controller,
      this.widget})
      : super(key: key);

  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
        
      margin: const EdgeInsets.only(left:14),  
      child: Container(
        padding:const EdgeInsets.all( 8),
        
        width: SizeConfig.screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,style: titleStyle,),
            const SizedBox(height: 5,),
            Container(
              padding:const EdgeInsets.only(left:14),
              margin: const EdgeInsets.only(top: 8),
              width: SizeConfig.screenWidth,
              height: 52,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),//color: primaryClr,
                border: Border.all(
                  color: Colors.grey
                )
              ),
              child: Row(
                    children: [
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(left:8.0,right: 6),
                        child: TextFormField(
                          readOnly: widget != null ? true:false,
                          style: SubTitleStyle,
                          cursorColor: Get.isDarkMode?Colors.grey[100]:Colors.grey[300],
                          controller: controller,
                          autofocus: false,
                          decoration: InputDecoration(
                            hintText: hint,
                            hintStyle: SubTitleStyle,
                            enabledBorder: UnderlineInputBorder(borderSide:  BorderSide(color: Theme.of(context).backgroundColor ,width: 0),),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color:context.theme.backgroundColor
                              )
                            )
                            
                          ),
                        ),
                      )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:8.0),
                        child: widget?? Container(),
                      ),
                    ],
                  ),
              
             
            ),
          ],
        ),
      ),
    );
  }
}
