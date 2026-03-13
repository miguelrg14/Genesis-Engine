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



project "Genesis"
	location "Genesis"
	kind "SharedLib"
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
		"%{prj.name}/src",
		"%{prj.name}/vendor/spdlog/include"
	}

	filter "system:windows"
		cppdialect "C++20"
		staticruntime "On"
		systemversion "latest"

	defines
	{
        "GS_PLATFORM_WINDOWS",
        "GS_BUILD_DLL"
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
		symbols "On"
	
	filter "configurations:Release"
		defines "GS_RELEASE"
		optimize "On"

	filter "configurations:Dist"
		defines "GS_DIST"
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
		staticruntime "On"
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
		symbols "On"
	
	filter "configurations:Release"
		defines "GS_RELEASE"
		optimize "On"

	filter "configurations:Dist"
		defines "GS_DIST"
		optimize "On"