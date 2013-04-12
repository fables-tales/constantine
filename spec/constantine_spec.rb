require "constantine"

describe Constantine::Constants do
  context "with no constants" do
    its "csv should be empty" do
      c = Constantine::Constants.new
      expect(c.to_csv.strip).to be_empty
    end
  end


  context "with two contsants" do
    let(:constant) do
      messages = {
        :to_csv => "constant_name,constant_type,constant_value"
      }
      stub(:constant, messages)
    end
    its "csv should contain the csv repr of the constant" do
      c = Constantine::Constants.new
      c.add_constant(constant)
      c.add_constant(constant)
      expect(c.to_csv.strip.split("\n")).to eql ["constant_name,constant_type,constant_value","constant_name,constant_type,constant_value"]
    end
  end
end
