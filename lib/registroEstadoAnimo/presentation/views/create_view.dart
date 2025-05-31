import 'package:flutter/material.dart';
import 'package:mindsave/home/presentation/widgets/widgets.dart';

class CreateView extends StatelessWidget {
  const CreateView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
            centerTitle: true,
          ),
        ),

        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index){
              return _RegistroEstadoAnimoForm();
            },
            childCount: 1,
          ),
        )
      ],
    );
  }
}


class _RegistroEstadoAnimoForm extends StatefulWidget {
  const _RegistroEstadoAnimoForm();

  @override
  State<_RegistroEstadoAnimoForm> createState() => __RegistroEstadoAnimoFormState();
}

class __RegistroEstadoAnimoFormState extends State<_RegistroEstadoAnimoForm> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}