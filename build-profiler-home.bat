SET dd_build_configuration=Debug
SET dd_output_dir=profiler-home\%dd_build_configuration%

nuget restore Datadog.Trace.Native.sln

msbuild Datadog.Trace.proj /t:BuildCpp /p:Configuration=%dd_build_configuration%;Platform=x64
mkdir "%dd_output_dir%\x64\"
copy "src\Datadog.Trace.ClrProfiler.Native\bin\%dd_build_configuration%\x64\Datadog.Trace.ClrProfiler.Native.dll" "%dd_output_dir%\x64\"
copy "src\Datadog.Trace.ClrProfiler.Native\bin\%dd_build_configuration%\x64\Datadog.Trace.ClrProfiler.Native.pdb" "%dd_output_dir%\x64\"

msbuild Datadog.Trace.proj /t:BuildCpp /p:Configuration=%dd_build_configuration%;Platform=x86
mkdir "%dd_output_dir%\x86\"
copy "src\Datadog.Trace.ClrProfiler.Native\bin\%dd_build_configuration%\x86\Datadog.Trace.ClrProfiler.Native.dll" "%dd_output_dir%\x86\"
copy "src\Datadog.Trace.ClrProfiler.Native\bin\%dd_build_configuration%\x86\Datadog.Trace.ClrProfiler.Native.pdb" "%dd_output_dir%\x86\"

copy integrations.json "%dd_output_dir%"

dotnet publish src/Datadog.Trace.ClrProfiler.Managed/Datadog.Trace.ClrProfiler.Managed.csproj -c %dd_build_configuration% -f net45 -o "%dd_output_dir%/net45"
dotnet publish src/Datadog.Trace.ClrProfiler.Managed/Datadog.Trace.ClrProfiler.Managed.csproj -c %dd_build_configuration% -f net461 -o "%dd_output_dir%/net461"
dotnet publish src/Datadog.Trace.ClrProfiler.Managed/Datadog.Trace.ClrProfiler.Managed.csproj -c %dd_build_configuration% -f netstandard2.0 -o "%dd_output_dir%/netstandard2.0"