cd ..
if [ ! -d "build" ]; then
  mkdir build
fi
lit make
sudo rm -rf ./build/lunastream.linux
sudo rm -rf ./build/lunastream.exe
sudo mv ./LunaStream ./build/lunastream.linux
cmd.exe /c win.build.bat
sudo mv ./LunaStream.exe ./build/lunastream.exe