#include "TinyApp.h"

namespace tiny_bash
{
  Stream* stdout;
  Stream* stdin;
  Stream* stderr;
  
TinyApp::TinyApp(TinyTerm* term, const TinyEnv& e)
  : env(e)
  , term(term)
  , state_(RUNNING)
{
  if (term)
  {
    cb = term->onKey([this](TinyTerm::KeyCode c) { this->onKey(c); });
    cbm = term->onMouse([this](const TinyTerm::MouseEvent& e) { this->onMouse(e); });
  }
}

TinyApp::~TinyApp()
{
  if (term)
  {
    term->onKey(cb);
    term->onMouse(cbm);
  }
}

void TinyApp::terminate()
{
  state_ = ENDED;
}

} // ns tiny_bash