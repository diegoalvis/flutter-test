import 'dart:ui';

import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/commons/idt_icons.dart';
import 'package:bogota_app/data/model/audioguide_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/mock/data/DataTest.dart';
import 'package:bogota_app/pages/audio_guide/audio_guide_view_model.dart';
import 'package:bogota_app/utils/local_data/box.dart';
import 'package:bogota_app/widget/appbar.dart';
import 'package:bogota_app/widget/bottom_appbar.dart';
import 'package:bogota_app/widget/fab.dart';
import 'package:bogota_app/widget/idt_progress_indicator.dart';
import 'package:bogota_app/widget/menu.dart';
import 'package:bogota_app/widget/title_section.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_theme.dart';

class AudioGuidePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AudioGuideViewModel(
        locator<IdtRoute>(),
        locator<ApiInteractor>(),
      ),
      builder: (context, _) {
        return AudioGuideWidget();
      },
    );
  }
}

class AudioGuideWidget extends StatefulWidget {
  @override
  _AudioGuideWidgetState createState() => _AudioGuideWidgetState();
}

class _AudioGuideWidgetState extends State<AudioGuideWidget> {
  void initState() {
    print('pago audio');
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<AudioGuideViewModel>().getAudioGuideResponse();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AudioGuideViewModel>();

    return SafeArea(
      child: WillPopScope(
          onWillPop: viewModel.offMenuBack,
        child: Scaffold(
            appBar: IdtAppBar(viewModel.openMenu),
            backgroundColor: IdtColors.white,
            extendBody: true,
            bottomNavigationBar:
                viewModel.status.openMenu ? null : IdtBottomAppBar(),
            floatingActionButton: viewModel.status.openMenu ? null : IdtFab(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            body: _buildDiscover(viewModel)),
      ),
    );
  }

  Widget _buildDiscover(AudioGuideViewModel viewModel) {
    final List<DataAudioGuideModel> _audios = viewModel.status.itemsAudioGuide;

    final textTheme = Theme.of(context).textTheme;
    final menu = AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: viewModel.status.openMenu
            ? IdtMenu(
                closeMenu: viewModel.closeMenu,
                optionIndex: TitlesMenu.audioguias,
              )
            : SizedBox.shrink());

    final loading =
        viewModel.status.isLoading ? IdtProgressIndicator() : SizedBox.shrink();

    Widget imagesCard(DataAudioGuideModel item, int index, List listItems) =>
        (GestureDetector(
          onDoubleTap: BoxDataSesion.isLoggedIn
              ? () {
                  viewModel.onTapFavorite(item.id.toString());
                }
              : null,
          //onTap: () => viewModel.goDetailPage('190'),
          onTap: () => viewModel.goDetailPage(item.id.toString()),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ColorFiltered(
                  colorFilter:
                      ColorFilter.mode(IdtColors.black, BlendMode.difference),
                 
                 child: CachedNetworkImage(
                    imageUrl: "${IdtConstants.url_image}${listItems[index].image!}",
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(

                            image: imageProvider,
                            fit: BoxFit.cover,
                           ),
                      ),
                    ),
                    // height: 250,
                    // width: 250,
                    // placeholder: (context, url) => Container(child: Container(child: Center(child: CircularProgressIndicator(backgroundColor: Colors.transparent,)), height: 30, width: 30), height: 250, width: 250,),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                 
                  // child: Image.network(
                  //   IdtConstants.url_image + item.image!,
                  //   height: 250,
                  //   width: 250,
                  //   fit: BoxFit.cover,
                  // ),
                ),
              ),
              Positioned(
                top: 8,
                right: 10,
                child: BoxDataSesion.isLoggedIn
                    ? GestureDetector(
                        onTap: () {
                          viewModel.onTapFavorite(item.id.toString());
                        },
                        child: Container(
                          child: Icon(
                            item.isFavorite == true
                                ? IdtIcons.heart2
                                : Icons.favorite_border,
                            color: item.isFavorite == true
                                ? IdtColors.red
                                : IdtColors.white,
                            size: 20,
                          ),
                        ),
                      )
                    : Container(),
              ),
              Align(
                  alignment: Alignment.center,
                  child: Icon(
                    IdtIcons.headphones,
                    color: IdtColors.white,
                    size: 50,
                  )),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                    child: Text(item.title!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style:
                            textTheme.textWhiteShadow.copyWith(fontSize: 11))),
              ),
            ],
          ),
        ));

    Widget gridImagesCol3() => (GridView.count(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 7,
          mainAxisSpacing: 9,
          //childAspectRatio: 7/6,
          padding: EdgeInsets.symmetric(horizontal: 30),
          children: _audios.asMap().entries.map((entry) {
            final int index = entry.key;
            final DataAudioGuideModel value = entry.value;

            return imagesCard(value, index, _audios);
          }).toList(),
        ));

    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 20,
                margin: EdgeInsets.only(top: 40),
                decoration: BoxDecoration(color: IdtColors.white),
                child: Center(child: TitleSection('AUDIOGUÍAS')),
              ),
              SizedBox(height: 25),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 35),
                child: Divider(
                  color: IdtColors.black,
                  height: 2,
                  thickness: 1,
                ),
              ),
              SizedBox(height: 40),
              gridImagesCol3(),
              SizedBox(height: 55),
            ],
          ),
        ),
        loading,
        menu,
      ],
    );
  }
}
