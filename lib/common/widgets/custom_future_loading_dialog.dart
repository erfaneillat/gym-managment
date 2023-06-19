import 'dart:async';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:manage_gym/common/extensions/context.dart';

Future<LoadingDialogResult<T>> showCustomFutureLoadingDialog<T>(
    {required BuildContext context,
    required Future<T> Function() future,
    String? title,
    String? backLabel,
    String Function(dynamic exception)? onError,
    bool barrierDismissible = false,
    Function()? then}) async {
  final dialog = LoadingDialog<T>(
    future: future,
    title: title,
    backLabel: backLabel,
    onError: onError,
    then: then,
  );
  final result = dialog.isCupertinoStyle
      ? await showCupertinoDialog<LoadingDialogResult<T>>(
          barrierDismissible: barrierDismissible,
          context: context,
          builder: (BuildContext context) => dialog,
        )
      : await showDialog<LoadingDialogResult<T>>(
          context: context,
          barrierDismissible: barrierDismissible,
          builder: (BuildContext context) => dialog,
        );
  return result ??
      LoadingDialogResult<T>(
        error: Exception('FutureDialog canceled'),
        stackTrace: StackTrace.current,
      );
}

class LoadingDialog<T> extends StatefulWidget {
  final String? title;
  final String? backLabel;
  final Future<T> Function() future;
  final String Function(dynamic exception)? onError;
  final Function()? then;
  static String defaultTitle = '';
  static String defaultBackLabel = 'Back';
  // ignore: prefer_function_declarations_over_variables
  static String Function(dynamic exception) defaultOnError =
      (exception) => exception.toString();

  bool get isCupertinoStyle => !kIsWeb && Platform.isIOS;

  const LoadingDialog(
      {Key? key,
      required this.future,
      this.title,
      this.onError,
      this.backLabel,
      this.then})
      : super(key: key);
  @override
  _LoadingDialogState<T> createState() => _LoadingDialogState<T>();
}

class _LoadingDialogState<T> extends State<LoadingDialog> {
  dynamic exception;
  StackTrace? stackTrace;

  @override
  void initState() {
    super.initState();
    widget.future().then((result) {
      Navigator.of(context)
          .pop<LoadingDialogResult<T>>(LoadingDialogResult(result: result));
      onError:
      (e, s) => setState(() {
            exception = e;
            stackTrace = s;
          });
      widget.then != null ? widget.then!() : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final titleLabel = exception != null
        ? widget.onError?.call(exception) ??
            LoadingDialog.defaultOnError(exception)
        : widget.title ?? 'custom_loading_dialog_title'.tr();
    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: exception == null
              ? const CircularProgressIndicator.adaptive()
              : const Icon(
                  Icons.error_outline_outlined,
                  color: Colors.red,
                ),
        ),
        Expanded(
          child: Text(titleLabel.tr(),
              style: context.textTheme.headline6!
                  .copyWith(fontWeight: FontWeight.w500, fontSize: 17)),
        ),
      ],
    );

    if (widget.isCupertinoStyle) {
      return CupertinoAlertDialog(
        content: content,
        actions: [
          if (exception != null)
            CupertinoDialogAction(
              onPressed: Navigator.of(context).pop,
              child: Text(widget.backLabel ?? LoadingDialog.defaultBackLabel),
            )
        ],
      );
    }
    return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: content,
        actions: exception != null
            ? [
                TextButton(
                  onPressed: () =>
                      Navigator.of(context).pop<LoadingDialogResult<T>>(
                    LoadingDialogResult(
                      error: exception,
                      stackTrace: stackTrace,
                    ),
                  ),
                  child:
                      Text(widget.backLabel ?? LoadingDialog.defaultBackLabel),
                ),
              ]
            : null);
  }
}

class LoadingDialogResult<T> {
  final T? result;
  final dynamic error;
  final StackTrace? stackTrace;

  LoadingDialogResult({this.result, this.error, this.stackTrace});
}
