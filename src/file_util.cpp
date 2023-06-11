#include "file_util.h"
#include "string_util.h"
#include "TinyStreaming.h"
#include <TinyTerm.h>
#include <vector>

#undef stdout
#undef stderr
#undef stdin

extern TinyTerm Term; // FIXME what if not exists ? maybe use stderr etc...

using string=std::string;

void forEachLine(const string name, std::function<void(const std::string&)> fun)
{
  char cr=0;
  string line;
  File f=FILE_SYSTEM.open(name.c_str(), "r");
  if (not f)
  {
    Term << "error: cannot open file " << name << endl;
    return;
  }
  while(f.available())
  {
    char c=(char)f.read();
    if (c==cr or c==13 or c==10)
    {
      if (cr==0) { cr=c; }
      if (cr==c) fun(line);
      line.clear();
    }
    else
      line+=c;
  }
}

string getFile(const std::string& cwd, std::string &args)
{
  string name=getWord(args);
  if (name.length() == 0) return "";
  if (name[0]=='/') return name;
  if (cwd.length()==0) return '/'+name;
  if (cwd[cwd.length()-1]=='/') return cwd+name;
  return cwd+'/'+name;
}

int forEachFile(const string& cwd, std::string& args, std::function<bool(std::string& name)> fun)
{
  int count=0;
  while(args.length())
  {
    string name=getFile(cwd, args);
    if (FILE_SYSTEM.exists(name.c_str()))
    {
      if (not fun(name)) break;
    }
    else
      Term << "File not found " << quotedFileName(name) << endl;  // TODO name of file
    count++;
  }
  return count;
}

string quotedFileName(const std::string& name)
{
  if (name[name.length()-1]==' ' or name[0]==' ')
    return '\''+name+'\'';
  return name;
};

string basename(const std::string& file)
{
  auto pos=file.find_last_of('/');
  if (pos==string::npos) return file;
  return file.substr(pos+1);
}

string removeRedundantDots(string path)
{
    std::vector<string> dirs;
    string dir;
    string result;
    bool start = (!path.empty() && path[0] == '/');

    while (path.length())
    {
      dir=getWord(path, '/');
        if (dir == ".." && !dirs.empty())
          dirs.pop_back();
        else if (dir.length())
          dirs.push_back(dir);
    }
    for (const string& dir : dirs) {
      if (result.length()) result += '/';
        result += dir;
    }

    if (start) result = "/" + result;

    return result;
}


