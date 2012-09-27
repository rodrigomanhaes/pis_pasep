# encoding: utf-8

require 'active_record'

module PisPasep
  module ActiveRecord
    def use_as_pis_pasep(*args)
      args.each do |attribute|
        add_composed_class(attribute, 'PisPasep::Base')
        module_eval create_code(attribute, 'PisPasep::Base')
      end
    end

    def add_composed_class(name, klass)
      options = {:class_name => klass, :mapping => [name.to_s, 'number'], :allow_nil => true }
      constructor = Proc.new {|number| eval(klass).new(number) }
      converter = Proc.new {|value| eval(klass).new(value) }
      begin
        composed_of name, options.merge({:constructor => constructor, :converter => converter })
      rescue Exception
        composed_of name, options { eval(klass).new(name[:number]) }
      end
    end

    def create_code(attribute, klass)
      """
        validate :#{attribute}_valid?

        def #{attribute}_valid?
          value = read_attribute('#{attribute}')
          if !value.nil? && value.strip != '' && !#{attribute}.nil? && !#{attribute}.valid?
            self.errors.add('#{attribute}', 'número inválido')
          end
        end

        def #{attribute}=(value)
          if value.blank?
            write_attribute('#{attribute}', nil)
          elsif value.kind_of?(#{eval(klass)})
            write_attribute('#{attribute}', value.number)
          else
            begin
              c = #{eval(klass)}.new(value)
              c.valid? ? write_attribute('#{attribute}', c.number) : write_attribute('#{attribute}', value)
            rescue
              @#{attribute} = value
            end
          end
        end
      """
    end
  end
end

ActiveRecord::Base.extend PisPasep::ActiveRecord
