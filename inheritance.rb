class Employee
  attr_reader :name, :title, :salary 
  attr_accessor :boss
  
  def initialize(name, title, salary, boss = nil)
    @name = name
    @title = title
    @salary = salary
    @boss = boss.add_sub(self) unless boss == nil
  end
  
  def bonus(multiplier)
    bonus = @salary * multiplier
  end  
end

class Manager < Employee
  attr_reader :subs
  
  def initialize(name, title, salary, boss)
    @subs = []
    super
  end
  
  def add_sub(emp)
    @subs << emp
    emp.boss = self
  end
  
  def list_subs(mgr)
    @subs
  end
  
  def bonus(multiplier)
    sum = 0
    @subs.each do |sub|
      sum += sub.salary
    end
    sum * multiplier
  end
  
end

def testing
  mgr1 = Manager.new("Smithers", "Boss", 1000000000, nil)
  
  emp1 = Employee.new("Homer", "Sleeper", 20000, nil)
  puts "emp name: #{emp1.name}"
  puts "title: #{emp1.title}"
  puts "salary: #{emp1.salary}"
  
  
  mgr1.add_sub(emp1)
  puts "boss: #{emp1.boss.name}"
  puts "employee bonus:"
  puts emp1.bonus(0.1)

  emp2 = Employee.new("second", "blah", 40000, mgr1)
  puts "manager bonus"
  puts mgr1.bonus(0.1)
  
end

testing
