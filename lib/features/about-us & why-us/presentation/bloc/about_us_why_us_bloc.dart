import 'package:bloc/bloc.dart';
import 'package:two_dashboard/core/network/enums.dart';
import 'package:two_dashboard/core/param/about_us_why_us_param.dart';
import 'package:two_dashboard/core/param/casule_param.dart';
import 'package:two_dashboard/core/services/shared_preferences_services.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/domain/entities/about_us_entity.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/domain/entities/why_us_entity.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/domain/usecases/about-us-usecase/create_about_us_usecase.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/domain/usecases/about-us-usecase/show_about_us_usecase.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/domain/usecases/about-us-usecase/update_about_us_usecase.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/domain/usecases/why-us-usecase/create_why_us_usecase.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/domain/usecases/why-us-usecase/delete_why_us_usecase.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/domain/usecases/why-us-usecase/show_why_us_usecase.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/domain/usecases/why-us-usecase/update_why_us_usecase.dart';

part 'about_us_why_us_event.dart';
part 'about_us_why_us_state.dart';

class AboutUsWhyUsBloc extends Bloc<AboutUsWhyUsEvent, AboutUsWhyUsState> {
  final ShowAboutUsUsecase showAboutUsUsecase;
  final CreateAboutUsUsecase createAboutUsUsecase;
  final UpdateAboutUsUsecase updateAboutUsUsecase;
  final ShowWhyUsUsecase showWhyUsUsecase;
  final CreateWhyUsUsecase createWhyUsUsecase;
  final UpdateWhyUsUsecase updateWhyUsUsecase;
  final DeleteWhyUsUsecase deleteWhyUsUsecase;
  AboutUsWhyUsBloc(
    this.showAboutUsUsecase,
    this.createAboutUsUsecase,
    this.updateAboutUsUsecase,
    this.showWhyUsUsecase,
    this.createWhyUsUsecase,
    this.updateWhyUsUsecase,
    this.deleteWhyUsUsecase,
  ) : super(AboutUsWhyUsState()) {
    // About Us //
    on<GetAboutUsEvent>((event, emit) async {
      emit(state.copyWith(getAboutUsStatus: CasualStatus.loading));
      final result = await showAboutUsUsecase.call();
      result.fold(
        (l) => emit(
          state.copyWith(
            getAboutUsStatus: CasualStatus.failure,
            message: l.message,
          ),
        ),
        (r) => emit(
          state.copyWith(
            getAboutUsStatus: CasualStatus.success,
            getAboutUsEntity: r,
          ),
        ),
      );
    });
    on<CreateAboutUsEvent>((event, emit) async {
      emit(state.copyWith(createAboutUsStatus: CasualStatus.loading));
      final String? token = await SharedPreferencesServices.getUserToken();
      if (token != null) {
        final result = await createAboutUsUsecase.call(
          CreateAboutUsParam(
            token: token,
            workTime: event.workTime,
            site: event.site,
          ),
        );
        result.fold(
          (l) => emit(
            state.copyWith(
              createAboutUsStatus: CasualStatus.failure,
              message: l.message,
            ),
          ),
          (r) =>
              emit(state.copyWith(createAboutUsStatus: CasualStatus.success)),
        );
      } else {
        emit(
          state.copyWith(
            createAboutUsStatus: CasualStatus.not_authorized,
            message: "No Token",
          ),
        );
      }
    });
    on<UpdateAboutUsEvent>((event, emit) async {
      emit(state.copyWith(updateAboutUsStatus: CasualStatus.loading));
      final String? token = await SharedPreferencesServices.getUserToken();
      if (token != null) {
        final result = await updateAboutUsUsecase.call(
          UpdateAboutUsParam(token: token, aboutUs: event.aboutUsEntity),
        );
        result.fold(
          (l) => emit(
            state.copyWith(
              updateAboutUsStatus: CasualStatus.failure,
              message: l.message,
            ),
          ),
          (r) =>
              emit(state.copyWith(updateAboutUsStatus: CasualStatus.success)),
        );
      } else {
        emit(
          state.copyWith(
            updateAboutUsStatus: CasualStatus.not_authorized,
            message: "No Token",
          ),
        );
      }
    });
    // Why Us //
    on<GetWhyUsEvent>((event, emit) async {
      emit(state.copyWith(getWhyUsStatus: CasualStatus.loading));
      final result = await showWhyUsUsecase.call();
      result.fold(
        (l) => emit(
          state.copyWith(
            getWhyUsStatus: CasualStatus.failure,
            message: l.message,
          ),
        ),
        (r) => emit(
          state.copyWith(getWhyUsStatus: CasualStatus.success, getWhyUsList: r),
        ),
      );
    });
    on<CreateWhyUsEvent>((event, emit) async {
      emit(state.copyWith(createWhyUsStatus: CasualStatus.loading));
      final String? token = await SharedPreferencesServices.getUserToken();
      if (token != null) {
        final result = await createWhyUsUsecase.call(
          CreateWhyUsParam(token: token, whyUs: event.whyUs),
        );
        result.fold(
          (l) => emit(
            state.copyWith(
              createWhyUsStatus: CasualStatus.failure,
              message: l.message,
            ),
          ),
          (r) => emit(state.copyWith(createWhyUsStatus: CasualStatus.success)),
        );
      } else {
        emit(
          state.copyWith(
            createWhyUsStatus: CasualStatus.not_authorized,
            message: "No Token",
          ),
        );
      }
    });
    on<UpdateWhyUsEvent>((event, emit) async {
      emit(state.copyWith(updateWhyUsStatus: CasualStatus.loading));
      final String? token = await SharedPreferencesServices.getUserToken();
      if (token != null) {
        final result = await updateWhyUsUsecase.call(
          UpdateWhyUsParam(
            token: token,
            whyUsId: event.whyUsId,
            whyUs: event.whyUs,
          ),
        );
        result.fold(
          (l) => emit(
            state.copyWith(
              updateWhyUsStatus: CasualStatus.failure,
              message: l.message,
            ),
          ),
          (r) => emit(state.copyWith(updateWhyUsStatus: CasualStatus.success)),
        );
      } else {
        emit(
          state.copyWith(
            updateWhyUsStatus: CasualStatus.not_authorized,
            message: "No Token",
          ),
        );
      }
    });
    on<DeleteWhyUsEvent>((event, emit) async {
      emit(state.copyWith(deleteWhyUsStatus: CasualStatus.loading));
      final String? token = await SharedPreferencesServices.getUserToken();
      if (token != null) {
        final result = await deleteWhyUsUsecase.call(
          TokenWithIdParam(token: token, id: event.whyUsId),
        );
        result.fold(
          (l) => emit(
            state.copyWith(
              deleteWhyUsStatus: CasualStatus.failure,
              message: l.message,
            ),
          ),
          (r) => emit(state.copyWith(deleteWhyUsStatus: CasualStatus.success)),
        );
      } else {
        emit(
          state.copyWith(
            deleteWhyUsStatus: CasualStatus.not_authorized,
            message: "No Token",
          ),
        );
      }
    });
  }
}
