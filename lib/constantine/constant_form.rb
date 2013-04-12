module Constantine
  class ConstantForm
    CONVERTERS = {
      :float => Proc.new{ |s| Float(s) }
    }

    def initialize(constant)
      @constant = constant
    end

    def form
      "<tr><td>#{@constant.name}</td>" +
        "<td>#{@constant.type}</td>" +
        "<td><input type='text' placeholder='#{@constant.value}' id='#{field_name}'></input></td>" +
        "<td><button class='btn' id='#{field_name}-send'>Send</button></td></tr>"
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
