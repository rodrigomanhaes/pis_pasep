module PisPasepActiveRecord
  def usar_como_pis_pasep(*args)
    args.each do |attribute|
      add_composed_class(attribute, 'PisPasep')
      module_eval create_code(attribute, 'PisPasep')
    end
  end

  def add_composed_class(name, klass)
    options = {:class_name => klass, :mapping => [name.to_s, 'numero'], :allow_nil => true }
    constructor = Proc.new {|numero| eval(klass).new(numero) }
    converter = Proc.new {|value| eval(klass).new(value) }
    begin
      composed_of name, options.merge({:constructor => constructor, :converter => converter })
    rescue Exception
      composed_of name, options { eval(klass).new(name[:numero]) }
    end
  end

  def create_code(attribute, klass)
    """
      validate :#{attribute}_valido?

      def #{attribute}_valido?
        value = read_attribute('#{attribute}')
        if !value.nil? && value.strip != '' && !#{attribute}.nil? && !#{attribute}.valido?
          self.errors.add('#{attribute}', 'numero invalido')
        end
      end
    """
  end
end

ActiveRecord::Base.extend PisPasepActiveRecord

