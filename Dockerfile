FROM base/archlinux
LABEL Description="Archlinux icecream"
MAINTAINER Aleix Pol Gonzalez <aleixpol@kde.org>

COPY mirrorlist /etc/pacman.d/
RUN pacman --noconfirm -Syu binutils libcap-ng gcc clang automake libtool autoconf make fakeroot grep lzo base-devel
RUN useradd pol; mkdir /home/pol; chown pol /home/pol -R
USER pol
RUN mkdir -p ~/pkg && cd ~/pkg && curl https://aur.archlinux.org/cgit/aur.git/snapshot/icecream.tar.gz > icecream.tar.gz && tar xvf icecream.tar.gz && cd icecream && makepkg
USER root
RUN pacman --noconfirm -U /home/pol/pkg/icecream/icecream-*.pkg.tar.xz

# Run icecc daemon in verbose mode
ENTRYPOINT ["/usr/lib/icecream/sbin/iceccd", "-u", "icecream", "-v"]
# If no-args passed, make very verbose
CMD ["-v"]

# iceccd port
EXPOSE 10245 8765/TCP 8765/UDP 8766

# docker build --pull . -t arch-icecc
# docker run --rm -ti --net=host -p ::10245/tcp -p ::8765/tcp -p ::8766/tcp -p ::8765/udp arch-icecc
