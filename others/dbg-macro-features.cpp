/* reference: github.com/sharkdp/dbg-macro */

// MULTIPLE ARGUMENTS
// You can pass multiple arguments to the dbg(…) macro. The output of dbg(x, y, z) is same as dbg(x); dbg(y); dbg(z);:

dbg(42, "hello world", false);

// Note that you have to wrap "unprotected commas" in parentheses:

dbg("a vector:", (std::vector<int>{2, 3, 4}));

// HEXADECIMAL, OCTAL & BINARY FORMAT
// If you want to format integers in hexadecimal, octal or binary representation, you can simply wrap them in dbg::hex(…), dbg::oct(…) or dbg::bin(…):

const uint32_t secret = 12648430;
dbg(dbg::hex(secret));

// PRINTING TYPE NAMES
// dbg(…) already prints the type for each value in parenthesis. 
// But sometimes you just want to print a type (maybe because you don't have a value for that type). 
// In this case, you can use the dbg::type<T>() helper to pretty-print a given type T. 
// For example:

template <typename T>
void my_function_template() {
  using MyDependentType = typename std::remove_reference<T>::type&&;
  dbg(dbg::type<MyDependentType>());
}

// PRINT CURRENT TIME

dbg(dbg::time());

// CUSTOMIZATION
// If you want dbg(…) to work for your custom datatype, you can simply overload operator<< for std::ostream&:

std::ostream& operator<<(std::ostream& out, const user_defined_type& v) {
  out << "…";
  return out;
}

// If you want to modify the type name that is printed by dbg(…), you can add a custom get_type_name overload:

// Customization point for type information
namespace dbg {
    std::string get_type_name(type_tag<bool>) {
        return "truth value";
    }
}
