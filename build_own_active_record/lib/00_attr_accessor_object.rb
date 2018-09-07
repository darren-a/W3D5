class AttrAccessorObject
  def self.my_attr_accessor(*names)

    names.each do |name|
      define_method(name) do  # getter
        instance_variable_get("@#{name}")
      end
      define_method("#{name}=") do |value|
        instance_variable_set("@#{name}", value)
      end
    end  # names each
  end  # my_attr_accessor

end # class



# https://ruby-doc.org/core-2.2.0/Module.html#method-i-define_method
# class A
#   def fred
#     puts "In Fred"
#   end
#   def create_method(name, &block)
#     self.class.send(:define_method, name, &block)
#   end
#   define_method(:wilma) { puts "Charge it!" }
# end
# class B < A
#   define_method(:barney, instance_method(:fred))
# end

# [249] pry(main)> a = B.new
# => #<B:0x007fb77ca64628>
# [250] pry(main)>
# [251] pry(main)> a
# => #<B:0x007fb77ca64628>
# [252] pry(main)>
# [253] pry(main)> a.barney
# In Fred

# [261] pry(main)> a.class.instance_methods(false)
# => [:barney]

# [267] pry(main)> a.wilma
# Charge it!

# [269] pry(main)> a.create_method(:betty) { p self }
# => :betty
# [270] pry(main)>
# [271] pry(main)> a.class.instance_methods(false)
# => [:barney, :betty]

# [273] pry(main)> a.betty
# #<B:0x007fb77ca64628>
# => #<B:0x007fb77ca64628>


# http://ruby-doc.org/core-2.0.0/Object.html#method-i-instance_variable_get
# class Fred
#   def initialize(p1, p2)
#     @a, @b = p1, p2
#   end
# end
# fred = Fred.new('cat', 99)
# fred.instance_variable_get(:@a)    #=> "cat"
# fred.instance_variable_get("@b")   #=> 99


# class Fred
#   def initialize(p1, p2)
#     @a, @b = p1, p2
#   end
# end
# fred = Fred.new('cat', 99)
# fred.instance_variable_set(:@a, 'dog')   #=> "dog"
# fred.instance_variable_set(:@c, 'cat')   #=> "cat"
# fred.inspect                             #=> "#<Fred:0x401b3da8 @a=\"dog\", @b=99, @c=\"cat\">"
