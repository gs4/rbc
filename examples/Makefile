TARGETS=foo

foo: test.cc.rbc
	../rbc_pp.rb $< | g++ -x c++ -o $@ -

clean:
	rm -rf *.o $(TARGETS) *.gch