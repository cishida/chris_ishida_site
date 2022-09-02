import 'package:chris_ishida_site/_constants/constants.dart';
import 'package:chris_ishida_site/_constants/products.dart';
import 'package:chris_ishida_site/core/models/product/product.dart';
import 'package:chris_ishida_site/presentation/views/product/components/product_content_view.dart';
import 'package:chris_ishida_site/presentation/views/product/product_view_model.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

class ProductView extends StatelessWidget {
  const ProductView({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductViewModel>.reactive(
      viewModelBuilder: () => ProductViewModel(),
      builder: (context, model, child) {
        final ThemeData theme = Theme.of(context);
        final Size size = MediaQuery.of(context).size;
        var deviceType = getDeviceType(size);

        TextStyle? titleStyle = theme.textTheme.headline1;
        double titleHeight = size.height * .7;
        double leftPadding = size.width * Sizes.siteWideLeftMarginPercent;
        double contentPadding = Sizes.margin200;

        if (deviceType != DeviceScreenType.desktop) {
          titleStyle = theme.textTheme.headline3;
          titleHeight = size.height * .5;
          leftPadding = Sizes.marginDefaultDouble;
          contentPadding = Sizes.marginDefaultQuad;
        }

        return Container(
          color: theme.colorScheme.background,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: leftPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: titleHeight,
                        width: size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: Sizes.marginDefaultDouble,
                            ),
                            Hero(
                              tag: product.title,
                              child: Text(
                                '${product.title} ',
                                style: titleStyle,
                              ),
                            ),
                            SizedBox(
                              height: Sizes.marginDefaultDouble,
                            ),
                            Hero(
                              tag: product.subtitle,
                              child: Text(
                                '${product.subtitle} ',
                                style: theme.textTheme.headline5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Hero(
                      //   tag: product.image,
                      //   child:
                      Container(
                        color: theme.colorScheme.secondaryContainer,
                        child: Image.asset(
                          product.image,
                        ),
                      ),
                      // ),
                    ],
                  ),
                ),
                SizedBox(
                  height: contentPadding,
                ),
                ProductContentView(
                  contentList: product.content,
                ),
                SizedBox(
                  height: size.height * .33,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
