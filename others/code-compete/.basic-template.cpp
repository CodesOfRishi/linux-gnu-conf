#include <iostream>

#if __has_include("/home/rishi/.local/include/dbg.h")
#ifndef DBG_MACRO_NO_WARNING
#define DBG_MACRO_NO_WARNING
#endif
#include "/home/rishi/.local/include/dbg.h"
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
