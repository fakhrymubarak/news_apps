import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/utils_dev/test_keys.dart';

class ShimmerListWidget extends StatefulWidget {
  final bool enabled;

  const ShimmerListWidget({
    super.key = Keys.listShimmer,
    required this.enabled,
  });

  @override
  State<ShimmerListWidget> createState() => _ShimmerListWidgetState();
}

class _ShimmerListWidgetState extends State<ShimmerListWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Shimmer.fromColors(
        period: const Duration(milliseconds: 1000),
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        enabled: widget.enabled,
        child: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (_, __) => const Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: _ShimmerRowWidget(),
          ),
          itemCount: 4,
        ),
      ),
    );
  }
}

class _ShimmerRowWidget extends StatelessWidget {
  const _ShimmerRowWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 12.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  width: double.infinity,
                  height: 12.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  width: 40.0,
                  height: 12.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
          ),
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      );
}
