#pragma once
#include "TinyTerm.h"
#include <map>
#include <string>

namespace tiny_bash
{

#undef stdout
#undef stderr
#undef stdin

extern Stream* stdout;
extern Stream* stderr;
extern Stream* stdin;

struct TinyEnv
{
	std::string cwd = "/";
  std::map<std::string,std::string> exports;
};

class TinyApp
{
	public:
#if defined(EPOXY_DUINO)
		using Pid = const uint64_t;
#else
		using Pid = const uint32_t;
#endif
		TinyApp(TinyTerm*, const TinyEnv& e);
		virtual ~TinyApp();

		enum AppState { RUNNING, FREEZE, ENDED };

		AppState state() const { return state_; }
		void terminate();
		virtual void onKey(TinyTerm::KeyCode) = 0;
		virtual void onMouse(const TinyTerm::MouseEvent&) {}
		virtual void loop() {}

		Pid pid() const { return (Pid)this; }

	protected:
		TinyEnv env;
		TinyTerm* term;

	private:
		TinyTerm::CallBackKey cb;
		TinyTerm::CallBackMouse cbm;
		AppState state_;
};

}