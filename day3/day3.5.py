#class and objects : class -> nouns, attributes->adjectives, methods -> verbs
'''
class SuperHero:
    def __init__(self,name,crown_color):
        self.name = name
        self.crown_color = crown_color
    def fly(self):
        print(f"{self.name} is flying with a {self.crown_color} crown" )

# Object Instantiation
superman = SuperHero("Superman","Green")
print(superman.name)
print(superman.crown_color)

superman.fly()
'''

# check if employee has acheived their weekly target
print("///check if employee has acheived their weekly target/// ")
class Employee:
    name = "Arjun"
    desig = "Sales Executive"
    salaesMadeThisWeek = 6

    def hasAchievedWeeklyTarget(self):
        if self.salaesMadeThisWeek >=5:
            print("Achieved")
        else:
            print("Not achieved")

emp1 = Employee()
print(emp1.name)
print(emp1.desig)
print(emp1.salaesMadeThisWeek)
emp1.hasAchievedWeeklyTarget()

emp2 = Employee()
print(emp2.name)
print(emp2.desig)
print(emp2.salaesMadeThisWeek)
emp2.hasAchievedWeeklyTarget()

class Employee:
    # Class Attribute
    numberOfWorkingHours = 40

emp1 = Employee()
emp2 = Employee()
emp2.numberOfWorkingHours = 60
emp1.name = "Green Veggies"

print(emp1.name,emp1.numberOfWorkingHours,emp2.numberOfWorkingHours)

class Employee:
    def employeeDetails(self):
        pass

emp1 = Employee()
print(emp1.employeeDetails())

# self parameter
class Employee:
    def employeeDetails(self):
        self.name = 'Arjun'
        self.age = 25
        print('Age', self.age)

    def printEmployeeDetails(self):
        print("Printing employee details in another method")
        print('Name of the employee:', self.name)
        print('Age of the employee:', self.age)

employee = Employee()
employee.employeeDetails()
employee.printEmployeeDetails()
