import 'package:flutter/material.dart';
import 'package:flutter_hostel_issue_resolution/listing.dart';

class FragmentHolder extends StatefulWidget {
  const FragmentHolder({super.key});

  @override
  State<FragmentHolder> createState() => _FragmentHolderState();
}

class _FragmentHolderState extends State<FragmentHolder> {
  var data = [];
  @override
  Widget build(BuildContext context) {
    return HostelApp();
  }
}
