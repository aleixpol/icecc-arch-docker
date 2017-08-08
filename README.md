# Build
```
docker build --pull . -t arch-icecc
```
Remember to pass `--pull` as archlinux/base is rolling.

# Execute
```
docker run -ti --net=host -p ::10245/tcp -p ::8765/tcp -p ::8766/tcp -p ::8765/udp arch-icecc
```
