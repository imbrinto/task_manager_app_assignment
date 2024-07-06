import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager_app_assignment/ui/utilities/asset_paths.dart';

class BackgroundWidget extends StatelessWidget {

  final Widget child;

  const BackgroundWidget(
      {super.key,
      required this.child,});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          AssetPaths.backgroundPath,
          height: double.maxFinite,
          fit: BoxFit.cover,
        ),
        child,
      ],
    );
  }
}
