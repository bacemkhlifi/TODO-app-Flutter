import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme.dart';


class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key, required this.paylod}) : super(key: key);
  final String paylod;

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _paylod = '';
  @override
  void initState() {
    super.initState();
    _paylod = widget.paylod;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back)),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          _paylod.toString().split('|')[0],
          style: TextStyle(color: Get.isDarkMode ? Colors.white : darkGreyClr),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Hello, Bacem',
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: Get.isDarkMode ? Colors.white : darkGreyClr),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'You have a new reminder',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color:
                            Get.isDarkMode ? Colors.grey[300] : darkHeaderClr),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                  child: Container(
                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                margin: const EdgeInsets.only(left: 30.0, right: 30.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30), color: primaryClr),
                child: SingleChildScrollView(
                  
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Row(
                            children: [
                              Icon(
                                Icons.text_format,
                                size: 30,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Title',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 30),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                              child: Text(_paylod.toString().split('|')[0],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)))
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.description,
                                size: 30,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Description',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 30),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            _paylod.toString().split('|')[1],
                            style: TextStyle(color: Colors.white, fontSize: 20),
                            textAlign: TextAlign.justify,
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.date_range_outlined,
                                size: 30,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Date',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 30),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            _paylod.toString().split('|')[2],
                            style: TextStyle(color: Colors.white, fontSize: 20),
                            textAlign: TextAlign.justify,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
