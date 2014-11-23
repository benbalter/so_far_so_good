require 'helper'

class TestSoFarSoGood < Minitest::Test
  should "figure out the vendor directory" do
    assert File.exists?(SoFarSoGood.send(:vendor_directory))
  end

  should "know the FAR" do
    assert_equal SoFarSoGood::Subchapter, SoFarSoGood.far.class
    assert_equal "FAR", SoFarSoGood.far.name
  end

  should "know the DFARs" do
    assert_equal SoFarSoGood::Subchapter, SoFarSoGood.dfars.class
    assert_equal "DFARs", SoFarSoGood.dfars.name
  end

  should "return subchapters" do
    assert_equal 2, SoFarSoGood.subchapters.count
  end

  should "return subparts" do
    assert_equal 981, SoFarSoGood.subparts.count
  end

  should "accept subpart options" do
    assert_equal 907, SoFarSoGood.subparts(:reserved => false).count
  end
end
