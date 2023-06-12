#pragma once
#include "TinyApp.h"
#include <TinyTerm.h>
#include <TinyConsole.h>
#include <string>
#include <vector>
#include <map>

namespace tiny_bash
{

using string=std::string;

class TinyBash : public TinyApp
{
  public:
    TinyBash(TinyTerm& term, const TinyEnv& e);
    virtual ~TinyBash() {}
    void onKey(TinyTerm::KeyCode) override;
    void onMouse(const TinyTerm::MouseEvent&) override;
    void loop() override;

    void prompt() const;

  private:
    string getWordEx(string& s, char sep=' ') const;  // expand $env vars
    string buildPrompt(string ps1) const;
    void onCommandInt(const string& s);
    void onCommand(const string& s);
    mutable TinyConsole console;
};

class CmdArg
{
  public:
    CmdArg(const char* cmd) : cmd_(cmd), args_(nullptr) {}
    CmdArg(const char* cmd, const char* args)
    : cmd_(cmd), args_(args) {}

    const char* cmd() const { return cmd_; }
    const char* args() const { return args_; }

    friend bool operator <(const CmdArg& l, const CmdArg& r)
    { return strcmp(l.cmd_, r.cmd_) < 0; }
    friend bool operator ==(const CmdArg& l, const CmdArg& r)
    { return strcmp(l.cmd_, r.cmd_)==0; }
    friend Stream& operator << (Stream& out, const CmdArg& l)
    { out << l.cmd_ << ' ' << (l.args_ ? l.args_ : ""); return out; }

  private:
    const char* cmd_;
    const char* args_;
};


}