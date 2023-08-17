
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samurai_app/components/anim_button.dart';

import 'bg.dart';

Future<void> showError(BuildContext context, dynamic err, {int type = 0}) async {
  await showDialog(
    context: context,
    builder: (context) => ErrorDialog(err.toString(), type),
  );
}

class ErrorDialog extends StatelessWidget {

  const ErrorDialog(this.err, this.type, {super.key});
  final String err;
  final int type;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    precacheImage(backgroundDialog, context);
    final fSz = height * (type == 0 ? 0.021 : 0.0167);
    //final hCont = height * (err.toString().length < 25 ? 0.2 : 0.36);

    /*final lines = (fSz * err.toString().length ~/ (width - width * 0.2) + 1);
    final hCont = lines * fSz * 1.25 + height * 0.17;
    //print("fSz=$fSz lines=$lines len=${err.toString().length} width=$width hCont=$hCont");*/

    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: err.toString(), style: GoogleFonts.spaceMono(
          fontSize: fSz,
          color: type == 0 ? const Color(0xFFFF0049) : Colors.white
      )),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout(minWidth: 0, maxWidth: double.infinity);
    int countLines = (textPainter.size.width / (width - width * 0.2)).ceil();
    countLines += (RegExp(r'[\n]')).allMatches(err.toString()).length * 2;
    final heightText = countLines * textPainter.size.height;
    //print("heightText=$heightText lines=$countLines len=${err.toString().length} width=$width height=$height");
    final hCont = heightText + height * (type == 0 ? 0.236 : 0.188);

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: EdgeInsets.only(top: height * 0.25, bottom: height * 0.25, left: width * 0.02, right: width * 0.02),
      child: Container(
        height: hCont,
        width: width - width * 0.16,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: backgroundDialog,
            fit: BoxFit.fill
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: width * 0.04, right: width * 0.04, top: height * 0.04),
              height: hCont - height * 0.125,
              child: Text(err.toString(), style: GoogleFonts.spaceMono(
                fontSize: fSz,
                color: type == 0 ? const Color(0xFFFF0049) : Colors.white
              ), maxLines:10, softWrap: true)
            ),
            Container(
              padding: EdgeInsets.only(top: height * 0.00),
              height: height * 0.1,
              child: AnimButton(
                shadowType: 1,
                onTap: () {
                  Navigator.pop(context);
                },
                child: SvgPicture.asset(
                  'assets/pages/dialog/ok_btn.svg',
                  fit: BoxFit.fitWidth,
                ),
              )
            )
          ]
        )
      )
    );
  }

}

Future<void> showError0(BuildContext context, dynamic err) async {
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Error'),
      content: Text(err.toString()),
      actions: [
        Padding(
            padding: const EdgeInsets.only(top: 1.0, bottom: 0.0, left: 30.0, right: 0.0),
            child: SizedBox(
                height: 63,
                child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK', style: TextStyle(fontSize: 17, color: Colors.white)))))
      ],
    ),
  );
}