#  Constructor (__init__ Method)

class Employee:
    def __init__(name,self):
        name.self = self
    
    def displayEmployeeDetails(name):
        print(name.self)

emp1 = Employee("abc")
emp2 = Employee("bcd")
emp1.displayEmployeeDetails()
emp2.displayEmployeeDetails()

##  Library Management system
class Library:
    def __init__(self, listOfBooks):
        self.availableBooks = listOfBooks

    def displayAvailableBooks(self):
        print("Available Books:")
        for book in self.availableBooks:
            print(book)

    def lendBook(self, requestedBook):
        if requestedBook in self.availableBooks:
            print(f"You have now borrowed the book: {requestedBook}")
            self.availableBooks.remove(requestedBook)
        else:
            print("Sorry, the book is not available in our list")

    def addBook(self, returnedBook):
        self.availableBooks.append(returnedBook)
        print("You have returned the book. Thank you")


class Customer:
    def requestBook(self):
        self.book = input("Enter the name of a book you would like to borrow: ")
        return self.book

    def returnBook(self):
        self.book = input("Enter the name of the book which you are returning: ")
        return self.book
        





library = Library([
    "Think and Grow Rich",
    "Who Will Cry When You Die",
    "For One More Day"
])

customer = Customer()

while True:
    print("\n========= LIBRARY MENU =========")
    print("1. Display available books")
    print("2. Request a book")
    print("3. Return a book")
    print("4. Exit")
    print("================================")

    try:
        choice = int(input("Enter your choice (1-4): "))
    except ValueError:
        print("Please enter a valid number between 1 and 4.")
        continue

    if choice == 1:
        library.displayAvailableBooks()
    elif choice == 2:
        requestedBook = customer.requestBook()
        library.lendBook(requestedBook)
    elif choice == 3:
        returnedBook = customer.returnBook()
        library.addBook(returnedBook)
    elif choice == 4:
        print("Thank you for visiting the Library!")
        break
    else:
        print("Invalid choice. Please try again.")
