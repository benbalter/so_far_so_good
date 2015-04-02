require "nokogiri"
require "terminal-table"
require "reverse_markdown"
require "json"
require 'csv'
require_relative "so_far_so_good/version"
require_relative "so_far_so_good/subchapter"
require_relative "so_far_so_good/subpart"

module SoFarSoGood

  HEADINGS = ["Clause", "Description"]
  YEAR = 2014
  TITLE = 48

  class << self
    def far
      @far ||= SoFarSoGood::Subchapter.new(:name => "FAR",   :volume => 2, :chapter => 1)
    end

    def dfars
      @dfars ||= SoFarSoGood::Subchapter.new(:name => "DFARS", :volume => 3, :chapter => 2)
    end

    def subchapters
      [far, dfars]
    end

    def subparts(options = {})
      subchapters.map { |d| d.subparts(options) }.flatten
    end

    def [](subpart)
      subparts.find { |s| s.number == subpart }
    end

    def vendor_directory
      File.expand_path "../vendor", File.dirname(__FILE__)
    end
  end
end
