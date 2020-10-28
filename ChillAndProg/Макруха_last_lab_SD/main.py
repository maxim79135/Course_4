import self_strings
import time

def exit_program():
    print("Приложение завершено")
    exit()


def validate_value(left=0, right=None):
    try:
        value = int(input("Ввведите эелемент меню: "))
    except ValueError:
        return None
    if left <= value <= right:
        return value
    return None


def menu():
    print("Меню: ")
    print("0.Подсчитать количество слов")
    print("1.Подсчитать количество заглавных и строчных букв")
    print("2.Инвертировать каждое слово в строке")
    print("3.Инвертировать каждое второе слово в строке ")
    print("4.Поменять регистр символов в строке")
    print("5.Отсортировать строку")
    print("6.Выход")

functions = [
    self_strings.new_count_words,
    self_strings.up_low,
    self_strings.revers_string1,
    self_strings.revers_string2,
    self_strings.case_change,
    self_strings.sort_sentence
]

if __name__ == "__main__":
    while True:
        menu()
        item = validate_value(right=len(functions))
        if item is None:
            print("Некорректный ввод")
            continue
        if item == len(functions):
            exit_program()
        if item == 0:
            string = input("Введите строку: ")
            start = time.time()
            res = self_strings.count_words(string)
            end = time.time()
            print("Вызов метода из python: {0}.\n Time: {1}".format(res, end - start))

            start = time.time()
            res = self_strings.new_count_words(string)
            end = time.time()
            print("Вызов метода из C++: {0}.\n Time: {1}".format(res, end - start))
        else:
            print(str(functions[item](input("Введите строку: "))))