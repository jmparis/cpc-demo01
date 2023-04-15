AS		=	rasm.exe

PROJECT =	fillscreen
EXE		=	$(PROJECT).bin
DSK		=	$(PROJECT).dsk
SRCS	=	$(PROJECT).asm

all:	$(EXE)

$(EXE):	$(SRCS)
	$(AS) -o $(PROJECT) $<

clean:
	rm -f $(EXE)
	rm -f $(DSK)

run:	$(DSK)
	cap32 ./$(DSK) --autocmd=run\"fill.bin\"
