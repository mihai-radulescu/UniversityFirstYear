#include "StateManager.h"
#include "Menu.h"
int main()
{
	edy::core::StateManager app;
	app.pushTop(new edy::state::MenuState);
	app.gameRun();
}


/// scorurile nu se salveaza corect
