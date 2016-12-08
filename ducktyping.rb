module Carnivore
  def diet
    puts 'meat'
  end
  
  def teeth
    puts 'sharp'
  end
  
end

module Herbivore
  def diet
    puts 'plant'
  end
  
  def teeth
    puts 'flat'
  end
 end
  
  module Nocturnal
    def sleep_time
      puts 'day'
    end
    def awake_time
      puts 'night'
    end
  end
  
  module Diurnal
    def sleep_time
      puts "night"
    end
    
    def awake_time
      puts "day"
    end
  end

def new_animal(diet, awake)
  animal = Object.new
  if diet == :meat
    animal.extend Carnivore
  else 
    animal.extend Herbivore
  end
  
  if awake == :day
    animal.extend Diurnal
  else 
    animal.extend Nocturnal
  end
end


#集合类， 
class CompositeBase
  attr_reader :name
  
  def initialize name
    @name = name
  end
  
  def self.memeber_of composite_name
      attribute_name = "parent_#{composite_name}"
      # p instance_methods.include? attribute_name.to_sym #have to use to_sym
      raise 'Method redefinition' if instance_methods.include? attribute_name.to_sym
      #in `memeber_of': Method redefinition (RuntimeError)
      
      code = %Q{
        attr_accessor :#{attribute_name}
      }
     class_eval code 
  end
  
  def self.composite_of composite_name
    memeber_of composite_name
    
    #need evaluate, need use string of code:
    code = %Q{
      
       def sub_#{composite_name}s
          @sub_#{composite_name}s ||= []
          @sub_#{composite_name}s
       end
      
      def add_sub_#{composite_name}(child)
        return if sub_#{composite_name}s.include?(child)
        sub_#{composite_name}s << child
        child.parent_#{composite_name} = self
      end
      
      def delete_sub_#{composite_name}(child)
        return unless sub_#{composite_name}s.include?(child)
        sub_#{composite_name}s.delete(child)
        child.parent_#{composite_name} = nil
      end
    }
    class_eval(code)  
       
  end
  
end

class Tiger < CompositeBase
  
  
  def parent_population
    
  end
  
  memeber_of :population
  memeber_of :classification
  

end

class Tree < CompositeBase
  memeber_of :population
  memeber_of :classification
  

end

class Jungle < CompositeBase
  composite_of :population
end

class Species < CompositeBase
  composite_of :classification
end

tiger = Tiger.new('tony')
jungle = Jungle.new('jungle tigers')
jungle.add_sub_population(tiger)

p tiger.parent_population
=begin
 #<Jungle:0x007faef18d0f48 @name="jungle tigers", @sub_populations=[#<Tiger:0x007faef18d0f98 @name="tony", @parent_population=#<Jungle:0x007faef18d0f48 ...>>]> 
=end













