require 'helper'

class TestSoFarSoGoodBin < Minitest::Test
  should "work via CLI" do
    output = `bundle exec far 52.222-3`
    assert output.include? "Convict Labor"
  end
end
