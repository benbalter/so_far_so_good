require "nokogiri"
require "terminal-table"
require "json"
require_relative "so_far_so_good/version"
require_relative "so_far_so_good/clauses"

module SoFarSoGood
  class << self
    def vendor_directory
      File.expand_path "../vendor", File.dirname(__FILE__)
    end

    def clauses
      SoFarSoGood::Clauses.sections
    end
  end
end
