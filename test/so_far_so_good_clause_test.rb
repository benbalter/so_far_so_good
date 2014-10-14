require 'helper'

class TestSoFarSoGoodClause < Minitest::Test

  def setup
    @nodes = SoFarSoGood::Clauses.send(:sections)
    @clause = SoFarSoGood::Clause.new(@nodes[6])
  end

  should "Store the node" do
    assert Nokogiri::XML::Element, @clause.node.class
  end

  should "expose the clause number" do
    assert_equal "52.203-5", @clause.number
  end

  should "expose the clause subject" do
    assert_equal "Covenant Against Contingent Fees.", @clause.subject
  end

  should "know the cite" do
    assert_includes @clause.citation, "48 FR 42478"
  end

  should "know the clause body" do
    assert_includes @clause.body, "As prescribed in 3.404,"
  end

  should "not include the extract in the clause body" do
    refute_includes @clause.body, "The Contractor warrants that no person or agency"
  end

  should "know the clause extract" do
    assert_includes @clause.extract, "The Contractor warrants that no person or agency"
  end

  should "know if its reserved" do
    refute SoFarSoGood::Clauses["52.203-5"].reserved?
    assert SoFarSoGood::Clauses["52.203-1"].reserved?
  end

  should "convert the body to markdown" do
    assert_includes @clause.body(:format => :markdown), "As prescribed in 3.404, insert the following clause:\n\n"
  end

  should "convert the extract to markdown" do
    assert_includes @clause.extract(:format => :markdown), "### Covenant Against Contingent Fees (APR 1984)\n\n(a)"
  end

  should "build the link" do
    assert_equal "http://www.law.cornell.edu/cfr/text/48/52.203-5", @clause.link
  end

  should "put out valid json" do
    assert JSON.parse SoFarSoGood::Clauses["52.203-5"].to_json
  end
end
