#pragma once
#include "TinyTerm.h"

namespace tiny_bash
{

#undef stdout
#undef stderr
#undef stdin

extern Stream* stdout;
extern Stream* stderr;
extern Stream* stdin;

class TinyApp
{
	public:
		using Pid = const uint32_t;
		TinyApp(TinyTerm*);
		virtual ~TinyApp();

		enum AppState { RUNNING, FREEZE, ENDED };

		AppState state() const { return state_; }
		void terminate();
		virtual void onKey(TinyTerm::KeyCode) = 0;
		virtual void onMouse(const TinyTerm::MouseEvent&) {}
		virtual void loop() {}

		Pid pid() const { return (Pid)this; }

	protected:
		TinyTerm* term;

	private:
		TinyTerm::CallBackKey cb;
		TinyTerm::CallBackMouse cbm;
		AppState state_;
};

}