module SoFarSoGood
  class Clauses
    class << self

      HEADINGS = ["Clause", "Description"]

      def numbers(options = {})
        @numbers ||= clauses(options).map { |c| c.number }
      end

      def subjects(options = {})
        @subjects ||= clauses(options).map { |c| c.subject }
      end
      alias_method :descriptions, :subjects

      def clauses(options = {})
        options = {:exclude_reserved => false}.merge(options)
        @clauses ||= sections.map { |node| SoFarSoGood::Clause.new(node) }
        if options[:exclude_reserved]
          @clauses.reject { |c| c.reserved }
        else
          @clauses
        end 
      end
      alias_method :list, :clauses

      def to_md
        @md ||= Terminal::Table.new(:rows => rows, :style => { :border_i => "|" }, :headings => HEADINGS).to_s
      end

      def to_json
        @json ||= clauses.to_json
      end

      def [](number)
        clauses.find { |c| c.number == number }
      end

      private

      def source_path
        File.expand_path "CFR-2010-title48-vol2-chap1-subchapH.xml", SoFarSoGood.vendor_directory
      end

      def doc
        @doc ||= Nokogiri::XML(File.open(source_path)) do |config|
          config.noblanks.nonet
        end
      end

      def sections
        @subpart ||= doc.css("PART SUBPART")[4].children.css("SECTION")
      end

      def rows(options={})
        @rows ||= clauses(options).map { |c| [c.number, c.subject]}
      end
    end
  end
end
