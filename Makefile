
DATA=randomdata.img

lib: $(DATA)
	xxd -i $(DATA) > mylib/mylibarr.h
	gcc -o app/libmylib.so mylib/mylib.c -fPIC -shared

prog:
	gcc -o app/myprog myprog/myprog.c -Lapp -Imylib -lmylib

all: lib prog

$(DATA):
	dd if=/dev/urandom of=$@ bs=1M count=100

clean:
	rm -rf app/* mylib/mylib.so

run:
	LD_LIBRARY_PATH=app app/myprog
