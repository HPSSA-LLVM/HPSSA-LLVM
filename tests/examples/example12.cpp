#include <atomic>
#include <iostream>
#include <memory>
class node;
class tree;

using nodeptr = std::unique_ptr<node>;
using treeptr = std::unique_ptr<tree>;

// inline is anyways implicit
class node {
  int data = -1;

public:
  nodeptr left;
  nodeptr right;
  inline node() { std::cout << "New node : " << this->data << std::endl; }
  inline node(int data) : data(data) {
    std::cout << "New node : " << this->data << std::endl;
  }
  inline ~node() { std::cout << "Delete Node : " << this->data << std::endl; }
};

class tree {
  int id = -1;

public:
  nodeptr root;
  inline tree() { std::cout << "New tree : " << this->id << std::endl; }
  inline tree(int data) : id(data) {
    std::cout << "New tree : " << this->id << std::endl;
  }
  inline ~tree() { std::cout << "Delete tree : " << this->id << std::endl; }
};

int main(void) {
  std::unique_ptr<tree> treeHandle = std::make_unique<tree>(13);
  treeHandle.get()->root = std::make_unique<node>(15);
  treeHandle.get()->root.get()->left = std::make_unique<node>(23);
  treeHandle.get()->root.get()->right = std::make_unique<node>(41);
  return 0;
}