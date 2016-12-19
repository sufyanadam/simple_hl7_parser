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

  class MSHSegment
    include Segment

    COLUMN_MAP = {
      field_separator: 1,
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
      alternate_character_set_handling_Scheme: 19,
    }
  end

  class PIDSegment
    include Segment

    COLUMN_MAP = {
      patient_id:  2,
      patient_identifier_list:  3,
      alternae_patient_id:  4,
      patientname:  5,
      mother_maiden_name:  6,
      date_of_birth:  7,
      sex:  8,
      patientalias:  9,
      race:  10,
      patient_address:  11,
      county_ode:  12,
      phone_nmber_home:  13,
      phone_nmber_business:  14,
      primary_language:  15,
      marital_status:  16,
      religion:  17,
      patient_account_number:  18,
      ssn_numer_patient:  19,
      driver_license_number_patient:  20,
      mothers_identifier:  21,
      ethnic_roup:  22,
      birth_pace:  23,
      multiple_birth_indicator:  24,
      birth_oder:  25,
      citizenhip:  26,
      veteran_military_status:  27,
      nationaity:  28,
      patient_death_date_and_time:  29,
      patient_death_indicator:  30,
    }
  end

  class ORCSegment
    include Segment

    COLUMN_MAP = {
      order_control: 1,
      placer_order_number: 2,
      filler_order_number: 3,
      placer_group_number: 4,
      order_status: 5,
      response_flag: 6,
      quantity_timing: 7,
      parent_order: 8,
      date_time_of_transaction: 9,
      entered_by: 10,
      verified_by: 11,
      ordering_provider: 12,
      enterer_s_location: 13,
      call_back_phone_number: 14,
      order_effective_date_time: 15,
      order_control_code_reason: 16,
      entering_organization: 17,
      entering_device: 18,
      action_by: 19,
      advanced_beneficiary_notice_code: 20,
      ordering_facility_name: 21,
      ordering_facility_address: 22,
      ordering_facility_phone_number: 23,
      ordering_provider_address: 24,
    }
  end

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

  class OBXSegment
    include Segment

    COLUMN_MAP = {
      set_id:  1,
      value_type:  2,
      observation_identifier:  3,
      observation_sub_id:  4,
      observation_value:  5,
      units:  6,
      references_range:  7,
      abnormal_flags:  8,
      probability:  9,
      nature_of_abnormal_test:  10,
      observation_result_status:  11,
      date_last_obs_normal_values:  12,
      user_defined_access_checks:  13,
      date_time_of_the_observation:  14,
      producer_id:  15,
      responsible_observer:  16,
      observation_method:  17,
    }
  end
end
