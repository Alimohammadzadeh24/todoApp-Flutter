import 'package:flutter/material.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:note_application/Theme/Color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            height: 132,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MSHCheckbox(
                              size: 24,
                              value: isChecked,
                              colorConfig:
                                  MSHColorConfig.fromCheckedUncheckedDisabled(
                                checkedColor: greenColor,
                              ),
                              style: MSHCheckboxStyle.fillScaleCheck,
                              onChanged: (selected) {
                                setState(() {
                                  isChecked = selected;
                                });
                              },
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'باید برم بیدل با سعید',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text('راجب آنلاین شاپ صحبت کنیم'),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 83,
                              height: 28,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(17),
                                  color: greenColor),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      '10:00',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: Image.asset(
                                          'assets/images/icon_time.png'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Container(
                              width: 83,
                              height: 28,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(17),
                                color: lightGreenColor,
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'ویرایش',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: greenColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Image.asset('assets/images/icon_edit.png'),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  Image.asset('assets/images/workout.png'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
