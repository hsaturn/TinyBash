#include "TinyBash.h"

tiny_bash::TinyBash* bash;

void setup()
{
  Term.begin(Serial);
  bash = new tiny_bash::TinyBash(Term, {});
}

void loop()
{
  bash->loop();
  Term.loop();
}
