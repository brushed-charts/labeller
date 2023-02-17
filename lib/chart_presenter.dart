import 'package:flutter/material.dart';
import 'package:grapher/interaction/widget.dart';
import 'package:grapher/kernel/kernel.dart';
import 'package:labelling/fragment/fragment_resolver_interface.dart';
import 'package:labelling/grapherExtension/axed_graph.dart';
import 'package:labelling/model/fragment_model.dart';
import 'package:labelling/observation/observable.dart';
import 'package:labelling/observation/observer.dart';

class ChartPresenter extends StatefulWidget {
  const ChartPresenter(
      {required FragmentModel fragmentModel,
      required FragmentResolverInterface fragmentResolver,
      Key? key})
      : _fragmentModel = fragmentModel,
        _fragmentResolver = fragmentResolver,
        super(key: key);

  final FragmentModel _fragmentModel;
  final FragmentResolverInterface _fragmentResolver;

  @override
  State<ChartPresenter> createState() => _ChartPresenterState();
}

class _ChartPresenterState extends State<ChartPresenter> implements Observer {
  @override
  void initState() {
    widget._fragmentModel.subscribe(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GraphFullInteraction(
        kernel: GraphKernel(
            child: AxedGraph(
                graph: widget._fragmentResolver
                    .reduceToGraphObject(widget._fragmentModel))));
  }

  @override
  void onObservableEvent(Observable observable) {
    if (observable is! FragmentModel) return;
    setState(() {
      /* Update on observable event */
    });
  }
}
