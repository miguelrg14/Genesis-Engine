#include "gspch.h"
#include "Application.h"

#include "Genesis/Events/ApplicationEvent.h"
#include "log.h"

namespace Genesis
{

	Application::Application()
	{

	}

	Application::~Application()
	{

	}

	void Application::Run()
	{
		WindowResizeEvent e(1200, 720);
		GS_TRACE(e);

		while (true);
	}
}

