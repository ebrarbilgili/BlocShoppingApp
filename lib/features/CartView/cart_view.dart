import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../HomeView/model/home_model.dart';
import '../HomeView/providers/provider/cart_provider.dart';

class ShoppingCartView extends StatelessWidget {
  ShoppingCartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var total = 0;
    var bloc = Provider.of<CartProvider>(context);
    var cart = bloc.cart;

    cart.forEach((key, value) {
      total += value;
    });

    return Scaffold(
      appBar: buildAppBar,
      body: buildBody(cart, bloc, total),
    );
  }

  SingleChildScrollView buildBody(
      Map<HomeModel, int> cart, CartProvider bloc, int total) {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildListView(cart, bloc),
          buildTotalProduct(total),
        ],
      ),
    );
  }

  Row buildTotalProduct(int total) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Text('TOTAL PRODCUT: $total'),
        ),
      ],
    );
  }

  ListView buildListView(Map<HomeModel, int> cart, CartProvider bloc) {
    return ListView.builder(
      itemCount: cart.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var model = cart.keys.toList()[index];
        var count = cart[model];
        return buildListTile(model, count!, bloc);
      },
    );
  }

  ListTile buildListTile(HomeModel model, int count, CartProvider bloc) {
    return ListTile(
      leading: Text(model.id.toString()),
      title: Text(model.name ?? ''),
      subtitle: Text('Item Count: $count'),
      trailing: IconButton(
        onPressed: () {
          bloc.clear(model);
        },
        icon: Icon(Icons.remove_shopping_cart),
      ),
    );
  }

  AppBar get buildAppBar {
    return AppBar(
      title: Text('Shopping Cart'),
    );
  }
}
