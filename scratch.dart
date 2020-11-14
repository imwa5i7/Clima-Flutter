import 'dart:io';

void main() {
  performTasks();
}

void performTasks() async {
  task1();
  String task2Data= await task2();
  task3(task2Data);
}

void task1() {
  String result = 'task 1 data';
  print('Task 1 complete');
}

  Future task2() async  {

  Duration theSeconds=Duration(seconds: 2);
  //it will run in synchronous mode

  // sleep(theSeconds);
  // String result = 'task 2 data';
  // print('Task 2 complete');

  //as future is a async function, so it will definitely run in async mode.
  String result;

  await Future.delayed(theSeconds,(){
    result = 'task 2 data';
    print('Task 2 complete');
  });
  return result;
}

void task3(String task2data) {
  String result = 'task 3 data';
  print('Task 3 complete with $task2data');
}