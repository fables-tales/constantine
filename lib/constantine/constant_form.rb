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
      result = "<tr>"
      result += "<td>#{@constant.name}</td>"
      result += "<td>#{@constant.type}</td>"
      result += "<td>#{input_element}</td>"
      result += "<td>#{button_element}</td>"
      result += "</tr>"
    end

    def consume_params(form_params)
      @constant.value = casted_value(form_params)
    end

    private

    def casted_value(form_params)
      CONVERTERS[@constant.type].call(form_params["value"])
    end

    def input_element
      if @constant.type != :boolean
        "<input type='text' placeholder='#{@constant.value}' id='#{field_name}'></input>"
      else
        result = ""
        result += "<input type='checkbox' id='#{field_name}'"
        result += " checked" if @constant.value
        result += ">"
        return result
      end
    end

    def button_element
      "<button class='btn' id='#{field_name}-send'>Send</button>"
    end

    def field_name
      "#{@constant.name}-#{@constant.type}"
    end
  end
end
