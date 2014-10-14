require 'helper'

class TestSoFarSoGood < Minitest::Test
  should "figure out the vendor directory" do
    assert File.exists?(SoFarSoGood.vendor_directory)
  end

  should "return the clause hash" do
    assert_equal Array, SoFarSoGood.clauses.class
    assert_equal 616, SoFarSoGood.clauses.count
  end

  should "accept clause options" do
    assert_equal 567, SoFarSoGood.clauses(:exclude_reserved => true).count
  end
end
