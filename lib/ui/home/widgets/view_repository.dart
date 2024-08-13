import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';

import '../../../domain/model/repository_item.dart';
import '../../../generated/assets.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/styles.dart';

class RepositoryItemView extends StatelessWidget {
  final RepositoryItem repositoryItem;
  final bool isFavorite;
  final Function(bool isFavorite) clickFavoriteBtn;
  final bool isDismissible;
  final Function(RepositoryItem item)? deleteHistory;

  const RepositoryItemView({super.key,
    required this.repositoryItem,
    this.isFavorite = false,
    required this.clickFavoriteBtn,
    required this.isDismissible, required this.deleteHistory});

  @override
  Widget build(BuildContext context) {
    return isDismissible ? Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xffEA1A1A),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        Dismissible(
          key: ObjectKey(repositoryItem),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            if(deleteHistory != null){
              deleteHistory!(repositoryItem);
            }

          },
          background: Container(
            padding: const EdgeInsets.only(right: 24, left: 24),
            alignment: Alignment.centerRight,
            decoration: const BoxDecoration(
                color: Color(0xffEA1A1A),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: SvgPicture.asset(
              Assets.assetsIconDismissible,
              width: 44,
              height: 44,
            ),
          ),
          child: viewItem(),
        ),
      ],
    ) : viewItem();
  }

  Widget viewItem() {
    return InkWell(
      onTap: () {
        if (!AppUtils.isFastDoubleClick()) {
          launchURL(repositoryItem.htmlUrl);
        }
      },
      child: Container(
        padding:
        const EdgeInsets.only(right: 16, left: 16, top: 18, bottom: 18),
        decoration: BoxDecoration(
            color: bgField,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Row(
          children: [
            Expanded(
                child: Text(
                  "${repositoryItem.description}",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: descriptionStyle,
                )),
            GFIconButton(
                iconSize: 24,
                alignment: Alignment.center,
                size: 44,
                padding: const EdgeInsets.all(10),
                color: Colors.transparent,
                icon: SvgPicture.asset(
                  Assets.assetsIconFavoriteActive,
                  colorFilter: ColorFilter.mode(
                      isFavorite ? mainColor : hintColor, BlendMode.srcIn),
                ),
                onPressed: () {
                  clickFavoriteBtn(!isFavorite);
                })
          ],
        ),
      ),
    );
  }
}
