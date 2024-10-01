import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:gs3_desafio_front/main.dart';
import 'package:gs3_desafio_front/ui/stores/address_page_store.dart';
import 'package:gs3_desafio_front/ui/widgets/detail_card.dart';
import '../../src/models/address_model.dart';
import '../../src/services/user_service.dart';
import '../stores/configuration_store.dart';

///TODO: IMPLEMENT!!!

class AddressesPage extends StatefulWidget {
  final AddressPageStore addressesStore;
  final Future<void> Function() refreshAddresses;

  const AddressesPage({super.key,
    required this.addressesStore,
    required this.refreshAddresses});

  @override
  State<StatefulWidget> createState() => AddressesPageState();
}

class AddressesPageState extends State<AddressesPage> {
  ScrollController scrollBarBodyController = ScrollController();
  ScrollController scrollBarDrawerController = ScrollController();
  TextEditingController searchController = TextEditingController();
  final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<
      RefreshIndicatorState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    searchController.dispose();
    scrollBarDrawerController.dispose();
    scrollBarBodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("Addresses"),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              navigatorKey.currentState?.pop();
            }),
        actions: [IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            }),
        ],
      ),
      body: Observer(
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: searchController,
                  onChanged: (String? value) {
                    widget.addressesStore.setSearchString(value ?? "");
                  },
                  decoration: InputDecoration(
                      label: const Text("Search"),
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                          onPressed: () {
                            widget.addressesStore.setSearchString("");
                            searchController.clear();
                          },
                          icon: const Icon(Icons.clear)),
                      border: const OutlineInputBorder()),
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    RefreshIndicator(
                      key: _refreshKey,
                      onRefresh: () async {
                        await widget.refreshAddresses();
                      },
                      child: Scrollbar(
                        controller: scrollBarBodyController,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(bottom: 60),
                          controller: scrollBarBodyController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount:
                          widget.addressesStore.filteredAddresses.length,
                          itemBuilder: (context, index) {
                            AddressModel address =
                            widget.addressesStore.filteredAddresses[index];
                            return DetailCard(
                              title: address.description,
                              delete: () async {
                                await UserService.deleteAddress(address);
                                await _refreshKey.currentState
                                    ?.show(atTop: false);
                              },
                              edit: () async {},
                              toggleFavorite: () async {
                                address.principal = true;
                                await UserService.updateAddress(address);
                                await _refreshKey.currentState
                                    ?.show(atTop: false);
                              },
                              favorite: address.principal,
                              child: RichText(
                                  text: TextSpan(
                                      text: "Address: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: GetIt
                                              .I<ConfigurationStore>()
                                              .theme
                                              .colorScheme
                                              .onBackground,
                                          fontSize: 18),
                                      children: [
                                        TextSpan(
                                            text: address.address,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.normal)),
                                      ])),
                            );
                          },
                        ),
                      ),
                    ),
                    Visibility(
                        visible:
                        widget.addressesStore.filteredAddresses.isEmpty,
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "No addresses found",
                            style: TextStyle(fontSize: 24),
                          ),
                        ))
                  ],
                ),
              ),
            ],
          );
        },
      ),
      endDrawer: Drawer(
        child: Scrollbar(
      controller: scrollBarDrawerController,
      child: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 32.0, left: 12, right: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(alignment: Alignment.centerLeft,child: Text("Filters", style: TextStyle(fontSize: 32),)),
              Divider(),
              ///TODO: filtro de perfil
            ],
          ),
        ),
      ),),),
      floatingActionButton: FloatingActionButton(
        heroTag: "add-address",
        onPressed: () {},
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
