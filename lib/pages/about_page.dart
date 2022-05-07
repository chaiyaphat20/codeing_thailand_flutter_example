import 'dart:ui';

import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('เกี่ยวกับ'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/images/building.png'),
              SafeArea(
                  child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "PEA UbonRatchathani",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    const Divider(),
                    const Text(
                        "ชอบบรรยากาศ แห่งการได้ร่ำเมรัย ร่วมวงกับเพื่อนรู้ใจ จะหาสุขใดไม่มีเปรียบปาน เลิศรสบรั่นดี น้ำแข็งโซดาเคล้าอารมณ์รันก็เปิดประตูสวรรค์ ชั้นโสดาบันแห่งวันเมา ๆ"),
                    const Divider(),
                    Row(
                      children: [
                        const Expanded(
                            flex: 1,
                            child: Icon(
                              Icons.sunny,
                              color: Colors.orange,
                            )),
                        Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "chaipat@gmail.com",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange),
                                ),
                                Text(
                                    "31หมู่10 บ้าน นาจา ต.นาคำ อ.นาดี อ.นาดำ จ.นาจารณย์ 222222")
                              ],
                            ))
                      ],
                    ),
                    const Divider(),
                    Wrap(
                      spacing: 4,
                      children: List.generate(
                          20,
                          (index) => Chip(
                                label: Text('${index + 1}'),
                                avatar: const Icon(Icons.ac_unit_sharp),
                                backgroundColor: Colors.green[200],
                              )),
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CircleAvatar(
                          backgroundImage: AssetImage('assets/images/me.png'),
                          radius: 40,
                        ),
                        const CircleAvatar(
                          backgroundImage: AssetImage('assets/images/me.png'),
                          radius: 40,
                        ),
                        const CircleAvatar(
                          backgroundImage: AssetImage('assets/images/me.png'),
                          radius: 40,
                        ),
                        SizedBox(
                          width: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Icon(Icons.ac_unit_rounded),
                              Icon(Icons.access_alarm_sharp),
                              Icon(Icons.dangerous)
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ))
            ],
          ),
        ));
  }
}
