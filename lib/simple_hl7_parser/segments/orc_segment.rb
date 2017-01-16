require 'simple_hl7_parser/segments/segment'

module SimpleHL7Parser
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
end
