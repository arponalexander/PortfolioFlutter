import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;

import '../constants/assets.dart';
import '../constants/strings.dart';
import '../constants/text_styles.dart';
import '../model/education.dart';
import '../utils/screen/screenUtils.dart';
import '../widgets/responsiveWidget.dart';





const Color themeColor = Color(0x00fbfcfc);
class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: themeColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: (ScreenUtil.getInstance().setWidth(108))), //144
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: _buildAppBar(context),
          drawer: _buildDrawer(context),
          body: LayoutBuilder(builder: (context, constraints) {
            return _buildBody(context, constraints);
          }),
        ),
      ),
    );
  }

  //AppBar Methods:-------------------------------------------------------------
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      titleSpacing: 0.0,
      title: _buildTitle(),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      actions:
      !ResponsiveWidget.isSmallScreen(context) ? _buildActions() : null,
    );
  }

  Widget _buildTitle() {
    return RichText(
      text: TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        style: const TextStyle(
          fontSize: 14.0,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
            text: Strings.alexander,
            style: TextStyles.logo,
          ),
          TextSpan(
            text: Strings.arpon,
            style: TextStyles.logo.copyWith(
              color: const Color(0xFF50AFC0),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildActions() {
    return <Widget>[
      MaterialButton(
        child: Text(
          Strings.menu_home,
          style: TextStyles.menu_item.copyWith(
            color: const Color(0xFF50AFC0),
          ),
        ),
        onPressed: () {},
      ),
      MaterialButton(
        child: Text(
          Strings.menu_about,
          style: TextStyles.menu_item,
        ),
        onPressed: () {},
      ),
      MaterialButton(
        child: Text(
          Strings.menu_contact,
          style: TextStyles.menu_item,
        ),
        onPressed: () {
          html.window.open("mailto:arpon.alexander@gmail.com", "Email");
        },
      ),
    ];
  }

  Widget? _buildDrawer(BuildContext context) {
    return ResponsiveWidget.isSmallScreen(context)
        ? Drawer(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: _buildActions(),
      ),
    )
        : null;
  }

  //Screen Methods:-------------------------------------------------------------
  Widget _buildBody(BuildContext context, BoxConstraints constraints) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),
        child: ResponsiveWidget(
          largeScreen: _buildLargeScreen(context),
          mediumScreen: _buildMediumScreen(context),
          smallScreen: _buildSmallScreen(context),
        ),
      ),
    );
  }

  Widget _buildLargeScreen(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(flex: 1, child: _buildContent(context)),
                _buildIllustration(),
              ],
            ),
          ),
          _buildFooter(context)
        ],
      ),
    );
  }

  Widget _buildMediumScreen(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(flex: 1, child: _buildContent(context)),
              ],
            ),
          ),
          _buildFooter(context)
        ],
      ),
    );
  }

  Widget _buildSmallScreen(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(flex: 1, child: _buildContent(context)),
          const Divider(),
          _buildCopyRightText(context),
          SizedBox(
              height: ResponsiveWidget.isSmallScreen(context) ? 12.0 : 0.0),
          _buildSocialIcons(),
          SizedBox(
              height: ResponsiveWidget.isSmallScreen(context) ? 12.0 : 0.0),
        ],
      ),
    );
  }

  // Body Methods:--------------------------------------------------------------
  Widget _buildIllustration() {
    return Image.asset(
      Assets.programmer2,
      // Assets.programmer,
      // color: themeColor,
      // colorBlendMode: BlendMode.darken,
      height: ScreenUtil.getInstance().setWidth(345), //480.0
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: ResponsiveWidget.isSmallScreen(context) ? 24.0 : 0.0),
        _buildAboutMe(context),
        const SizedBox(height: 4.0),
        _buildHeadline(context),
        SizedBox(height: ResponsiveWidget.isSmallScreen(context) ? 12.0 : 24.0),
        _buildSummary(),
        SizedBox(height: ResponsiveWidget.isSmallScreen(context) ? 24.0 : 48.0),
        ResponsiveWidget.isSmallScreen(context)
            ? Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildEducation(),
            const SizedBox(height: 24.0),
            _buildSkills(context),
          ],
        )
            : _buildSkillsAndEducation(context)
      ],
    );
  }

  Widget _buildAboutMe(BuildContext context) {
    return RichText(
      text: TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        style: const TextStyle(
          fontSize: 14.0,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
            text: Strings.about,
            style: TextStyles.heading.copyWith(
              // fontFamily: Fonts.nexa_light,
              fontSize: ResponsiveWidget.isSmallScreen(context) ? 36 : 45.0,
            ),
          ),
          TextSpan(
            text: Strings.me,
            style: TextStyles.heading.copyWith(
              color: const Color(0xFF50AFC0),
              fontSize: ResponsiveWidget.isSmallScreen(context) ? 36 : 45.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeadline(BuildContext context) {
    return Text(
      ResponsiveWidget.isSmallScreen(context)
          ? Strings.headline
          : Strings.headline.replaceFirst(RegExp(r' f'), '\nf'),
      style: TextStyles.sub_heading,
    );
  }

  Widget _buildSummary() {
    return const Padding(
      padding: EdgeInsets.only(right: 80.0),
      // child: Text(
      //   Strings.summary,
      //   style: TextStyles.body,
      // ),
    );
  }

  Widget _buildSkillsAndEducation(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: _buildEducation(),
        ),
        const SizedBox(width: 40.0),
        Expanded(
          flex: 1,
          child: _buildSkills(context),
        ),
      ],
    );
  }

  // Skills Methods:------------------------------------------------------------
  final skills = [
    'Dart',
    'Flutter',
    'Java',
    'Android',
    'Firebase',
  ];

  Widget _buildSkills(BuildContext context) {
    final List<Widget> widgets = skills
        .map((skill) => Padding(
      padding: const EdgeInsets.only(right: 8.0, bottom: 4.0),
      child: _buildSkillChip(context, skill),
    ))
        .toList();

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildSkillsContainerHeading(),
        Wrap(children: widgets),
//        _buildNavigationArrows(),
      ],
    );
  }

  Widget _buildSkillsContainerHeading() {
    return Text(
      Strings.skills_i_have,
      style: TextStyles.sub_heading,
    );
  }

  Widget _buildSkillChip(BuildContext context, String label) {
    return Chip(
      label: Text(
        label,
        style: TextStyles.chip.copyWith(
          fontSize: ResponsiveWidget.isSmallScreen(context) ? 10.0 : 11.0,
        ),
      ),
    );
  }

  /// Education Methods:---------------------------------------------------------
  final workingExperienceList = [
    Education(
      '2015',
      '2022',
      'Technological Institute of the Philippines',
      'Information Technology',
    ),

  ];

  Widget _buildEducation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildEducationContainerHeading(),
        _buildEducationSummary(),
        const SizedBox(height: 8.0),
        _buildEducationTimeline(),
      ],
    );
  }

  Widget _buildEducationContainerHeading() {
    return Text(
      Strings.experience,
      style: TextStyles.sub_heading,
    );
  }

  Widget _buildEducationSummary() {
    return Text(
      'To work in a dynamic professional environment and be a part of an organization where I can utilize my technical knowledge and further hone my capabilities for the benefit of the organization and myself.',
      style: TextStyles.body,
    );
  }

  Widget _buildEducationTimeline() {
    final List<Widget> widgets = workingExperienceList
        .map((education) => _buildEducationTile(education))
        .toList();
    return Column(children: widgets);
  }

  Widget _buildEducationTile(Education education) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            education.post,
            style: TextStyles.company,
          ),
          Text(
            education.organization,
            style: TextStyles.body.copyWith(
              color: const Color(0xFF45405B),
            ),
          ),
          Text(
            '${education.from}-${education.to}',
            style: TextStyles.body,
          ),
        ],
      ),
    );
  }

  /// Footer Methods:------------------------------------------------------------
  Widget _buildFooter(BuildContext context) {
    return Column(
      children: <Widget>[
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: _buildCopyRightText(context),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: _buildSocialIcons(),
              ),
            ],
          ),
        ),
      ],
    );
  }
  ///FOOTER
  Widget _buildCopyRightText(BuildContext context) {
    return Text(
      Strings.rights_reserved,
      style: TextStyles.body1.copyWith(
        fontSize: ResponsiveWidget.isSmallScreen(context) ? 8 : 10.0,
      ),
    );
  }
  /// FOOTER
  Widget _buildSocialIcons() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            html.window
                .open("https://www.linkedin.com/in/alexanderarpon/", "LinkedIn");
          },
          child: Image.asset(
            Assets.linkedin,
            // color: const Color(0xFF45405B),
            height: 20.0,
            width: 20.0,

          ),
        ),
        const SizedBox(width: 16.0),
        GestureDetector(
          onTap: () {
            html.window.open("mailto:arpon.alexander@gmail.com", "Email");
          },
          child: Image.asset(
            Assets.mail,
            // color: const Color(0xFF45405B),
            height: 20.0,
            width: 20.0,
          ),
        ),
        const SizedBox(width: 16.0),
        GestureDetector(
          onTap: () {
            html.window.open("https://github.com/arponalexander", "Github");
          },
          child: Image.asset(
            Assets.github,
            // color: const Color(0xFF45405B),
            height: 20.0,
            width: 20.0,
          ),
        ),
        const SizedBox(width: 16.0),
        GestureDetector(
          onTap: () {
            html.window.open("https://www.facebook.com/arpon.alex/", "Facebook");
          },
          child: Image.asset(
            Assets.facebook,
            // color: const Color(0xFF45405B),
            height: 20.0,
            width: 20.0,
          ),
        ),
      ],
    );
  }
}