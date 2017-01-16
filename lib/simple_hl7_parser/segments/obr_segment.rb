require 'simple_hl7_parser/segments/segment'

module SimpleHL7Parser
  class OBRSegment
    include Segment

    COLUMN_MAP = {
      set_id:  1,
      placer_order_number:  2,
      filler_order_number:  3,
      universal_service_id:  4,
      priority:  5,
      requested_date_time:  6,
      observation_date_time:  7,
      observation_end_date_time:  8,
    }
  end
end
