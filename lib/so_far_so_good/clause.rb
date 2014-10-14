module SoFarSoGood
  class Clause

    attr_reader :number
    attr_reader :subject
    attr_reader :reserved
    attr_reader :citation
    attr_reader :extract
    attr_reader :body

    def initialize(node)
      @number = node.css("SECTNO").text.strip
      @subject = node.css("SUBJECT, RESERVED").text.strip
      @reserved = !node.css("RESERVED").text.empty?
      @citation = node.css("CITA").text.strip
      @extract = node.css("EXTRACT").text.strip
      @body = node.children.css("P").text.strip
    end

    def reserved?
      !!@reserved
    end

    def to_hash
      {
        :number    => @number,
        :subject   => @subject,
        :reserverd => @reserved,
        :citation  => @citation,
        :extract   => @extract,
        :body      => @body
      }
    end

    def to_json(options = {})
      to_hash.to_json(options)
    end

    def inspect
      "#<SoFarSoGood::Clause @number=\"#{@number}\" @subject=\"#{@subject}\" @reserved=\"#{@reserved}\""
    end
  end
end
