require 'helper'

class TestSoFarSoGoodClauses < Minitest::Test
  should "know the clauses file" do
    assert File.exists? SoFarSoGood::Clauses.send :source_path
  end

  should "parse the XML" do
    assert Nokogiri::XML::Document, SoFarSoGood::Clauses.send(:doc).class
  end

  should "parse the rows" do
    assert_equal 567, SoFarSoGood::Clauses.send(:rows).count
    assert_equal ["52.200", "Scope of subpart."], SoFarSoGood::Clauses.send(:rows).first
  end

  should "parse section numbers" do
    assert_equal 616, SoFarSoGood::Clauses.numbers.count
    assert_equal "52.200", SoFarSoGood::Clauses.numbers.first
  end

  should "parse section descriptions" do
    assert_equal 616, SoFarSoGood::Clauses.descriptions.count
    assert_equal "Scope of subpart.", SoFarSoGood::Clauses.descriptions.first
  end

  should "put out valid JSON" do
    assert !!JSON.parse(SoFarSoGood::Clauses.list.to_json)
  end

  should "return a particular clause" do
    assert_equal "52.202-1", SoFarSoGood::Clauses["52.202-1"].number
  end
end
