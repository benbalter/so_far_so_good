require 'helper'

class TestSoFarSoGood < Minitest::Test
  should "figure out the vendor directory" do
    assert File.exists?(SoFarSoGood.vendor_directory)
  end

  should "return the clause hash" do
    assert_equal Hash, SoFarSoGood.clauses.class
    assert SoFarSoGood.clauses.count > 3
  end
end
