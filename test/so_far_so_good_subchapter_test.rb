require 'helper'

class TestSoFarSoGoodSubchapter < Minitest::Test

  def setup
    @subchapter = SoFarSoGood.far
  end

  should "know the subchapter file" do
    assert File.exists? @subchapter.send :source_path
  end

  should "parse the XML" do
    assert Nokogiri::XML::Document, @subchapter.send(:doc).class
  end

  should "parse subpart numbers" do
    assert_equal 626, @subchapter.numbers.count
    assert_equal "52.200", @subchapter.numbers.first
  end

  should "parse subpart descriptions" do
    assert_equal 626, @subchapter.subjects.count
    assert_equal "Scope of subpart.", @subchapter.subjects.first
  end

  should "put out valid JSON" do
    assert !!JSON.parse(@subchapter.subparts.to_json)
  end

  should "return a particular subpart" do
    assert_equal "52.202-1", @subchapter["52.202-1"].number
  end

  should "return all subparts" do
    assert_equal 626, @subchapter.subparts.count
  end

  should "filter reserved subparts" do
    assert_equal 576, @subchapter.subparts(:reserved => false).count
  end

  should "build the markdown table" do
    assert_includes @subchapter.to_md, "-|\n| 52.200              | Scope of subpart."
  end

  should "exclude reserved in markdown table when asked" do
    refute_includes @subchapter.to_md(:reserved => false), "[Reserved]"
  end

  should "include links in markdown table when asked" do
    assert_includes @subchapter.to_md(:links => true), "[52.252-6](http://www.law.cornell.edu/cfr/text/48/52.252-6)"
  end

  should "output valid CSV" do
    csv = CSV.parse @subchapter.to_csv
    assert_equal ["52.200", "Scope of subpart."], csv[1]
  end
end
