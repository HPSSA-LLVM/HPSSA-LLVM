#include <future>
#include <iostream>
#include <thread>
using namespace std;

void ComputeSum(std::future<pair<int, int>> &_future_value) {
  // Thread gets to use a promise value using a future object.
  auto p = _future_value.get();
  cout << p.first + p.second << endl;
}

int main(void) {
  std::promise<pair<int, int>> _promise;

  // future object get it from promise.
  std::future<pair<int, int>> _future_value = _promise.get_future();

  std::thread WorkerThread(ComputeSum, std::ref(_future_value));

  // Promise value set after thread started.
  _promise.set_value(std::make_pair(10, 58));

  // joining this thread to main thread.
  WorkerThread.join();
  return 0;
}