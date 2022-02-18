#include <iostream>
template <typename T1, typename T2> class Pair {
  T1 first;
  T2 second;

public:
  Pair(T1 a, T2 b) : first(a), second(b) {}
  bool operator<(Pair p) {
    return (this->first < p.first) ||
           (this->first == p.first && this->second < p.second);
  }
};
int main() {
  Pair<int, char> p1(5, 'z'), p2(4, 'b');
  std::cout << (p1 < p2) << std::endl;
  return 0;
}
