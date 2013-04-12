module Constantine
  class ConstantForm
    CONVERTERS = {
      :float => Proc.new { |s| Float(s) },
      :boolean => Proc.new { |s| s == "true" },
      :integer => Proc.new { |s| Integer(s) },
      :string => Proc.new { |s| s }
    }

    def initialize(constant)
      @constant = constant
    end

    def form
      result ="<tr><td>#{@constant.name}</td>" +
        "<td>#{@constant.type}</td>"
      if @constant.type != :boolean
        result += "<td><input type='text' placeholder='#{@constant.value}' id='#{field_name}'></input></td>" 
      else
        result += "<td><input type='checkbox' id='#{field_name}'"
        result += " checked" if @constant.value
        result += "></td>"
      end
        result += "<td><button class='btn' id='#{field_name}-send'>Send</button></td></tr>"
    end

    def consume_params(form_params)
      @constant.value = casted_value(form_params)
    end

    private

    def casted_value(form_params)
      CONVERTERS[@constant.type].call(form_params["value"])
    end

    def field_name
      "#{@constant.name}-#{@constant.type}"
    end
  end
end
