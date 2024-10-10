import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:weather_app/models/weather_model.dart';

import '../data/repository/weather_repository.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc(this.weatherRepository) : super(WeatherInitial()) {
    on<WeatherFetched>(_getCurrentWeather);// fetched without cityName,
    on<WeatherFetchedByCity>(_getCurrentWeatherByCity);// Fetched with CityName,
    }

  void _getCurrentWeather(WeatherFetched event,
      Emitter<WeatherState> emit) async {
    try {
      emit(WeatherLoading());
      final weather = await weatherRepository.getCurrentWeather();
      emit(WeatherSuccess(weatherModel: weather, currentCity: 'Islamabad'));
    } catch (e) {
      emit(WeatherFailure(e.toString()));
    }
  }

  void _getCurrentWeatherByCity(WeatherFetchedByCity event, Emitter<WeatherState> emit) async {
    try {
      emit(WeatherLoading());
      final weather = await weatherRepository.getCurrentWeather(event.cityName);
      emit(WeatherSuccess(weatherModel: weather, currentCity: event.cityName));
    } catch (e) {
      emit(WeatherFailure(e.toString()));
    }
  }
 @override
  void onTransition(Transition<WeatherEvent, WeatherState> transition) {
    // TODO: implement onTransition
    super.onTransition(transition);
    print(transition);
  }
}

