#pragma once
#include <string>
#include <functional>

// Open a file and call fun for each line of it
void forEachLine(const std::string name, std::function<void(const std::string&)> fun);

// Call a function for each file of cwd
int forEachFile(const std::string& cwd, std::string& args, std::function<bool(std::string& name)> fun);

// Return a filename with quotes if starting or ending by space
// suitable for display only
std::string quotedFileName(const std::string& name);

// remove useless dots ec: /tmp/dir/../folder -> /tmp/folder
std::string removeRedundantDots(std::string path);

std::string basename(const std::string& file);

// compute filename with current dir and filename
std::string getFile(const std::string& cwd, std::string &args);