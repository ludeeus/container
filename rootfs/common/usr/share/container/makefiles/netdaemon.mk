SHELL := /bin/bash
start: ## Start the NetDaemon runner
	dotnet add package JoySoftware.NetDaemon.App --version $(dotnet add package JoySoftware.NetDaemon.App | grep "Nearest version" | cut -d " " -f 13)
	dotnet add package JoySoftware.NetDaemon.DaemonRunner --version $(dotnet add package JoySoftware.NetDaemon.DaemonRunner | grep "Nearest version" | cut -d " " -f 13)
	dotnet restore
	dotnet watch run