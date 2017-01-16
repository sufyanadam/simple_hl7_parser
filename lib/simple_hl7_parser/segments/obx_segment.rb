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
