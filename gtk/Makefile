
GLIB_COMPILE_RESOURCES=glib-compile-resources

objs = src/Main.vala
pkgs = gtk+-3.0 src/resources.c

all: resources.c
	valac --gresourcesdir=res --gresources=res/resources.xml --pkg $(pkgs) $(objs) -o texterInstaller --verbose

run: all
	./texterInstaller

resources.c: res/resources.xml $(shell $(GLIB_COMPILE_RESOURCES) --sourcedir res --generate-dependencies res/resources.xml)
	$(GLIB_COMPILE_RESOURCES) --sourcedir res --target=src/$@  --generate-source $<

clean:
	rm src/resources.c
