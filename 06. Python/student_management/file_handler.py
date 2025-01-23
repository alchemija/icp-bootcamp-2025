def read_students():
    try:
        with open('students.txt', 'r') as file:
            return [line.strip() for line in file]
    except FileNotFoundError:
        return []

def write_students(students):
    with open('students.txt', 'w') as file:
        file.write('\n'.join(students))