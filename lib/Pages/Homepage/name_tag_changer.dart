import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Controller/Providers/name_tag_provider.dart';

class NameTagChanger extends StatelessWidget {
  const NameTagChanger({Key? key}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    final TextEditingController textcontroller = TextEditingController();
    String picSelected = context.read<NameTagNotifer>().pic;
    return AlertDialog(
      title: const Text('Profile'),
      content: SingleChildScrollView(
        child: ListBody(children: [
          StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Stack(alignment: Alignment.center, children: [
                      GestureDetector(
                        onTap: () => setState(() {
                          picSelected = 'girl';
                        }),
                        child: const CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/ProfilePic/girl.jpg'),
                          radius: 40,
                        ),
                      ),
                      picSelected == 'girl'
                          ? Positioned(
                              right: 18,
                              bottom: 0,
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue,
                                ),
                                child: const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : Container()
                    ])),
                Expanded(
                    flex: 1,
                    child: Stack(alignment: Alignment.center, children: [
                      GestureDetector(
                        onTap: () => setState(() {
                          picSelected = 'boy';
                        }),
                        child: const CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/ProfilePic/boy.jpg'),
                          radius: 40,
                        ),
                      ),
                      picSelected == 'boy'
                          ? Positioned(
                              right: 18,
                              bottom: 0,
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue,
                                ),
                                child: const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : Container()
                    ])),
              ],
            );
          }),
          const SizedBox(height: 20),
          TextField(
            controller: textcontroller,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.teal),
                    borderRadius: BorderRadius.circular(50)),
                labelText: 'Name'),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () => {
                    context.read<NameTagNotifer>().setPic(picSelected),
                        context
                            .read<NameTagNotifer>()
                            .setname(textcontroller.text),
                        Navigator.pop(context)
                      },
                  child: const Text('Save'))
            ],
          )
        ]),
      ),
    );
  }
}
