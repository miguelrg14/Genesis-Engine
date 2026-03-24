#pragma once

#include "Core.h"

#include "Window.h"
#include "LayerStack.h"
#include "Genesis/Events/Event.h"
#include "Genesis/Events/ApplicationEvent.h"

namespace Genesis 
{
	class GENESIS_API Application
	{
	private: 
		std::unique_ptr<Window> m_Window;
		bool m_Running = true;
		LayerStack m_LayerStack;
		static Application* s_Instance;

	public:
		Application();
		virtual ~Application();

		void Run();

		void OnEvent(Event& e);

		void PushLayer(Layer* layer);
		void PushOverlay(Layer* layer);

		inline Window& GetWindow() { return *m_Window; }
		
		inline static Application& Get() { return *s_Instance; }
	private:
		bool OnWindowClose(WindowCloseEvent& e);
	};

	// To be defined in CLIENT
	Application* CreateApplication();

}

