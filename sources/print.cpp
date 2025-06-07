#include "print.hpp"

void print(const std::string& text, std::ostream& out) {
    out << text;
}

void print(const std::string& text, const std::string& filename) {
    std::ofstream out(filename);
    print(text, out);
}
