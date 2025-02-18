# HOW TO USE:
#
# build:
# docker build -t osu-tools .
#
# run:
# docker run --rm osu-tools [command]
# 
# help:
# docker run --rm osu-tools --help
#
# compute beatmap difficulty:
# docker run --rm -it -v <your-songs-folder>:/songs osu-tools difficulty -m fl "/songs/<path-in-your-songs-folder>"
#
# for more flags check:
# docker run --rm osu-tools difficulty --help

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build

WORKDIR /app
COPY osu.Tools.* .
COPY PerformanceCalculator PerformanceCalculator
RUN dotnet tool restore
RUN dotnet build -c release osu.Tools.sln

FROM mcr.microsoft.com/dotnet/runtime:5.0
WORKDIR /app
COPY --from=build /app/PerformanceCalculator/bin/Release/net5.0 .
ENTRYPOINT ["dotnet", "PerformanceCalculator.dll"]
