CC = gcc
CFLAGS = -Wall -Werror
LIBS = -lfl
OBJS = myscanner.o myparser.o mylangcommon.o
HDRS = mylangcommon.h
TARGET = mylang

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)

myscanner.c: lang.l
	flex -o $@ $<

myparser.c: lang.y
	bison -d -o $@ $<

%.o: %.c $(HDRS)
	$(CC) $(CFLAGS) -c $<

clean:
	rm -f *.o $(TARGET) myscanner.c myparser.c myparser.h
