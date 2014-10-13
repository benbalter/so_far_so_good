module SoFarSoGood
  class Clauses
    class << self

      def numbers
        @numbers ||= subpart.css("SECTNO").map { |n| n.text }
      end

      def subjects
        @subjects ||= subpart.css("SUBJECT").map { |n| n.text }
      end

      def sections
        @sections ||= begin
          hash = {}
          numbers.each_with_index do |number, index|
            hash[number] = subjects[index]
          end
          hash
        end
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
    end
  end
end
