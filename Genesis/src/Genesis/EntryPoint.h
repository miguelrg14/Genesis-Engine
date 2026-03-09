#pragma once

#ifdef GS_PLATFORM_WINDOWS

extern Genesis::Application* Genesis::CreateApplication();

int main(int argc, char** argv)
{
	Genesis::Log::Init();
	GS_CORE_WARN("Initialized Log!");
	int a = 5;
	GS_CORE_INFO("Hello! Var={0}", a);

	GS_CORE_TRACE("Trace");
	GS_CORE_DEBUG("Debug");
	GS_CORE_INFO("Info");
	GS_CORE_WARN("Warn");
	GS_CORE_ERROR("Error!");
	GS_CORE_CRITICAL("Critical!");

	auto app = Genesis::CreateApplication();
	app->Run();
	delete app;
}

#endif