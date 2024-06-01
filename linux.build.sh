if [ ! -d "build" ]; then
  mkdir build
fi
lit make
sudo rm -rf ./build/lunastream.linux
sudo mv ./LunaStream ./build/lunastream.linux