import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmerLoadingWidget({required Widget child}) {
  return Shimmer.fromColors(
    baseColor: const Color.fromARGB(255, 238, 238, 238),
    highlightColor: Colors.grey.shade100,
    child: child,
  );
}
