TARGETS=foo

foo: test.cc
	./rbc_pp.rb $< | g++ -x c++ -o $@ -

clean:
	rm -rf *.o $(TARGETS) *.gch