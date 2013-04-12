require "constantine"

describe Constantine::Constant do
  context "when provided a type that it doesn't know about" do
    it "complains" do
      expect {Constantine::Constant.new(nil, :wrong, "")}.to raise_error /invalid type/
    end
  end

  context "when provided with the :float type" do
    it "produces correct csv when given a valid floating value" do
      c = Constantine::Constant.new("name", :float, 3.0)
      expect(c.to_csv).to eql("name,float,3.0")
    end

    it "complains when given an invalid floating value" do
      expect{ Constantine::Constant.new(nil, :float, "oiqwdjf") }.to(raise_error(/invalid value .* for type float/))
    end
  end

  context "when provided with the :string type" do
    it "produces the correct csv when given a string value" do
      c = Constantine::Constant.new("name", :string, "woqifjqweofijwqef")
      expect(c.to_csv).to eql("name,string,woqifjqweofijwqef")
    end
  end

  context "when provided with :boolean type" do
    it "produces the correct csv when given a boolean value" do
      c = Constantine::Constant.new("name", :boolean, true)
      expect(c.to_csv).to eql("name,boolean,true")
    end

    it "produces the correct csv when given a boolean string" do
      c = Constantine::Constant.new("name", :boolean, "true")
      expect(c.to_csv).to eql("name,boolean,true")
    end

    it "complains when given a bad string" do
      expect{ Constantine::Constant.new(nil, :boolean, "oiqwdjf") }.to(raise_error(/invalid value .* for type boolean/))
    end
  end

  context"when provided with the :integer type" do
    it "complains when given a bad string" do
      expect{ Constantine::Constant.new(nil, :integer, "oiqwdjf") }.to(raise_error(/invalid value .* for type integer/))
    end

    it "works when given an integer string" do
      c = Constantine::Constant.new("name", :integer, "1")
      expect(c.to_csv).to eql("name,integer,1")
    end
  end
end
