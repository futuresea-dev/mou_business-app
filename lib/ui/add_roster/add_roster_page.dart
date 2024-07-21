import 'package:flutter/material.dart' hide MenuBar;
import 'package:lottie/lottie.dart';
import 'package:mou_business_app/core/databases/app_database.dart';
import 'package:mou_business_app/helpers/provider_setup.dart';
import 'package:mou_business_app/helpers/translations.dart';
import 'package:mou_business_app/ui/add_roster/add_roster_viewmodel.dart';
import 'package:mou_business_app/ui/add_task/components/store_dialog.dart';
import 'package:mou_business_app/ui/add_task/components/store_input.dart';
import 'package:mou_business_app/ui/base/base_widget.dart';
import 'package:mou_business_app/ui/widgets/app_body.dart';
import 'package:mou_business_app/ui/widgets/app_content.dart';
import 'package:mou_business_app/ui/widgets/app_header.dart';
import 'package:mou_business_app/ui/widgets/app_menu_bar.dart';
import 'package:mou_business_app/ui/widgets/bottom_sheet_custom.dart';
import 'package:mou_business_app/ui/widgets/date_hour_picker/date_hour_picker_dialog.dart';
import 'package:mou_business_app/ui/widgets/employee_list_dialog/employee_list_dialog.dart';
import 'package:mou_business_app/ui/widgets/loading_full_screen.dart';
import 'package:mou_business_app/utils/app_colors.dart';
import 'package:mou_business_app/utils/app_constants.dart';
import 'package:mou_business_app/utils/app_font_size.dart';
import 'package:mou_business_app/utils/app_images.dart';
import 'package:mou_business_app/utils/app_languages.dart';
import 'package:mou_business_app/utils/app_utils.dart';
import 'package:provider/provider.dart';

class AddRosterPage extends StatefulWidget {
  const AddRosterPage({this.rosterId});

  final int? rosterId;

  @override
  _AddRosterPageState createState() => _AddRosterPageState();
}

class _AddRosterPageState extends State<AddRosterPage> {
  late AddRosterViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<AddRosterViewModel>(
      viewModel: AddRosterViewModel(Provider.of(context)),
      onViewModelReady: (viewModel) => _viewModel = viewModel..init(widget.rosterId),
      builder: (context, viewModel, child) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          key: viewModel.scaffoldKey,
          body: AppBody(
            child: StreamBuilder<bool>(
              stream: _viewModel.loadingSubject,
              builder: (context, snapShot) {
                return LoadingFullScreen(
                  loading: snapShot.data ?? false,
                  child: AppContent(
                    headerBuilder: (hasInternet) => _buildHeader(context, hasInternet),
                    childBuilder: (hasInternet) => _buildBody(context, hasInternet),
                    headerImage: AssetImage(AppImages.bgTopHeaderNewRoster),
                    menuBar: const AppMenuBar(),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool hasInternet) {
    return AppHeader(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 25, left: 12),
            child: IconButton(
              icon: Image.asset(AppImages.icClose, width: 16),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          const Spacer(flex: 1),
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Container(
              height: 64,
              alignment: Alignment.center,
              child: IconButton(
                icon: Hero(
                  tag: 'imageRoster',
                  child: Image.asset(AppImages.icRosterHeader),
                ),
                iconSize: 50,
                padding: const EdgeInsets.only(bottom: 21),
                onPressed:
                    hasInternet ? () => AppUtils.openLink(AppConstants.rosterScopeLink) : null,
              ),
            ),
          ),
          const Spacer(flex: 1),
          IconButton(
            iconSize: 50,
            onPressed: hasInternet ? _viewModel.addRoster : null,
            icon: hasInternet
                ? ValueListenableBuilder<int>(
              valueListenable: _viewModel.totalDeny,
              builder: (_, value, __) {
                return Image.asset(
                  value > 0 ? AppImages.icReAccept : AppImages.icAccept,
                  width: 24,
                  fit: BoxFit.cover,
                );
              },
            )
                : const SizedBox(height: 15),
            padding: const EdgeInsets.only(bottom: 25, right: 12),
          )
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, bool hasInternet) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      width: double.maxFinite,
      height: double.maxFinite,
      child: hasInternet
          ? SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 10),
                  _buildTagSomeone(context),
                  _buildStartDateHour(context, _viewModel),
                  _buildEndDateHour(context, _viewModel),
                  StreamBuilder<Shop?>(
                    stream: _viewModel.shopSubject,
                    builder: (context, snapshot) {
                      final shop = snapshot.data;
                      return StoreInput(
                        name: shop?.name ?? '',
                        onTap: () {
                          final height = MediaQuery.sizeOf(context).height;
                          showModalBottomSheetCustom(
                            context: context,
                            builder: (context) {
                              return Container(
                                height: height - 380,
                                child: StoreDialog(
                                  selectedShop: _viewModel.shopSubject.valueOrNull,
                                  onTap: (shop) {
                                    _viewModel.updateShopSelected(shop);
                                  },
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            )
          : const SizedBox(),
    );
  }

  Widget _buildStartDateHour(BuildContext context, AddRosterViewModel viewModel) {
    return Container(
      height: 65,
      child: Row(
        children: <Widget>[
          StreamBuilder<bool?>(
            stream: viewModel.isTypingDate,
            builder: (context, snapshot) {
              bool isShowAnim = snapshot.data ?? false;
              return Container(
                alignment: Alignment.centerLeft,
                width: 40,
                child: isShowAnim
                    ? Lottie.asset(AppImages.animDate, width: 21, repeat: false)
                    : Image.asset(
                        AppImages.icDateHour,
                        width: 22,
                        height: 22,
                        fit: BoxFit.cover,
                      ),
              );
            },
          ),
          Expanded(
            child: InkWell(
              onTap: () => _showDatePicker(context),
              child: StreamBuilder<String>(
                stream: _viewModel.startDateHourSubject,
                builder: (context, snapshot) {
                  String startDate = snapshot.data ?? "";
                  return Text(
                    startDate.isEmpty
                        ? allTranslations.text(AppLanguages.addDateAndHour)
                        : startDate,
                    style: TextStyle(
                      fontSize: AppFontSize.textDatePicker,
                      color: startDate.isEmpty ? AppColors.textPlaceHolder : AppColors.normal,
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildEndDateHour(BuildContext context, AddRosterViewModel viewModel) {
    return StreamBuilder<String>(
      stream: _viewModel.endDateHourSubject,
      builder: (context, snapshot) {
        var endDate = snapshot.data ?? "";
        return endDate.isEmpty
            ? const SizedBox.shrink()
            : Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 40),
                child: InkWell(
                  onTap: () => _showDatePicker(context),
                  child: Text(
                    endDate,
                    style: TextStyle(
                      fontSize: AppFontSize.textDatePicker,
                      color: AppColors.normal,
                    ),
                  ),
                ),
              );
      },
    );
  }

  Widget _buildTagSomeone(BuildContext context) {
    return Container(
      height: 65,
      child: Row(
        children: <Widget>[
          StreamBuilder<bool?>(
              stream: _viewModel.isTypingTagSomeOne,
              builder: (context, snapshot) {
                bool isShowAnim = snapshot.data ?? false;
                return Container(
                  alignment: Alignment.centerLeft,
                  width: 40,
                  child: isShowAnim
                      ? Lottie.asset(AppImages.animTagSomeOne, width: 20.5, repeat: false)
                      : Image.asset(
                          AppImages.icTagSomeOne,
                          height: 23,
                          width: 20.5,
                          fit: BoxFit.cover,
                        ),
                );
              }),
          Expanded(
            child: InkWell(
              onTap: () {
                _showEmployeesDialog(context);
              }, 
              child: Container(
                child: StreamBuilder<String>(
                  stream: _viewModel.employeeSubject,
                  builder: (context, snapShot) {
                    var data = snapShot.data ?? "";
                    return Text(
                      data.isEmpty ? allTranslations.text(AppLanguages.tagSomeone) : data,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: AppFontSize.textDatePicker,
                        color: data.isEmpty ? AppColors.textPlaceHolder : AppColors.normal,
                      ),
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _showEmployeesDialog(BuildContext context) {
    showModalBottomSheetCustom(
      context: context,
      builder: (context) => EmployeeListDialog(
        isEmployee: true,
        employeesSelected: _viewModel.employee != null ? [_viewModel.employee!] : [],
        onCallBack: (contacts) {
          _viewModel.setEmployee(contacts);
          _viewModel.isTypingTagSomeOne.add(contacts.isNotEmpty);
        },
        isMulti: false,
        // employees: [],
      ),
    );
  }

  void _showDatePicker(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      backgroundColor: AppColors.bgColor,
      context: context,
      builder: (BuildContext context) {
        DateTime? startDate =
            _viewModel.startDateHour == null ? DateTime.now() : _viewModel.startDateHour;
        DateTime? endDate =
            _viewModel.endDateHour == null ? DateTime.now() : _viewModel.endDateHour;

        return DateHourPickerDialog(
          height: height / 2,
          startHour: startDate?.hour ?? 0,
          startMinute: startDate?.minute ?? 0,
          startDay: startDate?.day ?? 0,
          startMonth: startDate?.month ?? 0,
          startYear: startDate?.year ?? 0,
          endHour: endDate?.hour ?? 0,
          endMinute: endDate?.minute ?? 0,
          endDay: endDate?.day ?? 0,
          endMonth: endDate?.month ?? 0,
          endYear: endDate?.year ?? 0,
          onCallBack: (startHour, startMinute, startDay, startMonth, startYear, endHour, endMinute,
              endDay, endMonth, endYear, isUse) {
            _viewModel.setDateHour(
              startHour,
              startMinute,
              startDay,
              startMonth,
              startYear,
              endHour,
              endMinute,
              endDay,
              endMonth,
              endYear,
              isUse,
            );
          },
        );
      },
    ).then((_) {
      _viewModel.isTypingDate.add(_viewModel.startDateHour != null);
    });
  }
}
