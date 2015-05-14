CC = gcc

CFLAGS = -O2 -Wall ${DEFINES} 
#DEFINES = -DSOUND_ON -DSMOOTH
DEFINES = -DLAYERS -DSMOOTH -DSOUND_ON -DSOUND_EMULATION -DSPEEDHACKS
LDFLAGS = -Wl,--as-needed `sdl-config --cflags --libs` -lSDLmain -lSDL 
OUTPUT = oswan

SOURCES = sdl/main_od.c sdl/menu.c sdl/hack.c emu/cpu/nec.c emu/WS.c emu/WSApu.c emu/WSFileio.c emu/WSInput.c emu/WSRender.c
OBJS = ${SOURCES:.c=.o}

${OUTPUT}:${OBJS}
	${CC} -o ${OUTPUT} ${SOURCES} ${CFLAGS} ${LDFLAGS}
	
clean:
	rm emu/*.o
	rm emu/cpu/*.o
	rm sdl/*.o
	rm ${OUTPUT}

