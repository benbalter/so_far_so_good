module SoFarSoGood
  class Clause

    attr_reader :node

    def initialize(node)
      @node = node
      normalize!
    end

    def number
      @number ||= node.css("SECTNO").text.strip
    end

    def subject
      @subject ||= node.css("SUBJECT, RESERVED").text.strip
    end

    def reserved?
      @reserved ||= !node.css("RESERVED").text.empty?
    end
    alias_method :reserved, :reserved?

    def citation
      @citation ||= node.css("CITA").text.strip
    end

    def link
      @link ||= "http://www.law.cornell.edu/cfr/text/48/#{number}"
    end

    def extract(options = {})
      options = {:format => :html}.merge(options)
      @extract ||= node.css("EXTRACT").inner_html
      if options[:format] == :markdown
        ReverseMarkdown.convert @extract
      else
        @extract
      end
    end

    def body(options = {})
      options = {:format => :html}.merge(options)
      @body ||= node.css("> P").to_html
      if options[:format] == :markdown
        ReverseMarkdown.convert @body
      else
        @body
      end
    end

    def to_hash(options={})
      {
        :number    => number,
        :subject   => subject,
        :reserverd => reserved,
        :citation  => citation,
        :extract   => extract(options),
        :body      => body(options),
        :link      => link
      }
    end

    def to_json(options = {})
      to_hash(options).to_json(options)
    end

    def inspect
      "#<SoFarSoGood::Clause number=\"#{number}\" subject=\"#{subject}\" reserved=#{reserved}>"
    end

    private

    def normalize!
      node.children.css("E").each { |n| n.name = "em" }
      node.children.css("HD").each { |n| n.name = "h3" }
    end
  end
end
