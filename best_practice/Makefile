F90=pgfortran

ifeq ($(TARGET),gpu)
	FFLAGS = -g -traceback -O -Mpcast -Mpreprocess -Mrecursive -Mallocatable=03 -acc=verystrict -ta=nvidia:cc60 -Minfo=accel,inline
	LDFLAGS = -ta=nvidia:cc60 -Mcuda -Mnorpath
else
	FFLAGS = -O3 -Mpcast -Mpreprocess -mp -Minfo=accel,inline
	LDFLAGS = -mp
endif
	

OBJ = run_simple.o mo_simple.o mo_create.o

all: clean compile

compile: $(OBJ)
	$(F90) $(LDFLAGS) -o code $^

%.o: %.f90
	$(F90) $(FFLAGS) -c $^

# dependencies
mo_simple.o: mo_create.o
run_simple.o: mo_simple.o

#run:
#	nsys profile -f true -o typetest ./typetest 2> log.txt

clean:
	rm -f *.o *.mod *.qdstrm *.qdrep *.log
