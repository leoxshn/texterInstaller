
objs = src/Main.vala
pkgs = gtk+-3.0 src/resources.c

all: resources.c
	valac --gresources=res/resources.xml --pkg $(pkgs) $(objs) -o texterInstaller

run: all
	./texterInstaller

srun: all
	sudo ./texterInstaller

resources.c: res/resources.xml $(shell glib-compile-resources --sourcedir res --generate-dependencies res/resources.xml)
	glib-compile-resources --sourcedir res --target=src/$@  --generate-source $<

clean:
	rm src/resources.c texterInstaller
