import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muffin_clicker/clicker/cubit/clicker_cubit.dart';
import 'package:muffin_clicker/shared_widgets/status_bar.dart';
import 'package:muffin_clicker/shared_widgets/ink_well_container.dart';
import 'package:muffin_clicker/skins/cubit/selected_skin_cubit.dart';
import 'package:muffin_clicker/skins/cubit/skin_model.dart';
import 'package:muffin_clicker/skins/cubit/skins_cubit.dart';
import 'package:muffin_clicker/utils/text_styles.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SkinsPage extends StatefulWidget {
  const SkinsPage({
    super.key,
  });

  @override
  State<SkinsPage> createState() => _SkinsPageState();
}

class _SkinsPageState extends State<SkinsPage> {
  int currentIndex = 0;
  final ItemScrollController itemScrollController = ItemScrollController();

  setNewIndex(int index) {
    setState(() {
      currentIndex = index;
    });
    itemScrollController.scrollTo(
      index: index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SkinsCubit, List<SkinModel>>(
        builder: (BuildContext context, List<SkinModel> state) {
          return Stack(
            children: [
              AbsorbPointer(
                absorbing: true,
                child: ScrollablePositionedList.builder(
                  itemScrollController: itemScrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: state.length,
                  itemBuilder: (context, index) {
                    return _SkinCard(skinModel: state[index]);
                  },
                ),
              ),
              _UI(
                skins: state,
                isBackButtonDisabled: currentIndex == 0,
                isNextButtonDisabled: currentIndex == state.length - 1,
                currentIndex: currentIndex,
                onChangeIndex: (newIndex) => setNewIndex(newIndex),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _UI extends StatelessWidget {
  final List<SkinModel> skins;
  final bool isBackButtonDisabled;
  final bool isNextButtonDisabled;
  final int currentIndex;
  final Function(int) onChangeIndex;

  const _UI({
    required this.skins,
    required this.isBackButtonDisabled,
    required this.isNextButtonDisabled,
    required this.currentIndex,
    required this.onChangeIndex,
  });

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: Colors.white,
      fontSize: 23,
    );
    const textStyleRed = TextStyle(
      color: Colors.red,
      fontSize: 23,
    );
    const titleStyle = TextStyle(
      color: Colors.white,
      fontSize: 30,
      shadows: textShadows,
      fontWeight: FontWeight.bold,
    );

    final focusSkin = skins[currentIndex];
    final boughtSkins = skins.where((skin) => skin.isBought).toList();
    final selectedSkin = context.read<SelectedSkinCubit>().state;
    final clickerCubit  = context.read<ClickerCubit>();
    final canBuy = clickerCubit.state.clicks >= focusSkin.price; 

    return Column(children: [
      StatusBar(
        onPressBack: () {
          Navigator.pop(context);
        },
      ),
      Text(
        'Skins (${boughtSkins.length}/${skins.length})',
        style: titleStyle,
      ),
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.black.withOpacity(0.7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _NavigationButton(
                    isDisable: isBackButtonDisabled,
                    icon: Icons.arrow_left,
                    onPressed: () {
                      onChangeIndex(currentIndex - 1);
                    },
                  ),
                  Expanded(
                    child: Text(
                      textAlign: TextAlign.center,
                      focusSkin.name,
                      style: textStyle,
                    ),
                  ),
                  _NavigationButton(
                    isDisable: isNextButtonDisabled,
                    icon: Icons.arrow_right,
                    onPressed: () {
                      onChangeIndex(currentIndex + 1);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Builder(builder: (context) {
              if (!focusSkin.isBought) {
                return AbsorbPointer(
                  absorbing: !canBuy,
                  child: InkWellContainer(
                    width: null,
                    onTap: () {
                      clickerCubit.spend(focusSkin.price);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        'Buy for ${focusSkin.price} muffins',
                        style: canBuy ? textStyle : textStyleRed,
                      ),
                    ),
                  ),
                );
              }

              final isSelected = focusSkin.name == selectedSkin.name;

              if (isSelected) {
                return AbsorbPointer(
                  absorbing: true,
                  child: InkWellContainer(
                    width: null,
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'Selected',
                        style: textStyle,
                      ),
                    ),
                  ),
                );
              } else {
                return InkWellContainer(
                  width: null,
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Buy',
                      style: textStyle,
                    ),
                  ),
                );
              }
            }),
          ],
        ),
      ),
    ]);
  }
}

class _NavigationButton extends StatelessWidget {
  final bool isDisable;
  final IconData icon;
  final Function() onPressed;

  const _NavigationButton({
    required this.isDisable,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isDisable,
      child: IconButton(
        highlightColor: Colors.white.withOpacity(0.3),
        onPressed: onPressed,
        icon: Icon(
          size: 50,
          icon,
          color: isDisable ? Colors.grey.withAlpha(160) : Colors.white,
        ),
      ),
    );
  }
}

class _SkinCard extends StatelessWidget {
  final SkinModel skinModel;

  const _SkinCard({required this.skinModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: CustomPaint(
        painter: mapBackgorundIdToPainter[skinModel.backgroundId],
        child: Center(
          child: Image.asset(
            skinModel.image,
            width: 200,
          ),
        ),
      ),
    );
  }
}
