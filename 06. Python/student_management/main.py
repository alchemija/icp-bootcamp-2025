from student_operations import add_student, view_students, update_student, delete_student

def main():
    while True:
        print("\nstudent management system")
        print("1. add student")
        print("2. view students")
        print("3. update student")
        print("4. delete student")
        print("5. exit")

        choice = input("enter your choice: ")

        match choice:
            case "1":
                name = input("enter student name: ")
                add_student(name)
            case "2":
                view_students()
            case "3":
                old_name = input("enter current name of the student: ")
                new_name = input("enter new name of the student: ")
                update_student(old_name, new_name)
            case "4":
                name = input("enter student name to delete: ")
                delete_student(name)
            case "5":
                break
            case _:
                print("invalid choice.")

main()