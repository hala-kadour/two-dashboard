part of 'about_us_why_us_bloc.dart';

class AboutUsWhyUsState {
  String message;
  CasualStatus createAboutUsStatus;
  CasualStatus getAboutUsStatus;
  AboutUsEntity? getAboutUsEntity;
  CasualStatus updateAboutUsStatus;
  CasualStatus createWhyUsStatus;
  CasualStatus deleteWhyUsStatus;
  CasualStatus getWhyUsStatus;
  List<WhyUsEntity?> getWhyUsList;
  CasualStatus updateWhyUsStatus;

  AboutUsWhyUsState({
    this.message = "",
    this.createAboutUsStatus = CasualStatus.initial,
    this.getAboutUsStatus = CasualStatus.initial,
    this.getAboutUsEntity,
    this.updateAboutUsStatus = CasualStatus.initial,
    this.createWhyUsStatus = CasualStatus.initial,
    this.deleteWhyUsStatus = CasualStatus.initial,
    this.getWhyUsStatus = CasualStatus.initial,
    this.getWhyUsList = const [],
    this.updateWhyUsStatus = CasualStatus.initial,
  });

  AboutUsWhyUsState copyWith({
    String? message,
    CasualStatus? createAboutUsStatus,
    CasualStatus? getAboutUsStatus,
    AboutUsEntity? getAboutUsEntity,
    CasualStatus? updateAboutUsStatus,
    CasualStatus? createWhyUsStatus,
    CasualStatus? deleteWhyUsStatus,
    CasualStatus? getWhyUsStatus,
    List<WhyUsEntity?>? getWhyUsList,
    CasualStatus? updateWhyUsStatus,
  }) {
    return AboutUsWhyUsState(
      message: message ?? this.message,
      createAboutUsStatus: createAboutUsStatus ?? this.createAboutUsStatus,
      getAboutUsStatus: getAboutUsStatus ?? this.getAboutUsStatus,
      getAboutUsEntity: getAboutUsEntity ?? this.getAboutUsEntity,
      updateAboutUsStatus: updateAboutUsStatus ?? this.updateAboutUsStatus,
      createWhyUsStatus: createWhyUsStatus ?? this.createWhyUsStatus,
      deleteWhyUsStatus: deleteWhyUsStatus ?? this.deleteWhyUsStatus,
      getWhyUsStatus: getWhyUsStatus ?? this.getWhyUsStatus,
      getWhyUsList: getWhyUsList ?? this.getWhyUsList,
      updateWhyUsStatus: updateWhyUsStatus ?? this.updateWhyUsStatus,
    );
  }
}
