import 'package:cinema_booking_ui_flutter/config/constant.dart';
import 'package:cinema_booking_ui_flutter/entities/seats.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReservationScreen extends StatelessWidget {
  const ReservationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text("data", style: TextStyle(color: white)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: const Column(children: [
        _Seats(),
        SizedBox(height: 30),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          _StatusSeats(
            status: Colors.grey,
            text: "available",
          ),
          SizedBox(width: 20),
          _StatusSeats(
            status: orange,
            text: "selected",
          ),
          SizedBox(width: 20),
          _StatusSeats(
            status: white,
            text: "reserved",
          ),
        ]),
        Spacer(),
        _FormDateAndTime()
      ]),
    );
  }
}

class _FormDateAndTime extends StatefulWidget {
  const _FormDateAndTime();

  @override
  State<_FormDateAndTime> createState() => _FormDateAndTimeState();
}

class _FormDateAndTimeState extends State<_FormDateAndTime> {
  final items = List<DateTime>.generate(15, (index) {
    return DateTime.utc(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    ).add(Duration(days: index));
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40),
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40),
        ),
        gradient: LinearGradient(
          colors: [black, grey],
          stops: [0.5, 1],
          begin: FractionalOffset.bottomCenter,
          end: FractionalOffset.topCenter,
        ),
        // border: Border.all(color: white),
      ),
      child: Column(children: [
        const Text(
          "Select Date and Time",
          style: TextStyle(
              fontSize: 17, color: white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 40),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: [
            ...List.generate(items.length, (index) {
              final item = items[index];
              return Container(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 5),
                margin: const EdgeInsets.only(left: 24),
                decoration: BoxDecoration(
                  color: orange,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Column(children: [
                  Text(DateFormat('MMM').format(item)),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      // borderRadius: BorderRadius.all(Radius.circular(20)),
                      shape: BoxShape.circle,
                      color: white,
                    ),
                    child: Text(DateFormat('dd').format(item)),
                  ),
                ]),
              );
            }),
            const SizedBox(width: 25),
          ]),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: [
            ...List.generate(availableTime.length, (index) {
              final time = availableTime[index];

              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 17, vertical: 15),
                margin: const EdgeInsets.only(top: 20, left: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: white),
                  color: Colors.transparent,
                ),
                child: Text(time, style: const TextStyle(color: white)),
              );
            }),
          ]),
        )
      ]),
    );
  }
}

class _StatusSeats extends StatelessWidget {
  final Color status;
  final String text;
  const _StatusSeats({required this.status, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
        width: 15,
        height: 15,
        decoration: BoxDecoration(
          color: status,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      const SizedBox(width: 10),
      Text(text, style: const TextStyle(color: white))
    ]);
  }
}

class _Seats extends StatefulWidget {
  const _Seats();

  @override
  State<_Seats> createState() => _SeatsState();
}

class _SeatsState extends State<_Seats> {
  List<String> selectedSeats = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(numRow.length, (colIndex) {
          final numSeats =
              (colIndex == 0 || numRow.length - 1 == colIndex) ? 6 : 8;

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(numSeats, (rowIndex) {
                final viewSeats = numSeats / 2 == rowIndex + 1;
                final positionSeat = '${numRow[colIndex]}${rowIndex + 1}';
                final checkSeats = reservedSeats.contains(positionSeat);
                final checkSelectedSeats = selectedSeats.contains(positionSeat);

                return GestureDetector(
                  onTap: () {
                    if (checkSeats) return;

                    setState(() {
                      final checkExists =
                          selectedSeats.indexWhere((e) => e == positionSeat);

                      if (checkExists == -1) {
                        selectedSeats = [...selectedSeats, positionSeat];
                      } else {
                        selectedSeats = selectedSeats
                            .where((e) => e != positionSeat)
                            .toList();
                      }
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        left: rowIndex == 0 ? 10 : 0,
                        right: viewSeats ? 30 : 10,
                        bottom: 10),
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      color: checkSelectedSeats
                          ? orange
                          : checkSeats
                              ? white
                              : Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              })
            ],
          );
        })
      ],
    );
  }
}

class Clip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width / 2, -20, size.width, size.height);
    path.lineTo(size.width, size.height - 5);
    path.quadraticBezierTo(size.width / 2, -25, 0, size.height - 5);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class Clip2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height - 30);
    path.quadraticBezierTo(size.width / 2, -20, 0, size.height - 30);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
