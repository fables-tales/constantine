module Constantine
  class Constants
    def initialize(file = nil)
      if file
        @filename = file
        ensure_file
        @constants = file_load
      else
        @constants = []
      end
    end

    def to_csv
      @constants.map(&:to_csv).join("\n")
    end

    def add_constant(constant)
      @constants << constant
    end

    def composite_form
      @constants.map {|c| ConstantForm.new(c).form}.join("\n")
    end

    def update_constant(constant_name, web_params)
      c = @constants.select {|c| c.name == constant_name}.first
      cf = ConstantForm.new(c)
      p web_params
      cf.consume_params(web_params)
      save!
    end

    def save!
      File.open(@filename, "w") do |fd|
        fd.write(to_csv)
      end
    end

    private

    def ensure_file
      File.open(@filename, "w") unless File.exists? @filename
    end

    def file_load
      rows = open(@filename).read.split("\n")
      rows.map {|row| Constant.new(row.split(",")[0],row.split(",")[1].to_sym, row.split(",")[2])}
    end
  end
end
