require 'helper'
require 'open3'

class TestSoFarSoGoodBin < Minitest::Test
  should "work via CLI" do
    output, status = Open3.capture2e("bundle", "exec", "bin/far", "52.222-3")
    assert_equal 0, status.exitstatus
    assert output.include? "Convict Labor"
  end
end
