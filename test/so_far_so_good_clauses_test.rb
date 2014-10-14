require 'helper'

class TestSoFarSoGoodClauses < Minitest::Test
  should "know the clauses file" do
    assert File.exists? SoFarSoGood::Clauses.send :source_path
  end

  should "parse the XML" do
    assert Nokogiri::XML::Document, SoFarSoGood::Clauses.send(:doc).class
  end

  should "get to the subpart" do
    assert "SUBPART", SoFarSoGood::Clauses.send(:subpart).name
  end

  should "parse the rows" do
    assert SoFarSoGood::Clauses.send(:rows).count > 3
    assert_equal ["52.200", "Scope of subpart."], SoFarSoGood::Clauses.send(:rows).first
  end

  should "parse section numbers" do
    assert SoFarSoGood::Clauses.numbers.count > 3
    assert_equal "52.200", SoFarSoGood::Clauses.numbers.first
  end

  should "parse section descriptions" do
    assert SoFarSoGood::Clauses.descriptions.count > 3
    assert_equal "Scope of subpart.", SoFarSoGood::Clauses.descriptions.first
  end

  should "put out valid JSON" do
    assert JSON.parse(SoFarSoGood::Clauses.to_json)
  end
end
