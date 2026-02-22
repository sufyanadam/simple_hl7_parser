require 'simple_hl7_parser/segments/segment'

module SimpleHL7Parser
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
      interpretation_codes:  8,
      abnormal_flags:  8, # deprecated - use interpretation_codes
      probability:  9,
      nature_of_abnormal_test:  10,
      observation_result_status:  11,
      effective_date_reference_range:  12,
      date_last_obs_normal_values:  12, # deprecated - use effective_date_reference_range
      user_defined_access_checks:  13,
      date_time_of_the_observation:  14,
      producer_id:  15,
      responsible_observer:  16,
      observation_method:  17,
      equipment_instance_identifier:  18,
      date_time_of_analysis:  19,
      observation_site:  20,
      observation_instance_identifier:  21,
      mood_code:  22,
      performing_organization_name:  23,
      performing_organization_address:  24,
      performing_organization_medical_director:  25,
      patient_results_release_category:  26,
      root_cause:  27,
      local_process_control:  28,
    }
  end
end
