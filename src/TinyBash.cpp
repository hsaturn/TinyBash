#include "TinyBash.h"
#include <Arduino.h>
#include <TinyConsole.h>
#include <TinyStreaming.h>
#include <TinyVim.h>
#include <string_util.h>
#include "file_util.h"

#if ESP32
  #include <ESP32Ping.h>  // marian-craciunescu/ESP32Ping 
  long stacksize() { return CONFIG_ARDUINO_LOOP_STACK_SIZE; }
#elif defined(EPOXY_DUINO)
#include <sys/resource.h>
  void reset() {}
  auto stacksize()
  { rlimit l; getrlimit(RLIMIT_STACK, &l); return l.rlim_cur; }
#else
  #include <ESP8266Ping.h>  // dancol90/ESP8266Ping 
  #include <ESP8266HTTPClient.h>  // for wget
  #include <WiFiClientSecureBearSSL.h> // for wget
  long stacksize() { return CONFIG_ARDUINO_LOOP_STACK_SIZE; }
#endif
#include <TinyVim.h>
#include <vector>

namespace tiny_bash
{

string TinyBash::getWordEx(std::string& s, char sep) const
{
  string r=getWord(s,sep);
  if (sep!='\'' and s.find('$')!=string::npos)
  {
    for(auto it: exports) replace(r, '$'+it.first, it.second);
    for(auto it: exports) replace(r, "${"+it.first+'}', it.second);
  }
  return r;
}

#ifdef ESP32
size_t freemem() { return esp_get_free_heap_size(); }
void reset() { ESP.restart(); }
#elif defined(EPOXY_DUINO)
size_t freemem() {
    long pages = sysconf(_SC_PHYS_PAGES);
    long page_size = sysconf(_SC_PAGE_SIZE);
    return pages * page_size;
}
#else
size_t freemem() { return system_get_free_heap_size(); }
void reset() { ESP.reset(); }
#endif

static std::map<string,string> exports;

void lorem(int numSentences, int words, int paras, Stream* out) {
  std::vector<String> loremIpsumWords = {
      F("lorem"), F("ipsum"), F("dolor"), F("sit"), F("amet"), F("consectetur"), F("adipiscing"), F("elit"),
      F("sed"), F("labore"), F("et"), F("dolore"), F("magna"), F("ut"), F("enim"), F("minim"), F("quis"), F("nisi"),
      F("ex")
  };

  *out << "Lorem ipsum";
  bool maj=false;
  bool spc=false;
  while(paras-->0)
  {
    for(int i=0; i<numSentences; i++)
    {
        int numWords = rand() % words + 5;
        for (int j = 0; j < numWords; ++j) {
            int randomIndex = rand() % loremIpsumWords.size();
            if (spc) *out << ' ';
            *out << (char)(loremIpsumWords[randomIndex][0] & (maj ? ~32 : 0xFF));
            *out << loremIpsumWords[randomIndex].substring(1);
            spc = true;
        }
        *out << '.';
        maj=true;
    }
    *out << endl;
    spc=false;
  }
}

string TinyBash::buildPrompt(string ps1) const
{
  static uint16_t count=0;
  string prompt;
  while(ps1.length())
  {
    if (ps1[0] == '\\' and ps1.length()>1)
    {
      switch(ps1[1])
      {
        case 'u': break; // user
        case 'h': 
          #ifdef ESP32
            prompt+="esp32";
          #else
            prompt+="esp";
          #endif
          break;
        case 'd': break; // date
        case 't': prompt += std::to_string(millis()/1000.0); break;
        case 'n': prompt += "\r\n"; break;
        case 's': prompt += "TinyBash"; break;
        case '#': prompt += std::to_string(count); break; // count commands
        case '$': prompt += '>'; break;
        case 'W': prompt += env.cwd.substr(1); break;
        default:
          prompt += '\\' + ps1[1];
      }
      ps1.erase(0,1);
    }
    else
      prompt+=ps1[0];
    ps1.erase(0,1);
  }
  count++;
  return prompt;
}


static tiny_vim::Window vim_win(0,0,0,0);
static tiny_vim::Splitter main_splitter(false, 20);
void resizeVimTerm()
{
  if (vim_win.top==0)
  {
    vim_win.top=1;
    vim_win.left=1;
    vim_win.width=Term.sx;
    vim_win.height=Term.sy;
  };
}

const TinyTerm::Color white=TinyTerm::white;
const TinyTerm::Color cyan=TinyTerm::cyan;

std::list<TinyApp*> apps;

char hdig(char c)
{
  if (c<10) return '0'+c;
  return 'A'+c-10;
}

void TinyBash::onCommand(const string& s)
{

  console << endl;
  onCommandInt(s);
  // FIXME
  if (apps.size()==0)
    prompt();
  else
    console.setPrompt(nullptr);
}

void TinyBash::onCommandInt(const string& s)
{
  static string path="/bin:.";
  static string oldpwd;

  string s2 = s;
  trim(s2);
  if (s2.length()==0) return;
  string args;
  while(s2.length())
  {
    char q=s2[0];
    string arg=getWordEx(s2);
    if (arg==">" or arg==">>")
    {
      File redir = LittleFS.open(getFile(env.cwd, s2).c_str(), arg==">" ? "w" : "a");
      if (redir)
      {
        Stream* old=stdout;
        stdout=&redir;
        onCommandInt(args);
        stdout=old;
        *stdout << endl;
        return;
      }
    }
    else
    {
      if (args.length()) args+=' ';
      if (arg.find(' ')!=string::npos)
        args += q + arg + q;
      else
        args += arg;
    }
  }

  static std::map<CmdArg, std::function<void(string&)>> commands =
  {
    { {"int", "expr"}, [](string& args) {
      *stdout << args << '=';
      long l = getInt(args);
      *stdout << l << ", " << hex(l) << endl;
    }},
#ifdef TINY_BASH_PING
    { "ping", [](string& args) {
      if (Ping.ping(args.c_str()))
      *stdout << "Ping " << args << ": " << Ping.averageTime() << "ms" << endl;
      else
        *stdout << "unable to join " << args << endl;
      }
    },
#endif
    { {"print_at", "x y str"}, [](string& args)
    {
      Term.saveCursor();
      Term.gotoxy(getInt(args), getInt(args));
      Term << args;
      Term.restoreCursor();
    }
    },
    { {"s", "help"}, [](string& args) {    // Testing Vim splitters
      resizeVimTerm();
      string cmd=getWord(args);
      string arg;

      if (cmd=="?" or cmd=="help")
      {
        Term << "main" << endl;
        Term << "draw" << endl;
        Term << "calc wid" << endl;
        Term << "dump / dump2" << endl;
        Term << "split wid v|h size" << endl;
        Term << "show wid" << endl;
        Term << "term [dx dy [w h]]" << endl;
      }
      else if (cmd == "draw")
      {
        main_splitter.draw(vim_win, Term);
        Term << endl;
      }
      else if (cmd == "term")
      {
        if (args.length())
        {
          int16_t dx = getInt(args);
          int16_t dy = getInt(args);
          if (args.length())
          {
            int16_t w = getInt(args);
            int16_t h = getInt(args);
            if (w && h)
              vim_win = tiny_vim::Window(dy, dx, w, h);
            else
              *stdout << "invalid" << endl;
          }
          else
          {
            vim_win.left += dx;
            vim_win.top += dy;
            vim_win.width -= 2*dx;
            vim_win.height -= 2*dy;
          }
        }
        vim_win.frame(Term);
        *stdout << vim_win << endl;
      }
      else if (cmd == "calc")
      {
       uint16_t wid=getInt(args);
        if (wid)
        {
          Term << "calc " << hex(wid) << " from " << vim_win << endl;
          bool result = main_splitter.calcWindow(wid, vim_win);
          Term << (result ? "ok " : "ko ") << vim_win << endl;
        }
        else
          Term << "bad wid" << endl;
      }
      else if (cmd == "split")
      {
        uint16_t wid = getInt(args);
        string dir=getWord(args);
        uint16_t size=getInt(args);
        if (size and (dir == "v" or dir == "h"))
          Term << "split=" << (int)main_splitter.split(wid, dir[0], size) << endl;
        else
          Term << "split error in args " << args << endl;
      }
      else if (cmd=="dump") main_splitter.dump(vim_win);
      else if (cmd=="dump2") main_splitter.dump2(vim_win);
      else *stdout << "Unknown command (" << cmd << ")" << endl;
    }},
    { "reset", [](string& args) { reset(); }},
    { "echo", [](string& args) {
        while(args.length())
        {
          *stdout << getWord(args);
          if (args.length()) *stdout << ' ';
        }
        *stdout << endl;
      }},
    { "export" , [this](string& args) {
      string id=getIdentifier(args);
      if (id.length() and args[0]=='=')
      {
        args.erase(0,1);
        exports[id]=getWord(args);
      }
      else
        *stderr << "error" << endl;
    }},
    { "unset", [this](string& args) {
      string id=getIdentifier(args);
      if (id.length())
      {
        auto it=exports.find(id);
        if (it != exports.end()) exports.erase(it);
      }

    }},
    { "path", [](string& args) {
      if (args.length())
        path=getWord(args);
      else
        *stdout << path << endl;
    }},
    { { "test" }, [](string&)
    {
      class App : public TinyApp
      {
        public:
          App(TinyTerm* term) : TinyApp(term, env) {}
          void onKey(TinyTerm::KeyCode) {}
      };

      *stdout << "m: free mem " << freemem() << endl;
      delete(new App(&Term));
      *stdout << "m: free mem " << freemem() << endl;
    }},
    { { "vim", "files"}, [this](string& args) {
      string files=""; // TODO list<string> should be better
      apps.push_back(new TinyVim(&Term, env, args));
  }},
    { { "head", "+n|-n file"}, [this](string& args) {
      int rows=getInt(args);
      forEachLine(getFile(env.cwd, args), [&rows](const string& line)
      { if (rows++<0) *stdout << line << endl; });
    }},
    { { "nl", "file"}, [this](string& args)
    {
      int row=1;
      forEachLine(getFile(env.cwd, args), [&row](const string& line)
      {
        *stdout << (row<10 ? "  " : ( row<100 ? " " : ""));
        *stdout << row++ << ' ' << line << endl;
      });
    }},
    { "clear", [](string& args) { Term.clear(); }},
    { { "tail", "+n|-n file"}, [this](string& args) {
      int from=0;
      if (args[0]=='+')
        args.erase(0,1);
      int rows=-getInt(args);
      if (rows>0)
      {
        std::list<string> tail;
        forEachLine(getFile(env.cwd, args), [&rows,&tail](const string& line)
        {
          if (tail.size() >= (size_t)rows) tail.pop_front();
          tail.push_back(line);
        });
        for(const auto& s: tail) *stdout << s << endl;
      }
      else
      {
        from=-rows;
        rows=1;
        forEachLine(getFile(env.cwd, args), [&rows,&from](const string& line)
        {
          if (rows++>=from) *stdout << line << endl;
        });
      }
    }},
    { "df", [](string&) {
      #ifdef ESP32
        *stdout << LittleFS.usedBytes() << " bytes on " <<  LittleFS.totalBytes()
          << ", free: " << LittleFS.totalBytes()-LittleFS.usedBytes() << endl;
      #else
        FSInfo infos;
        LittleFS.info(infos);
        *stdout << infos.usedBytes << " bytes on " <<  infos.totalBytes
          << ", free: " << infos.totalBytes-infos.usedBytes << endl;
      #endif
    }},
    { { "mv", "file file"}, [this](string& args) {
      string source=getFile(env.cwd, args);
      string dest=getFile(env.cwd, args);
      auto dir=LittleFS.open(dest.c_str(), "r");
      if (dir.isDirectory()) dest += '/' + basename(source);
      dir.close();
      if (dest.length() and LittleFS.rename(source.c_str(), dest.c_str()))
        return;
      else
        *stdout << "error mv " << source << ' ' << dest << endl;
    }},
    { { "ls", "[files]"} , [this](string& args)
    #ifdef ESP32
      {
       if (args.length()==0) args=env.cwd;
        forEachFile(env.cwd, args, [](const string& name)->bool
        {
          if (LittleFS.exists(name.c_str()))
          {
            std::map<String, string> files;
            std::map<String, string> dirs;
            File dir = LittleFS.open(name.c_str());
            while (true)
            {
              File entry = dir.openNextFile();
              if (not entry) break;
              string size=std::to_string(entry.size());
              while(size.length()<6) size=' '+size;
              if (entry.isDirectory())
                dirs[entry.name()] = size;
              else
                files[entry.name()] = size;
            }
            if (dirs.size())
            {
              if (stdout==&Term) Term << cyan;
              for(auto file: dirs) *stdout << file.second << ' ' << quotedFileName(file.first.c_str()) << endl;
              if (stdout==&Term) Term << white;
            }
            for(auto file: files) *stdout << file.second << ' ' << quotedFileName(file.first.c_str()) << endl;
          }
          return true;
        });
      }
    #else
      {
        if (args.length()==0) args=env.cwd;
        forEachFile(env.cwd, args, [](const string& name)->bool
        {
          if (LittleFS.exists(name.c_str()))
          {
            std::map<String, string> files;
            Dir dir = LittleFS.openDir(name.c_str());
            if (stdout==&Term) Term << cyan;
            while (dir.next())
            {
              string size=std::to_string(dir.fileSize());
              while(size.length()<6) size=' '+size;
              if (dir.isDirectory())
                *stdout << size << ' ' << dir.fileName() << '/' << endl;
              else
                files[dir.fileName()] = size;
            }
            if (stdout==&Term) Term << white;
            for(auto file: files)
            {
              *stdout << file.second << ' ';
              if (file.first[file.first.length()-1]==' ')
                *stdout << '\'' << file.first << '\'' << endl;
              else
                *stdout << file.first << endl;
            }
          }
          return true;
        });
      }
    #endif
    },
    { "yield", { [](string& args)
    {
      int n=getInt(args);
      do
      {
        *stdout << "yield " << n-- << ',' << endl;
        yield();
      } while(n);
    }}},
    /* WGET HTTPS
    { "wget", [](string& args) {
      if (args.length()==0) return;
      string output=env.cwd+'/'+basename(args);
      Console << "output file: " << output << '.' << endl;
      File out = LittleFS.open(output.c_str(), "w");
      BearSSL::WiFiClientSecure client;
      client.setInsecure();
      HTTPClient https;
      if (out and https.begin(client, args.c_str()))
      {
        int rep = https.GET();
        if (rep>0)
        {
          String payload = https.getString();
          out.write(payload.c_str());
        }
        else
          *stderr << "error " << rep << endl;
      }
      else if (out)
        *stderr << "Unable to connect" << endl;
    }},
        */
    { { "wc" , "files"}, [this](string& args) {
      forEachFile(env.cwd, args, [](const string& name) -> bool
      {
        File file=LittleFS.open(name.c_str(), "r");
        int cr=0;
        bool word=false;
        int lines=0; int words=0; int chars=0;
        if (file)
        {
          while(file.available())
          {
            chars++;
            char c=(char)file.read();
            if (c==cr or c==13 or c==10)
            {
              if (cr==0) cr=c;
              if (word) { words++; word=false;
              }
              if (cr==c) lines++;
            }
            else if (c==' ')
            { if (word) { words++; word=false; } }
            else
              word=true;
          }
          *stdout << lines << ' ' << words << ' ' << chars << ' ' << name << endl;
        }
        else
          *stderr << '?' << name << endl;
        return true;
      });
    }},
    { { "cd", "dir"}, [this](string& args) {
      string dir;
      if (args=="-")
        dir=oldpwd;
      else
        dir=getFile(env.cwd,args);
      oldpwd=env.cwd;
      if (dir.length()==0)
      {
        env.cwd="/";
        return;
      }
      if (dir[dir.length()-1] != '/') dir += '/';
      if (LittleFS.exists(dir.c_str()))
        env.cwd=removeRedundantDots(dir);
      else
        *stderr << "not found:" << dir << endl;
    }},
    { { "hexdump", "file"}, [this](string& args) {
      forEachFile(env.cwd, args, [](const string& name)->bool
      {
        File f=LittleFS.open(name.c_str(),"r");
        if (f)
        {
          int count=0;
          *stdout << name << endl;
          string ascii;
          while(f.available())
          {
            char c=f.read();
            if ((count%2)==0) *stdout << ' ';
            if ((count%16)==0)
            {
              *stdout << ' ' << ascii << endl;
              ascii.clear();
            }
            *stdout << hdig(c>>4) << hdig(c&0xF);
            if (c>=32 and c<=128)
              ascii+=c;
            else
              ascii+='.';
            count++;
          }
          while(count%16)
          {
            if (count%2==0) *stdout << ' ';
            *stdout << "  ";
            count++;
          }
          *stdout << ' ' << ascii << endl << endl;
        }
        return true;
      });
    }},
    { { "cat", "files" }, [this](string& args) {
        forEachFile(env.cwd, args, [](const string& name)->bool
        {
          forEachLine(name, [](const string& line)
          {
            *stdout << line << endl;
          });
          return true;
        });
    }},
    { {"lorem", "sentences words paragraphs"}, [](string& args) {
      int sentences=getInt(args, 5);
      int words = getInt(args, 5);
      int para = getInt(args, 1);
      if (words)
        lorem(sentences, words, para, stdout);
      else
        *stdout << "bad words param" << endl;
      *stdout << endl;
    } 
    },
    { "pwd", [this](string& args) { *stdout << env.cwd << endl; }},
    { "free", [](string& args) {
      *stdout << "Stack size " << stacksize() << endl;
      *stdout << "m: free mem " << freemem() << endl;
    }},
    { { "ansi", "str"}, [](string& args){
      static const char* CSI="\033[";
      Term << CSI << args;
    }},
    { "termcap", [](string& args) {
      *stdout << "term " << (Term.isTerm() ? "yes" : "no") << ", csi=" << Term.csi << endl;
      *stdout << "size=" << Term.sx << 'x' << Term.sy << endl;
      if (args!="")
      {
        *stdout << "Sending ask termsize" << endl;
        Term.getTermSize();
      }
    }},
    { "help", [](string& args) {
        *stdout << "List of commands: ";
        bool hasHelp = false;
        for(auto cmd: commands)
        {
          if (cmd.first.args() or hasHelp)
            *stdout << endl;
          else
            *stdout << "/ ";

          *stdout << cmd.first;
          hasHelp = cmd.first.args() != nullptr;
        }
        *stdout << endl;
    }},
    { {"touch", "file"}, [this](string& args) {
      while(args.length())
      {
        string name=getFile(env.cwd,args);
        File file = LittleFS.open(name.c_str(), "w+");
        if (not file) *stderr << "Error touching " << name << endl;
        file.close();
      }
    }},
    { { "append", "file str"}, [this](string& args){
      string name=getFile(env.cwd, args);
      if (name.length()==0) return;
      File f=LittleFS.open(name.c_str(),"a");
      if (f)
      {
        args+="\n\r";
        f.write((uint8_t*)args.c_str(), args.length());
      }
      else
        *stderr << "error" << endl;
    }},
    { {"create", "file rows str"}, [this](string& args){
      string name=getFile(env.cwd, args);
      if (name.length()==0) return;
      File f=LittleFS.open(name.c_str(),"w");
      if (f)
      {
        int t=atol(args.c_str());
        getWord(args);
        args+="\n\r";
        while(t--)
          f.write((uint8_t*)args.c_str(), args.length());
      }
      else
        *stderr << "error creating " << name << endl;
    }},
    { { "mkdir", "dir" }, [this](string& args) {
      while(args.length())
      {
        string name=getFile(env.cwd, args);
        if (not LittleFS.mkdir(name.c_str())) *stderr << "error" << endl;
      }
    }},
    { {"rmdir", "dir"}, [this](string& args) {
      while(args.length())
      {
        string name=getFile(env.cwd, args);
        if (not LittleFS.rmdir(name.c_str())) *stderr << "error " << name << endl;
      }
    }},
    { {"rm", "file"}, [this](string& args) {
      while(args.length())
      {
        string name=getFile(env.cwd, args);
        LittleFS.remove(name.c_str());
      }
    }},
    { "format", [](string& args) { LittleFS.format(); }},
  };
  string cmd = getWord(args);

  bool found = false;
  for(auto it: commands)
  {
    if (it.first == cmd.c_str())
    {
      found = true;
      it.second(args);
    }
  }
  if (not found)
  {
    string paths=path;
    string name = getWord(cmd);
    if (name.substr(0,2)=="./") name=env.cwd+'/'+name.substr(2);
    while(paths.length())
    {
      string p=getWord(paths, ':');
      string path_name;
      if (name[0]=='/')
        path_name=name;
      else if (p[0]=='/')
        path_name=p+'/'+name;
      else
        path_name=env.cwd+'/'+p+'/'+name;
      if (LittleFS.exists(path_name.c_str()))
      {
        found=true;
        File file = LittleFS.open(path_name.c_str(), "r");
        cmd.clear();
        while (file.available())
        {
          char c = (char)file.read();
          if (c == 13 or c == 10)
          {
            if (cmd.length())
            {
              if (args.length()) args=' '+args;
              onCommandInt(cmd);
            }
            cmd.clear();
          }
          else
            cmd += c;
        }
        break;
      }
    }
    if (not found)
      *stderr << "Command not found '" << name << "'" << endl;
  }
}

void TinyBash::prompt() const
{
  auto it=exports.find("PS1");
  if (it != exports.end())
    console.setPrompt(buildPrompt(it->second).c_str());
  console.prompt();
}

void TinyBash::onKey(TinyTerm::KeyCode k)
{
  Term << "TinyBash::onKey " << k << endl;
}

void TinyBash::onMouse(const TinyTerm::MouseEvent& evt)
{
  resizeVimTerm();

  tiny_vim::Cursor coords(evt.y, evt.x);
  tiny_vim::Window tmp_term(vim_win);
  auto wid = main_splitter.findWindow(tmp_term, coords);
  Term.saveCursor();
  Term.gotoxy(1, Term.sx/3);
  Term << "mouse " << hex(evt.value) << ' ' << coords
    << ", vim_win:" << hex(wid) << ' ' << tmp_term << "    " << endl;
  Term.restoreCursor();
}

TinyBash::TinyBash(TinyTerm& term, const TinyEnv& e) : TinyApp(&term,e), console(&term)
{
  console.setCallback([this](const string& cmd) { onCommand(cmd); });
  Term.onMouse([this](const TinyTerm::MouseEvent& event) { onMouse(event); });
  if (!LittleFS.begin())
  {
    log_e("a");
    console << "Unable to mount fs" << endl;
  }
  #if ESP32
    esp_log_level_set("*", ESP_LOG_NONE);
  #endif
  stdout=&Term;
  stderr=&Term;
  stdin=&Term;
  onCommand("/etc/shrc");
  esp_log_level_set("*", ESP_LOG_NONE);
}

void TinyBash::loop()
{
  for(auto it=apps.begin(); it!=apps.end(); it++)
  {
    TinyApp* app=*it;
    app->loop();
    if (app->state() == TinyApp::ENDED)
    {
      Term << "app " << app->pid() << " ended" << freemem() << endl;
      delete app;
      apps.erase(it);
      if (apps.size()==0) prompt();
    }
  }
}

} // ns tiny_bash