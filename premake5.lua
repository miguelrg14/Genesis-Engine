workspace "Genesis"
	architecture "x64"
	startproject "Sandbox"

	configurations
	{
		"Debug",
		"Release",
		"Dist"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

-- Include directories relative to root folder (solution directory)
IncludeDir = {}
IncludeDir["GLFW"]  = "Genesis/vendor/GLFW/include"
IncludeDir["Glad"]  = "Genesis/vendor/Glad/include"
IncludeDir["imgui"] = "Genesis/vendor/imgui"

include "Genesis/vendor/GLFW"
include "Genesis/vendor/Glad"
include "Genesis/vendor/imgui"

project "Genesis"
	location "Genesis"
	kind "SharedLib"
	language "C++"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	pchheader "gspch.h"
	pchsource "Genesis/src/gspch.cpp"

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"%{prj.name}/src",
		"%{prj.name}/vendor/spdlog/include",
		"%{IncludeDir.GLFW}",
		"%{IncludeDir.Glad}",
		"%{IncludeDir.imgui}"
	}
	links
	{
		"GLFW",
		"Glad",
		"imgui",
		"opengl32.lib"
	}

	filter "system:windows"
		cppdialect "C++20"
		-- staticruntime "On"
		systemversion "latest"

	defines
	{
        "GS_PLATFORM_WINDOWS",
        "GS_BUILD_DLL",
		"GLFW_INCLUDE_NONE"
	}

	buildoptions 
	{ 
		"/utf-8"
	}

	postbuildcommands
	{
		('{MKDIR} "%{prj.location}/../bin/' .. outputdir .. '/Sandbox"'),
		('{COPYFILE} "%{cfg.buildtarget.abspath}" "%{prj.location}/../bin/' .. outputdir .. '/Sandbox/"')
	}

	filter "configurations:Debug"
		defines "GS_DEBUG"
		buildoptions "/MDd"
		symbols "On"
	
	filter "configurations:Release"
		defines "GS_RELEASE"
		buildoptions "/MD"
		optimize "On"

	filter "configurations:Dist"
		defines "GS_DIST"
		buildoptions "/MD"
		optimize "On"



project "Sandbox"
	location "Sandbox"
	kind "ConsoleApp"
	language "C++"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"Genesis/vendor/spdlog/include",
		"Genesis/src"
	}

	links
	{
		"Genesis"
	}

	filter "system:windows"
		cppdialect "C++20"
		-- staticruntime "On"
		systemversion "latest"

	defines
	{
        "GS_PLATFORM_WINDOWS"
	}

	buildoptions 
	{ 
		"/utf-8"
	}

	filter "configurations:Debug"
		defines "GS_DEBUG"
		buildoptions "/MDd"
		symbols "On"
	
	filter "configurations:Release"
		defines "GS_RELEASE"
		buildoptions "/MD"
		optimize "On"

	filter "configurations:Dist"
		defines "GS_DIST"
		buildoptions "/MD"
		optimize "On"