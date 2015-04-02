require 'helper'

class TestSoFarSoGoodSubpart < Minitest::Test

  def setup
    @subchapter = SoFarSoGood.far
    @nodes = @subchapter.send(:sections)
    @subpart = SoFarSoGood::Subpart.new(:node => @nodes[6])
  end

  should "Store the node" do
    assert Nokogiri::XML::Element, @subpart.node.class
  end

  should "expose the subpart number" do
    assert_equal "52.203-5", @subpart.number
  end

  should "expose the subpart subject" do
    assert_equal "Covenant Against Contingent Fees.", @subpart.subject
  end

  should "know the cite" do
    assert_includes @subpart.citation, "48 FR 42478"
  end

  should "know the subpart body" do
    assert_includes @subpart.body, "As prescribed in 3.404,"
  end

  should "not include the extract in the subpart body" do
    refute_includes @subpart.body, "The Contractor warrants that no person or agency"
  end

  should "know the subpart extract" do
    assert_includes @subpart.extract, "The Contractor warrants that no person or agency"
  end

  should "know if its reserved" do
    refute @subchapter["52.203-5"].reserved?
    assert @subchapter["52.203-1"].reserved?
  end

  should "convert the body to markdown" do
    assert_includes @subpart.body(:format => :markdown), "As prescribed in 3.404, insert the following clause:\n\n"
  end

  should "convert the extract to markdown" do
    assert_includes @subpart.extract(:format => :markdown), "### Covenant Against Contingent Fees (MAY 2014)\n\n(a)"
  end

  should "not pass unknown tags in markdown" do
    refute_match /gpotable/, SoFarSoGood["52.225-4"].extract(:format => :markdown)
  end

  should "build the link" do
    assert_equal "http://www.law.cornell.edu/cfr/text/48/52.203-5", @subpart.link
  end

  should "put out valid json" do
    assert JSON.parse @subchapter["52.203-5"].to_json
  end
end
