CC=gcc
LIBS=lobjc
OBJS:=ArrayedList.o Bag.o Base.o Data.o Dictionary.o File.o FileReader.o FileWriter.o IDAssoc.o IDDoubleNode.o IDNode.o IntAssoc.o
OBJS:=$(OBJS) LinkedList.o MutableString.o Queue.o Set.o Stack.o String.o Transcript.o
BASENM=libopenobjects.so
MAJVRS=1
MINVRS=0
RELVRS=0
PREFIX=/usr/local

$(BASENM).$(MAJVRS).$(MINVRS).$(RELVRS): $(OBJS)
	$(CC) -shared -Wl,-soname,$(BASENM).$(MAJVRS) -o $@ -$(LIBS) $(OBJS)

%.o: %.m
	$(CC) -c -Wall -Werror -fPIC -o $@ $?

install: $(BASENM).$(MAJVRS).$(MINVRS).$(RELVRS)
	cp $< $(PREFIX)/lib
	ldconfig $(PREFIX)/lib
	ln -f -s $(PREFIX)/lib/$(BASENM).$(MAJVRS) $(PREFIX)/lib/$(BASENM)

install-devel: install
	mkdir -p $(PREFIX)/include/openobjects
	cp *.h $(PREFIX)/include/openobjects
	mv $(PREFIX)/include/openobjects/OpenObjects.h $(PREFIX)/include

doc:
	objcdoc --dir doc --index --nosrc --tree .
	cp Cantarell-Regular.ttf doc
	cp theme.css doc
	sed -i '5 i <link rel="stylesheet" type="text/css" href="theme.css" />\' doc/*.html

clean:
	rm -f *.o *.so*
	rm -fR doc
