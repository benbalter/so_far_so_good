module SoFarSoGood
  class Subchapter

    attr_reader :year
    attr_reader :title
    attr_reader :volume
    attr_reader :chapter
    attr_reader :name

    def initialize(hash)
      @volume  = hash[:volume]
      @chapter = hash[:chapter]
      @name    = hash[:name]
      @year    = SoFarSoGood::YEAR
      @title   = SoFarSoGood::TITLE
    end

    def numbers(options = {})
      @numbers ||= subparts(options).map { |s| s.number }
    end

    def subjects(options = {})
      @subjects ||= subparts(options).map { |s| s.subject }
    end

    def subparts(options = {})
      @subparts ||= sections.map { |node| SoFarSoGood::Subpart.new(to_hash.merge(:node => node)) }
      @subparts.select { |subpart| options.all? { |k,v| subpart.send(k) == v } }
    end

    def to_md(options = {})
      links = options.delete(:links) == true
      rows = subparts(options).map { |c| [ links ? "[#{c.number}](#{c.link})" : c.number , c.subject] }
      Terminal::Table.new(:rows => rows, :style => { :border_i => "|" }, :headings => HEADINGS).to_s
    end

    def to_json(options = {})
      subparts(options).to_json(options)
    end

    def to_csv(options = {})
      CSV.generate do |csv|
        csv << HEADINGS
        subparts(options).each do |c|
          csv << [c.number , c.subject]
        end
      end
    end

    def to_hash
      {
        :year    => year,
        :title   => title,
        :volume  => volume,
        :chapter => chapter,
        :name    => name
      }
    end

    def [](number)
      subparts.find { |s| s.number == number }
    end

    def inspect
      "#<SoFarSoGood::Subchapter year=#{year} title=#{title} volume=#{volume} chapter=#{chapter} name=\"#{name}\">"
    end

    private

    def filename
      "CFR-#{YEAR}-title#{TITLE}-vol#{volume}-chap#{chapter}-subchapH.xml"
    end

    def source_path
      @source_path ||= File.expand_path filename, SoFarSoGood.vendor_directory
    end

    def doc
      @doc ||= Nokogiri::XML(File.open(source_path)) do |config|
        config.noblanks.nonet
      end
    end

    def sections
      @subpart ||= doc.css("PART SUBPART")[name == "FAR" ? 4 : 3].children.css("SECTION")
    end
  end
end
