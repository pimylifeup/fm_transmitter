EXECUTABLE = fm_transmitter
VERSION = 0.9.4
FLAGS = -Wall -O3 -std=c++11
TRANSMITTER = -fno-strict-aliasing -I/opt/vc/include

ifeq ($(GPIO21), 1)
    TRANSMITTER += -DGPIO21
endif

# Object files
OBJS = main.o mailbox.o sample.o wave_reader.o transmitter.o

# All target
all: $(EXECUTABLE)

# Linking
$(EXECUTABLE): $(OBJS)
	g++ $(OBJS) -L/opt/vc/lib -lbcm_host -lpthread -lm -o $(EXECUTABLE)

# Compilation targets
mailbox.o: mailbox.c mailbox.h
	g++ $(FLAGS) -c mailbox.c -o $@

sample.o: sample.cpp sample.hpp
	g++ $(FLAGS) -c sample.cpp -o $@

wave_reader.o: wave_reader.cpp wave_reader.hpp
	g++ $(FLAGS) -c wave_reader.cpp -o $@

transmitter.o: transmitter.cpp transmitter.hpp
	g++ $(FLAGS) $(TRANSMITTER) -c transmitter.cpp -o $@

main.o: main.cpp
	g++ $(FLAGS) -DVERSION=\"$(VERSION)\" -DEXECUTABLE=\"$(EXECUTABLE)\" -c main.cpp -o $@

# Clean target
clean:
	rm -f $(OBJS) $(EXECUTABLE)
