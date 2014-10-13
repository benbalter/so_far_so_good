module SoFarSoGood
  class Clauses
    class << self

      HEADINGS = ["Clause", "Description"]

      def numbers
        @numbers ||= subpart.css("SECTNO").map { |n| n.text.strip }
      end

      def subjects
        @subjects ||= subpart.css("SUBJECT").map { |n| n.text.strip }
      end

      def sections
        @sections ||= begin
          hash = {}
          numbers.each_with_index { |number, index| hash[number] = subjects[index] }
          hash
        end
      end

      def to_md
        @md ||= Terminal::Table.new(:rows => rows, :style => { :border_i => "|" }, :headings => HEADINGS).to_s
      end

      def to_json
        @json ||= sections.to_json
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

      def subpart
        @subpart ||= doc.css("SUBPART")[1]
      end

      def rows
        @rows ||= begin
          rows = []
          sections.each { |number, description| rows << [number,description] }
          rows
        end
      end
    end
  end
end
