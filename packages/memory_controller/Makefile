CC=gcc
CFLAGS=-std=c99 -Werror -Wextra -Wall -Wvla -Wno-unused-result
CPPFLAGS=-D_GNU_SOURCE

SRC=memory_controller.c
OBJ=$(SRC:.c=.o)
BIN=$(OBJ:.o=)

$(BIN): $(SRC)

clean:
	$(RM) $(OBJ) $(BIN)
