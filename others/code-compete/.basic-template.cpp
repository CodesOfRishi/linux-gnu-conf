#include <iostream>

#if __has_include("/home/rishi/.local/include/dbg.h")
#ifndef DBG_MACRO_NO_WARNING
#define DBG_MACRO_NO_WARNING
#endif
#include "/home/rishi/.local/include/dbg.h"

#ifdef _GLIBCXX_STACK
template<typename T>
std::ostream& operator<<(std::ostream& out, std::stack<T> _st) {
	out << "{";
	while (!_st.empty()) {
		out << _st.top();
		_st.pop();

		if (!_st.empty()) out << " ";
	}
	out << "}";
	return out;
}
#endif

#ifdef _GLIBCXX_QUEUE
template<typename T>
std::ostream& operator<<(std::ostream& out, std::priority_queue<T> _pq) {
	out << "{";
	while (!_pq.empty()) {
		out << _pq.top();
		_pq.pop();

		if (!_pq.empty()) out << " ";
	}
	out << "}";
	return out;
}
#endif

#else 
template<typename... Types> void dbg(const Types&... x) { /* nothing!! */ }
#endif

using namespace std;

int main() {
	ios_base::sync_with_stdio(false);
	cin.tie(nullptr);

	//
	return 0;
}
