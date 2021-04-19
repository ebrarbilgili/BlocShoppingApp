import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../CartView/cart_view.dart';
import '../model/home_model.dart';
import '../providers/cubit/home_cubit.dart';
import '../providers/provider/cart_provider.dart';
import '../service/home_service.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    fetchBloc.getHomeModelData();
    return BlocProvider(
      create: (context) => fetchBloc,
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is HomeInitial) {
            return Scaffold(
              appBar: buildAppBar(context),
              body: Center(
                child: Text('Welcome Cubit State Management!'),
              ),
            );
          } else if (state is HomeLoading) {
            return Scaffold(
              appBar: buildAppBar(context),
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state is HomeCompleted) {
            return Scaffold(
              appBar: buildAppBar(context),
              body: ListView.builder(
                itemCount: state.listHomeModel.length,
                itemBuilder: (BuildContext context, int index) {
                  final data = state.listHomeModel[index];
                  return buildCard(context, data, index);
                },
              ),
            );
          } else {
            final error = state as HomeError;
            return buildHomeError(context, error);
          }
        },
      ),
    );
  }

  Card buildCard(BuildContext context, HomeModel data, int index) {
    return Card(
      child: ListTile(
        leading: Text(data.id.toString()),
        title: Text(data.name ?? ''),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Username: ${data.username}'),
            Text('Commpany: ${data.company}'),
            Text('Email: ${data.email}'),
            Text('Phone: ${data.phone}'),
            Text('City: ${data.address!.city}'),
          ],
        ),
        trailing: Wrap(
          children: [
            IconButton(
              icon: Icon(Icons.remove_shopping_cart),
              onPressed: () {
                // context.read<HomeCubit>().listCartModel.add(data);
                context.read<CartProvider>().clear(data);
              },
            ),
            IconButton(
              icon: Icon(Icons.add_shopping_cart_outlined),
              onPressed: () {
                // context.read<HomeCubit>().listCartModel.add(data);
                context.read<CartProvider>().addItemToBasket(data);
              },
            ),
          ],
        ),
      ),
    );
  }

  Scaffold buildHomeError(BuildContext context, HomeError error) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Center(child: Text('${error.errorMessage}')),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    var total = 0;
    context.watch<CartProvider>().cart.forEach((key, value) {
      total += value;
    });

    return AppBar(
      title: Text('Bloc/Cubit Shopping app'),
      actions: [
        CircleAvatar(
          backgroundColor: Colors.red,
          radius: 12,
          child: Text(
            '$total',
          ),
        ),
        IconButton(
          icon: Icon(Icons.shopping_basket_rounded),
          onPressed: () {
            final data = Provider.of<CartProvider>(context, listen: false).cart;
            print(data);
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ShoppingCartView()),
            );
          },
        )
      ],
    );
  }

  final fetchBloc = HomeCubit(
    HomeService(
      service: Dio(
        BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com'),
      ),
    ),
  );
}
