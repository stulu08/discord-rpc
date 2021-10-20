outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"
project "discord-rpc"
	kind "StaticLib"
	language "C++"
	staticruntime "on"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"include/discord_register.h",
		"include/discord_rpc.h",
		"src/backoff.h",
		"src/connection.h",
		"src/discord_rpc.cpp",
		"src/msg_queue.h",
		"src/rpc_connection.h",
		"src/rpc_connection.cpp",
		"src/serialization.cpp",
		"src/serialization.h"
	}

	
	includedirs {
		"include",
		"rapidjson"
	}

	defines {
		--"DISCORD_DISABLE_IO_THREAD",
		--"DISCORD_DYNAMIC_LIB",
		--"DISCORD_BUILDING_SDK",
	}

	filter "system:linux"
		pic "On"

		systemversion "latest"
		
		files
		{
			"src/connection_unix.cpp",
			"src/discord_register_linux.cpp"
		}

		defines
		{
			"DISCORD_LINUX"
		}

	filter "system:windows"
		systemversion "latest"

		files
		{
			"src/connection_win.cpp",
			"src/discord_register_win.cpp"
		}

		defines 
		{ 
			"DISCORD_WINDOWS"
		}

	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		runtime "Release"
		optimize "on"

	filter "configurations:Dist"
		runtime "Release"
		optimize "on"

