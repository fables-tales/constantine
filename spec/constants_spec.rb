require "constantine"

describe Constantine::Constants do
  context "with some constants" do
    it "makes a composite form" do
      c = Constantine::Constant.new("name", :float, 1.0)
      c2 = Constantine::Constant.new("name2", :boolean, true)

      cs = Constantine::Constants.new
      cs.add_constant(c)
      cs.add_constant(c2)

      expect(cs.composite_form.split("\n").count).to eql 2
    end
  end

  context "when loading from a file" do
    it "should load the constant correctly" do
      File.open("/tmp/test-constantine", "w") do |fd|
        fd.write("name,float,3.0")
      end

      c = Constantine::Constants.new("/tmp/test-constantine")
      expect(c.to_csv).to eql "name,float,3.0"
    end

    it "should have the right forms" do
      File.open("/tmp/test-constantine", "w") do |fd|
        fd.write("name,float,3.0")
      end

      c = Constantine::Constants.new("/tmp/test-constantine")
      expect(c.composite_form).to match /input.*3.0/
    end
  end
end
