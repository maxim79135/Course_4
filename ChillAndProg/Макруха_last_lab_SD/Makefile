count_words.so: count_words.o
	c++ -shared -o count_words.so count_words.o
count_words.o: count_words.cpp
	c++ -c -Wall -Werror -fpic count_words.cpp
clean: 
	del count_words.o
