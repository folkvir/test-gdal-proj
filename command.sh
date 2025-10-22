export CMAKE_CXX_FLAGS="-O2 -ffp-contract=off -fno-associative-math" # -frounding-math
cd /proj/build \
    && cmake -DCMAKE_CXX_FLAGS="$CMAKE_CXX_FLAGS" $(xx-clang --print-cmake-defines) .. \
    && cmake --build . \
    && cmake --build . --target install
echo "205846.35363 780675.358943" | /proj/build/bin/cs2cs EPSG:27561 EPSG:4326 -f "%.16f"