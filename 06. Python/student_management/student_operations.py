from file_handler import read_students, write_students
from error_handler import handle_error


def add_student(name):
    students = read_students()
    if name in students:
        handle_error("Student already exists.")
    else:
        students.append(name)
        write_students(students)
        print("Student added.")

def view_students():
    students = read_students()
    if students:
        print("\n".join(students))
    else:
        print("No students found.")

def update_student(old_name, new_name):
    students = read_students()
    if old_name in students:
        students[students.index(old_name)] = new_name
        write_students(students)
        print("Student updated.")
    else:
        handle_error("Student not found.")

def delete_student(name):
    students = read_students()
    if name in students:
        students.remove(name)
        write_students(students)
        print("Student deleted.")
    else:
        handle_error("Student not found.")