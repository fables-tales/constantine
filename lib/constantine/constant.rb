module Constantine
  class Constant
    VALIDATORS = {
      :float => Proc.new { |f|
        begin
          Float(f)
          true
        rescue
          false
        end
      },
      :string => Proc.new { |s| s.is_a? String },
      :boolean => Proc.new { |s|
        s == "true" || s == "false" || s.is_a?(TrueClass) || s.is_a?(FalseClass)
      },
      :integer => Proc.new { |s|
        begin
          Integer(s)
          true
        rescue
          false
        end
      }
    }

    def self.valid_types
      VALIDATORS.keys
    end

    attr_reader :name, :type, :value

    def initialize(name, type, value)
      @name = name
      @type = type
      @value = value
      validate
    end

    def validate
      validate_type
      validate_value
    end

    def to_csv
      "#{@name},#{@type},#{@value}"
    end

    def value=(new_value)
      @value = new_value
      validate
    end

    private

    def validate_type
      raise "invalid type #{@type}, valid types are #{self.class.valid_types.inspect}" unless self.class.valid_types.include? @type
    end

    def validate_value
      raise "invalid value #{@value} for type #{@type}" unless VALIDATORS[@type].call(@value)
    end
  end
end
