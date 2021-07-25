import 'dart:async';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:state_management_clean_arch/domain/entities/daily_task.dart';
import 'package:state_management_clean_arch/domain/repositories/todo_repository.dart';

class GetDailytasks extends UseCase<List<DailyTask>, void> {
  final TodoRepository _todoRepository;

  GetDailytasks(this._todoRepository);
  final StreamController<List<DailyTask>> _controller =
      StreamController.broadcast();

  @override
  Future<Stream<List<DailyTask>?>> buildUseCaseStream(void params) async {
    try {
      _todoRepository.getDailyTasks().listen((List<DailyTask> dailyTasks) {
        _controller.add(dailyTasks);
      });
      logger.finest('GetDailytasks successful.');
    } catch (e) {
      logger.severe('GetDailytasks unsuccessful.');

      _controller.addError(e);
    }
    return _controller.stream;
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
