#pragma once
#include <iostream>
#include <fstream>
#include <string>

void print(const std::string& text, std::ostream& out = std::cout);
void print(const std::string& text, const std::string& filename);
