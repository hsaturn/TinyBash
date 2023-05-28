#include "string_util.h"

using string=std::string;

void trim(string& s)
{
  while(s.length() and s[0]==' ') s.erase(0,1);
}

int getInt(string& args, int def)
{
  bool minus=false;
  if (args[0]=='-')
  {
    minus=true;
    args.erase(0,1);
  }
  int base=10;
  int (* fun)(int c) = isdigit;
  if (args.length()==0) return def;
  if (args[0]=='0' and args[1]=='x')
  {
    fun=isxdigit;
    base=16;
    args.erase(0,2);
  };
  int r=0;
  while(args.length() and fun(args[0]))
  {
    int d;
    if (base==16)
    {
      d=(args[0] | 32);
      if (d>='a')
        d=d-'a'+10;
      else
        d=d-'0';
    }
    else
      d=args[0]-'0';

    r = r*base+d;
    args.erase(0,1);
  }
  trim(args);
  if (minus) r=-r;
  return r ? r : def;
}

void replace(string& str, const string& oldStr, const std::string& newStr)
{
    size_t pos = 0;
    while ((pos = str.find(oldStr, pos)) != string::npos) {
        str.replace(pos, oldStr.length(), newStr);
        pos += newStr.length();
    }
}

string getIdentifier(string& s)
{
  string id;
  while(s.length())
  {
    if (isalnum(s[0]) or s[0]=='_')
    {
      id+=s[0];
      s.erase(0,1);
    }
    else
      break;
  }
  return id;
}

string getWord(string& s, char sep)
{
  trim(s);
  if (s.length()==0) return "";
  string r;
  if (s[0]=='"' or s[0]=='\'')
  {
    sep=s[0];
    s.erase(0,1);
  }
  auto pos=s.find(sep);
  if (pos == string::npos) pos=s.length();
  r=s.substr(0, pos);
  s.erase(0,pos+1);
  trim(s);
 return r;
}

