import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:state_management_clean_arch/domain/entities/daily_task.dart';
import 'package:state_management_clean_arch/domain/repositories/daily_task_repository.dart';
import 'package:state_management_clean_arch/domain/usecases/get_daily_tasks.dart';

class DailyTasksPresenter extends Presenter {
  late Function getDailyTasksOnNext;
  late Function getDailyTasksOnError;

  final GetDailytasks _getDailytasks;

  DailyTasksPresenter(DailyTaskRepository _todoRepository)
      : _getDailytasks = GetDailytasks(_todoRepository);

  void getDailyTasks() {
    _getDailytasks.execute(_GetDailyTasksObserver(this));
  }

  @override
  void dispose() {
    _getDailytasks.dispose();
  }
}

class _GetDailyTasksObserver extends Observer<List<DailyTask>> {
  final DailyTasksPresenter _presenter;

  _GetDailyTasksObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(error) {
    _presenter.getDailyTasksOnError(error);
  }

  @override
  void onNext(List<DailyTask>? dailyTasks) {
    _presenter.getDailyTasksOnNext(dailyTasks);
  }
}
