#pragma once

#include <string>

void trim(std::string& s);
int getInt(std::string& args, int def=0);
void replace(std::string& str, const std::string& oldStr, const std::string& newStr);
std::string getIdentifier(std::string& s);
std::string getWord(std::string& s, char sep=' ');

