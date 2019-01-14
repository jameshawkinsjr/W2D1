class Employee
    attr_reader :salary
    def initialize(name, title, salary, boss=nil)
        @name = name
        @title = title
        @salary = salary
        @boss = boss        
    end

    def bonus(multiplier)
        @salary * multiplier
    end   
end

class Manager < Employee

    def initialize(name, title, salary, boss=nil)
        @subordinates = []
        super(name, title, salary, boss)
    end
    def bonus(multiplier)
        sub_salaries * multiplier
    end

    def sub_salaries    
        sub_total = 0
        @subordinates.each do |sub|
            if sub.is_a?(Manager)
                sub_total += sub.salary + sub.sub_salaries
            else
                sub_total += sub.salary
            end
        end
        sub_total
    end

    def add_sub(sub)
        @subordinates << sub
    end
end

if __FILE__ == $PROGRAM_NAME
    ned = Manager.new("Ned", "Founder" ,1000000, nil)
    darren = Manager.new("Darren", "TA Manager" ,78000, ned)
    david = Employee.new("Shawna", "TA" ,12000, darren)
    shawna = Employee.new("David", "TA" ,10000, darren)
    darren.add_sub(shawna)
    darren.add_sub(david)
    ned.add_sub(darren)
    p ned.bonus(5) # => 500_000
    p darren.bonus(4) # => 88_000
    p david.bonus(3) # => 30_000
end