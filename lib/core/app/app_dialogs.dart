import 'package:flutter/material.dart';

class AppDialogs {
  static Future<void> submitPhoneDialog({
    required BuildContext context,
    required String phoneNumber,
    required VoidCallback okPressed,
  }) {
    return showMyDialog(
      context: context,
      actionSpacer: true,
      borderRadius: 3,
      contentPadding: const EdgeInsets.only(top: 20, right: 20, left: 20),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("You entered the phone number:"),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              phoneNumber,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.blue),
            ),
          ),
          const Text("Is this OK, or would you like to edit the number?"),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            "Edit",
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          onPressed: okPressed,
          child: Text(
            "Ok",
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  static Future<void> showCustomDialog(
      {required BuildContext context,
      required IconData icons,
      required String title,
      required String content,
      required VoidCallback onPressed}) async {
    return showMyDialog(
      context: context,
      contentPadding: const EdgeInsets.all(15),
      borderRadius: 15,
      barrierDismissible: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icons,
            color: Colors.black,
            size: 100,
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.black),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .subtitle1
                ?.copyWith(color: Colors.black.withOpacity(0.5)),
          ),
          Container(
            margin: const EdgeInsets.only(top: 15),
            width: MediaQuery.of(context).size.height * 0.35,
            height: 45,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
            child: TextButton(
                onPressed: onPressed,
                child: const Text(
                  "Ok",
                )),
          )
        ],
      ),
    );
  }
}

Future<void> showMyDialog(
    {required BuildContext context,
    bool barrierDismissible = false,
    double borderRadius = 0,
    EdgeInsetsGeometry? contentPadding,
    required Widget content,
    List<Widget>? actions,
    bool actionSpacer = false,
    EdgeInsetsGeometry? actionsPadding}) async {
  return showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    // if condition false, user must tap button!
    builder: (context) {
      return AlertDialog(
        contentPadding: contentPadding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
        content: content,
        actionsPadding: actionsPadding,
        actions: actions,
        actionsAlignment: actionSpacer ? MainAxisAlignment.spaceBetween : MainAxisAlignment.end,
      );
    },
  );
}
