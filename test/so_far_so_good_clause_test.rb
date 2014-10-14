require 'helper'

class TestSoFarSoGoodClause < Minitest::Test

  def setup
    @nodes = SoFarSoGood::Clauses.send(:sections)
  end

  should "parse a section node" do
    clause = SoFarSoGood::Clause.new(@nodes[6])
    assert_equal "52.203-5", clause.number
    assert_equal "Covenant Against Contingent Fees.", clause.subject
    refute clause.reserved
    assert_includes clause.citation, "48 FR 42478"
    assert_includes clause.body, "As prescribed in 3.404,"
    assert_includes clause.extract, "The Contractor warrants that no person or agency"
  end

  should "know if its reserved" do
    refute SoFarSoGood::Clauses["52.203-5"].reserved?
    assert SoFarSoGood::Clauses["52.203-1"].reserved?
  end

  should "put out valid json" do
    assert JSON.parse SoFarSoGood::Clauses["52.203-5"].to_json
  end
end
