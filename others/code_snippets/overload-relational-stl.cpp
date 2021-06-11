// overloading relational operator for a STL class
bool operator<(const Name &rhs) const { return value < rhs.value; }
bool operator==(const Name &rhs) const { return value == rhs.value; }
