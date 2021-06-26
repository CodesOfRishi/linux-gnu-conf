#include <iostream>
#include <iomanip>
#include <vector>
#include <array>
#include <deque>
#include <list>
#include <set>
#include <unordered_set>
#include <map>
#include <unordered_map>
#include <stack>
#include <queue>
#include <string>
#include <cctype>
#include <sstream>
#include <cmath>
#include <climits>
#include <cfloat>
#include <iterator>
#include <algorithm>
#include <numeric>
#include <cassert>

#ifndef DBG_MACRO_NO_WARNING
#define DBG_MACRO_NO_WARNING
#endif

#if __has_include("/home/rishi/.local/include/dbg.h")
#include "/home/rishi/.local/include/dbg.h"
#else 
template<typename... Types> void dbg(const Types&... x) { /* nothing!! */ }
#endif

using namespace std;

typedef long long ll;
typedef unsigned long long ull;
typedef unsigned uint;
typedef long double l_double;

#define gcd __gcd
#define FFS(var) __builtin_ffs(var)
#define CLZ(var) __builtin_clz(var)
#define CTZ(var) __builtin_ctz(var)
#define POPCOUNT(var) __builtin_popcount(var)
#define all(v) v.begin(), v.end()
#define rall(v) v.rbegin(), v.rend()
#define s_cast static_cast // <>
#define endl "\n"

const double PI {3.1415926535897932384626433832795};
const int MOD {static_cast<int>(1e9 + 7)};
const double EPS {1e-9};

/*----------------------------------------- Modular Arithmetic -----------------------------------------*/
template<typename T>
T ModAdd(const T &a, const T &b, const int &mod = MOD) { return ((a)%mod + (b)%mod)%mod; }

template<typename T>
T ModSub(const T &a, const T &b, const int &mod = MOD) { return ((((a%mod) - (b%mod))%mod)+mod)%mod; }

template<typename T>
T ModMul(const T &a, const T &b, const int &mod = MOD) { return ((a%mod) * (b%mod))%mod; }

/*----------------------------------------- Overflow Validation -----------------------------------------*/
template<typename T>
bool AdditionLimitFlow(const T &a, const T &x) {
    T MAXIMUM_INT {a}, MINIMUM_INT {a};
    switch (sizeof(a)) {
        case 8: MAXIMUM_INT = LLONG_MAX; MINIMUM_INT = LLONG_MIN; break;
        case 4: MAXIMUM_INT = INT_MAX; MINIMUM_INT = INT_MIN; break;
        default: cerr << "PARAMETER SHOULD BE EITHER int OR long long !!" << endl; assert(0); break;
    }

    bool overflow {false}, underflow {false};
    if ((x > 0) && (a > MAXIMUM_INT - x)) overflow = true;
    if ((x < 0) && (a < MINIMUM_INT - x)) underflow = true;

    if (overflow) {
        cerr << "OVERFLOW: [" << a << ", " << x << "]" << endl;
        return overflow;
    }
    if (underflow) {
        cerr << "UNDERFLOW: [" << a << ", " << x << "]" << endl;
        return underflow;
    }
    return false;
}

template<typename T>
bool SubstractionLimitFlow(const T &a, const T &x) {
    T MAXIMUM_INT {}, MINIMUM_INT {};
    switch (sizeof(a)) {
        case 8: MAXIMUM_INT = LLONG_MAX; MINIMUM_INT = LLONG_MIN; break;
        case 4: MAXIMUM_INT = INT_MAX; MINIMUM_INT = INT_MIN; break;
        default: cerr << "PARAMETER SHOULD BE EITHER int OR long long !!" << endl; assert(0); break;
    }

    bool overflow {false}, underflow {false};
    if ((x < 0) && (a > MAXIMUM_INT + x)) overflow = true;
    if ((x > 0) && (a < MINIMUM_INT + x)) underflow = true;

    if (overflow) {
        cerr << "OVERFLOW: [" << a << ", " << x << "]" << endl;
        return overflow;
    }
    if (underflow) {
        cerr << "UNDERFLOW: [" << a << ", " << x << "]" << endl;
        return underflow;
    }
    return false;
}

template<typename T>
bool MultiplicationLimitFlow(const T &a, const T &x) {
    T MAXIMUM_INT {}, MINIMUM_INT {};
    switch (sizeof(a)) {
        case 8: MAXIMUM_INT = LLONG_MAX; MINIMUM_INT = LLONG_MIN; break;
        case 4: MAXIMUM_INT = INT_MAX; MINIMUM_INT = INT_MIN; break;
        default: cerr << "PARAMETER SHOULD BE EITHER int OR long long !!" << endl; assert(0); break;
    }

    bool overflow {false}, underflow {false};
    if ((a == -1) && (x == MINIMUM_INT)) overflow = true;
    if ((x == -1) && (a == MINIMUM_INT)) overflow = true;

    if (a > MAXIMUM_INT / x) overflow = true;
    if (a < MINIMUM_INT / x) underflow = true;

    if (overflow) {
        cerr << "OVERFLOW: [" << a << ", " << x << "]" << endl;
        return overflow;
    }
    if (underflow) {
        cerr << "UNDERFLOW: [" << a << ", " << x << "]" << endl;
        return underflow;
    }
    return false;
}
/*-------------------------------------------------------------------------------------------------------*/

template<typename T>
T max(const T &A, const T &B, const T &C) {
    T mx {A};
    (mx < B) && (mx = B);
    (mx < C) && (mx = C);
    return mx;
}

template<typename T>
T min(const T &A, const T &B, const T &C) {
    T mn {A};
    (mn > B) && (mn = B);
    (mn > C) && (mn = C);
    return mn;
}

template<typename T>
int cntDigits(const T &N) { return (static_cast<int>(log10(N)) + 1); }

template<typename T>
bool isPowOfTwo(const T &N) { return (N && (!(N&(N-1)))); }

template<typename T>
bool dblEqual(const T &a, const T &b) { return abs(a - b) < EPS; }

/* -------------------------------------------------------- */
/* -------------------------------------------------------- */

//

void TEST_CASES() {
    //
}

int32_t main() {
    ios_base::sync_with_stdio(false);
    cin.tie(nullptr);
    cerr.setf(std::ios::boolalpha);
    cout << std::fixed;
    cout << std::setprecision(6); // default
    /* ---------------------------------- */

    unsigned TC {1};
    // cin >> TC;
    for (unsigned T {1}; T <= TC; ++T) {
		cout << "Case #" << T << ": ";
		TEST_CASES();
	}
    return 0;
}
