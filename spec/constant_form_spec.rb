require "constantine"

describe Constantine::ConstantForm do
  context "When provided with a floating constant" do
    let (:constant) { Constantine::Constant.new("floating_name", :float, 3.0) }
    it "produces a text form" do
      c = Constantine::ConstantForm.new(constant)
      expect(c.form).to match(/input.*type=.text..*3.0/)
    end

    it "can be updated from a valid value" do
      params = { :"floating_name-float" => "3.141" }
      c = Constantine::ConstantForm.new(constant)
      c.consume_params(params)
      expect(constant.value).to eql(3.141)
    end

    it "can't be updates from an invalid value" do
      params = { :"floating_name-float" => "wqifjqweofijasfioajsdfoij" }
      c = Constantine::ConstantForm.new(constant)
      expect { c.consume_params(params) }.to raise_error /invalid value/
    end
  end
end
