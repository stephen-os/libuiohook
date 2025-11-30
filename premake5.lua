project "LibUIOHook"
   kind "StaticLib"
   language "C"
   targetdir "bin/%{cfg.buildcfg}"
   staticruntime "off"

   files {
      "include/uiohook.h",
      "src/logger.c",
      "src/logger.h"
   }

   includedirs {
      "include",
      "src"
   }

   targetdir ("../../bin/" .. outputdir .. "/%{prj.name}")
   objdir ("../../bin-int/" .. outputdir .. "/%{prj.name}")

   -- Platform-specific files and settings
   filter "system:windows"
      files {
         "src/windows/**.c",
         "src/windows/**.h"
      }
      defines { "_WIN32", "WIN32" }
      systemversion "latest"

   filter "system:linux"
      files {
         "src/x11/**.c",
         "src/x11/**.h"
      }
      links { "X11", "Xtst", "pthread" }
      defines { "_LINUX" }

   filter "system:macosx"
      files {
         "src/darwin/**.c",
         "src/darwin/**.h"
      }
      links { 
         "Carbon.framework", 
         "CoreFoundation.framework",
         "CoreGraphics.framework"
      }
      defines { "_DARWIN" }

   filter "configurations:Debug"
      runtime "Debug"
      symbols "On"

   filter "configurations:Release"
      runtime "Release"
      optimize "On"
      symbols "On"

   filter "configurations:Dist"
      runtime "Release"
      optimize "On"
      symbols "Off"