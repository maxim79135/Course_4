import ctypes

def count_words(string):
    return len(string.split())

def new_count_words(string):
    libcpp = ctypes.CDLL(".\\count_words.so")
    mutable_string = ctypes.create_string_buffer(str.encode(string))
    return libcpp.count_words(mutable_string)


def up_low(string):
    return sum([1 if letter.isupper() else 0 for letter in string]), sum(
        [1 if letter.islower() else 0 for letter in string])


def revers_string1(string):
    try:
        return " ".join([value[::-1] if i % 1 == 0 else value for i, value in enumerate(string.split(" "), 1)])
    except AttributeError:
        return 1


def revers_string2(string):
    try:
        return " ".join([value[::-1] if i % 2 == 0 else value for i, value in enumerate(string.split(" "), 1)])
    except AttributeError:
        return 1

def case_change(string):
    new_string = ""
    for i in string:
        if i.isupper():
            new_string += i.lower()
        else:
            new_string += i.upper()
    print(new_string) 

def sort_sentence(string):
    dict_string = dict([(sum([ord(letter) for letter in item]), item) for item in string.split(" ")])
    return " ".join([dict_string[res] for res in sorted(dict_string.keys())])
