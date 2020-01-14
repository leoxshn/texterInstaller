
src = src/Main.vala
pkgs = gtk+-3.0 src/resources.c
out = texterInstaller

all: resources.c
	valac --gresources=res/resources.xml --pkg $(pkgs) $(src) -o $(out)

run: all
	./$(out)

resources.c: res/resources.xml $(shell glib-compile-resources --sourcedir res --generate-dependencies res/resources.xml)
	glib-compile-resources --sourcedir res --target=src/$@  --generate-source $<

clean:
	rm src/resources.c $(out)
