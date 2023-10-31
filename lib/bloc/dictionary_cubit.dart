import 'package:dictionary_app_bloc/model/word_response.dart';
import 'package:dictionary_app_bloc/repo/word_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DictionaryCubit extends Cubit<DictionaryState> {
  final WordRepository _repository;
  DictionaryCubit(this._repository) : super(NoWordSearchedState());

  final queryController = TextEditingController();

  Future getWordSearched() async {
    emit(WordSearchingState());

    try {
      final words = await _repository.getWordFromDictionary(queryController.text);
      if (words == null) {
        emit(ErrorState("This is a Error"));
      } else {
        emit(WordSearchedState(words));
      }
    } on Exception catch (e) {
      print(e);
      emit(ErrorState("There is a Error"));
    }
  }
}

abstract class DictionaryState {}

class NoWordSearchedState extends DictionaryState {}

class WordSearchingState extends DictionaryState {}

class WordSearchedState extends DictionaryState {
  final List<WordResponse> words;

  WordSearchedState(this.words);
}

class ErrorState extends DictionaryState {
  final message;
  ErrorState(this.message);
}
