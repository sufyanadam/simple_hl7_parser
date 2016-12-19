module SimpleHL7Parser
  class HL7Message
    attr_reader :segments

    def initialize(segments)
      @segments = segments
    end

    def method_missing(symbol, *args, &block)
      segments_we_have = segments.select { |s| s.segment_type.to_sym == symbol.upcase }

      return segments_we_have unless segments_we_have.empty?

      super
    end
  end
end
