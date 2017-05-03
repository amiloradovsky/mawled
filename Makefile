prefix=/usr/local
bindir=$(prefix)/bin

LIBX11_DIR=/usr/lib
LIBX11_PATH=$(LIBX11_DIR)/libX11.so

all: mawled

mawled: libx11-xlib.dtm libworkspace.dtm src/mawled.dt
	dalec -O4 --static-modules -lm -lX11 \
	-a $(LIBX11_PATH) -o mawled src/mawled.dt

libworkspace.dtm: libx11-xlib.dtm src/workspace.dt
	dalec -a $(LIBX11_PATH) -c src/workspace.dt

libx11-xlib.dtm: src/x11-xlib.dt
	dalec -a $(LIBX11_PATH) -c src/x11-xlib.dt

src/workspace.dt:
	true

src/x11-xlib.dt:
	true

src/mawled.dt:
	true

clean:
	rm -f mawled && rm *.so && rm *.bc && rm *.dtm

install:
	install -D -m 755 mawled $(bindir)/mawled
