require 'simple_hl7_parser/hl7_message'
require 'simple_hl7_parser/segments/msh_segment'
require 'simple_hl7_parser/segments/pid_segment'
require 'simple_hl7_parser/segments/orc_segment'
require 'simple_hl7_parser/segments/obr_segment'
require 'simple_hl7_parser/segments/obx_segment'

module SimpleHL7Parser
  class HL7
    SEGMENT_MAP = {
      MSH:  MSHSegment,
      PID:  PIDSegment,
      ORC:  ORCSegment,
      OBR:  OBRSegment,
      OBX:  OBXSegment,
    }

    def self.parse(hl7)
      current_parent_obr = nil
      segments = hl7.split("\n").map do |line|
        segment_data = line.split('|')
        segment_type = segment_data.first
        current_parent_obr = nil unless %w[OBR OBX NTE].include?(segment_type)

        if klass = SEGMENT_MAP[segment_type.to_sym]
          if segment_type == 'OBR'
            current_parent_obr = klass.new(segment_data)
            next current_parent_obr
          end

          klass.new(segment_data, current_parent_obr)
        end
      end

      HL7Message.new(segments.compact)
    end
  end
end
