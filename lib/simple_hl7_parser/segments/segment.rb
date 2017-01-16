module SimpleHL7Parser
  module Segment
    attr_reader :segment_array, :obr

    def initialize(segment_array, obr = nil)
      @segment_array = segment_array
      @obr = obr
    end

    def segment_type
      segment_array.first
    end

    def method_missing(symbol, *args, &block)
      if symbol.to_s.include?('?')
        return "#{segment_type}?".to_sym == symbol.upcase
      end

      if self.class::COLUMN_MAP[symbol]
        segment_array[self.class::COLUMN_MAP[symbol]]
      else
        super
      end
    end

    def respond_to_missing?(symbol, include_private = false)
      "#{segment_type}?".to_sym == symbol.upcase? ||
        segment_array[self.class::COLUMN_MAP[symbol]] || super
    end
  end
end
