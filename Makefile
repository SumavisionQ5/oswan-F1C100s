PRGNAME     = oswan
CC			= /opt/miyoo/bin/arm-linux-gcc

PROFILE = 0

SRCDIR		= ./main/sdl ./main/sound ./main/emu/cpu ./main/emu ./main/menu ./main/scalers
SRCDIR		+= ./source/scalers ./source/ports/$(PORT) ./source/sound/$(SOUND_ENGINE) ./source/sound_output/$(SOUND_OUTPUT)
VPATH		= $(SRCDIR)
SRC_C		= $(foreach dir, $(SRCDIR), $(wildcard $(dir)/*.c))
SRC_CP		= $(foreach dir, $(SRCDIR), $(wildcard $(dir)/*.cpp))
OBJ_C		= $(notdir $(patsubst %.c, %.o, $(SRC_C)))
OBJ_CP		= $(notdir $(patsubst %.cpp, %.o, $(SRC_CP)))
OBJS		= $(OBJ_C) $(OBJ_CP)

CFLAGS	   += -DSOUND_ON -DSOUND_EMULATION -DFRAMESKIP -DBITTBOY
CFLAGS	   += -Ofast -fdata-sections -ffunction-sections  -flto -fno-PIC
CFLAGS	   += -fsingle-precision-constant

ifeq ($(PROFILE), YES)
CFLAGS 		+= -fprofile-generate="./"
LDFLAGS		+= -lgcov
else ifeq ($(PROFILE), APPLY)
CFLAGS		+= -fprofile-use="./"
endif
CFLAGS		+= -std=gnu99
CFLAGS		+= -Imain/emu -Imain/sdl -Imain/headers -Imain/menu -Imain/sound -Imain/scalers

LDFLAGS       = -nodefaultlibs -lc -lgcc -lSDL -lasound -lz -lm -Wl,-O1,--sort-common,--as-needed,--gc-sections -s -flto -no-pie -flto -s

# Rules to make executable
$(PRGNAME): $(OBJS)  
	$(CC) $(CFLAGS) -o $(PRGNAME) $^ $(LDFLAGS)

$(OBJ_C) : %.o : %.c
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	rm -f $(PRGNAME) *.o
