=begin
  
define a method called attribute, which behaves much like the built-in 'attr'
      def koan_1
        c = Class::new {
          attribute 'a'
        }

        o = c::new

        assert{ not o.a? }
        assert{ o.a = 42 }
        assert{ o.a == 42 }
        assert{ o.a? }
      end 
      def koan_7
        c = Class::new {
          attribute('a'){ fortytwo } #block
          def fortytwo
            42
          end
        }

        o = c::new

        assert{ o.a == 42 }
        assert{ o.a? }
        assert{ (o.a = nil) == nil }
        assert{ not o.a? }
      end
=end


class MyModule
  def attribute(name, &block)
    return name.each_pair{|k, v| attribute(k){v} } if name.is_a? Hash
    define_method("__#{name}__", block || proc{nil} )
    class_eval <<EOF
      attr_writer :#{name}
      def #{name}?
        true unless #{name}.nil?
      end
      def #{name}
        defined?(@#{name})? @#{name} : @#{name} = __#{name}__
      end
    EOF
  end
end

#use this method:
c = Class::new {
          attribute 'a'
        }
o = c::new
o.'a' = 42
puts o.'a'


  
