""" find first unique number from list """
"""
    Проверка на всеки item от списъка, дали вече е въведен в речника {}.
    Ако е въведен, увеличи стойността на повторението с +=1
    Ако не е въведен го въвежда с counts[item] = 1 и речника вече изглежда така {item:1}
    по този начин, ще мине през всички числа от списъка и ще ги добави в речника,
    като ще сложи срещу всяко число броя на повторенията.

for item in lst:
    if count[item] == 1:
        return item

    Проверка за всеки item in lst, да провери в речника {item:n} -> count[item] == 1
    дали срещу item (числото), е = 1 или числото има повече повторения и не е уникално.
    Ако count[item] == 1 - връща item.
"""


def solution(lst):
    counts = {}

    for item in lst:
        """ check if number from [] in {dictionary} """
        if item in counts:
            """ if item in dictionary {counts} then +=1"""
            counts[item] += 1
        else:
            """ if item not in counts -> make create record item:1 in {}"""
            counts[item] = 1

    for item in lst:
        """ check every item in list if item is in dictionary with repeating number = 1"""
        if counts[item] == 1:
            return item

    return -1


print(solution([1, 2, 1, 3, 2, 5]))  # prints 3
print(solution([1, 2, 1, 3, 3, 2, 5]))  # prints 5
print(solution([1, 2, 1, 3, 3, 2, 5, 5]))  # prints -1
print(solution([7]))  # prints 7
