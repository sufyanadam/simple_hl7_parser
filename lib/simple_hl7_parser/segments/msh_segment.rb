require 'simple_hl7_parser/segments/segment'

module SimpleHL7Parser
  class MSHSegment
    include Segment

    COLUMN_MAP = {
      field_separator: 1,
      encoding_characters: 1,
      sending_application: 2,
      sending_facility: 3,
      receiving_application: 4,
      receiving_facility: 5,
      date_time_of_message: 6,
      security: 7,
      message_type: 8,
      message_control_id: 9,
      processing_id: 10,
      version_id: 11,
      sequence_number: 12,
      continuation_pointer: 13,
      accept_acknowledgment_type: 14,
      application_acknowledgment_type: 15,
      country_code: 16,
      character_set: 17,
      principal_language_of_message: 18,
      alternate_character_set_handling_scheme: 19,
      alternate_character_set_handling_Scheme: 19, # deprecated - use alternate_character_set_handling_scheme
      message_profile_identifier: 20,
      sending_responsible_organization: 21,
      receiving_responsible_organization: 22,
      sending_network_address: 23,
      receiving_network_address: 24,
    }
  end
end
