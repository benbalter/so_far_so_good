require 'helper'

class TestSoFarSoGoodClauses < Minitest::Test
  should "know the clauses file" do
    assert File.exists? SoFarSoGood::Clauses.send :source_path
  end

  should "parse the XML" do
    assert Nokogiri::XML::Document, SoFarSoGood::Clauses.send(:doc).class
  end

  should "parse section numbers" do
    assert_equal 626, SoFarSoGood::Clauses.numbers.count
    assert_equal "52.200", SoFarSoGood::Clauses.numbers.first
  end

  should "parse section descriptions" do
    assert_equal 626, SoFarSoGood::Clauses.descriptions.count
    assert_equal "Scope of subpart.", SoFarSoGood::Clauses.descriptions.first
  end

  should "put out valid JSON" do
    assert !!JSON.parse(SoFarSoGood::Clauses.list.to_json)
  end

  should "return a particular clause" do
    assert_equal "52.202-1", SoFarSoGood::Clauses["52.202-1"].number
  end

  should "return all clauses" do
    assert_equal 626, SoFarSoGood::Clauses.list.count
  end

  should "filter reserved clauses" do
    assert_equal 576, SoFarSoGood::Clauses.list(:exclude_reserved => true).count
  end

  should "build the markdown table" do
    assert_includes SoFarSoGood::Clauses.to_md, "-|\n| 52.200              | Scope of subpart."
  end

  should "exclude reserved in markdown table when asked" do
    refute_includes SoFarSoGood::Clauses.to_md(:exclude_reserved => true), "[Reserved]"
  end

  should "inlcude links in markdown table when asked" do
    assert_includes SoFarSoGood::Clauses.to_md(:links => true), "[52.252-6](http://www.law.cornell.edu/cfr/text/48/52.252-6)"
  end

  should "output valid CSV" do
    csv = CSV.parse SoFarSoGood::Clauses.to_csv
    assert_equal ["52.200", "Scope of subpart."], csv[1]
  end
end
