require "spec_helper"

RSpec.describe 'ORC Segment' do
  let(:hl7) do
    "MSH|^~\\&|GHH LAB|ELAB-3|GHH OE|BLDG4|200202150930||ORU^R01|CNTRL-3456|P|2.4\n" +
    "ORC|NW|12345|67890|GroupNum|CM|Y|Qty/Timing|ParentOrder|200202150930|EnteredBy1|VerifiedBy1|OrderProvider1|Location1|555-1234|200202160000|ReasonCode|OrgId|DeviceId|ActionBy1|N|FacilityName|FacilityAddr|555-5678|ProviderAddr|Modifier|OverrideReason|200202170000|C|LabOrder|PIN|15545^GLUCOSE|20200201|98765|WorkflowProfile"
  end

  describe 'originally mapped fields (1-24)' do
    subject { SimpleHL7Parser::HL7.parse(hl7).orc.first }

    it 'returns correct values for original fields (1-12)' do
      expect(subject.order_control).to eq 'NW'
      expect(subject.placer_order_number).to eq '12345'
      expect(subject.filler_order_number).to eq '67890'
      expect(subject.placer_group_number).to eq 'GroupNum'
      expect(subject.order_status).to eq 'CM'
      expect(subject.response_flag).to eq 'Y'
      expect(subject.quantity_timing).to eq 'Qty/Timing'
      expect(subject.parent_order).to eq 'ParentOrder'
      expect(subject.date_time_of_transaction).to eq '200202150930'
      expect(subject.entered_by).to eq 'EnteredBy1'
      expect(subject.verified_by).to eq 'VerifiedBy1'
      expect(subject.ordering_provider).to eq 'OrderProvider1'
    end

    it 'returns correct values for original fields (13-24)' do
      expect(subject.enterer_s_location).to eq 'Location1'
      expect(subject.call_back_phone_number).to eq '555-1234'
      expect(subject.order_effective_date_time).to eq '200202160000'
      expect(subject.order_control_code_reason).to eq 'ReasonCode'
      expect(subject.entering_organization).to eq 'OrgId'
      expect(subject.entering_device).to eq 'DeviceId'
      expect(subject.action_by).to eq 'ActionBy1'
      expect(subject.advanced_beneficiary_notice_code).to eq 'N'
      expect(subject.ordering_facility_name).to eq 'FacilityName'
      expect(subject.ordering_facility_address).to eq 'FacilityAddr'
      expect(subject.ordering_facility_phone_number).to eq '555-5678'
      expect(subject.ordering_provider_address).to eq 'ProviderAddr'
    end
  end

  describe 'newly added fields (25-34)' do
    subject { SimpleHL7Parser::HL7.parse(hl7).orc.first }

    it 'returns correct values for new fields' do
      expect(subject.order_status_modifier).to eq 'Modifier'
      expect(subject.advanced_beneficiary_notice_override_reason).to eq 'OverrideReason'
      expect(subject.fillers_expected_availability_date_time).to eq '200202170000'
      expect(subject.confidentiality_code).to eq 'C'
      expect(subject.order_type).to eq 'LabOrder'
      expect(subject.enterer_authorization_mode).to eq 'PIN'
      expect(subject.parent_universal_service_identifier).to eq '15545^GLUCOSE'
      expect(subject.advanced_beneficiary_notice_date).to eq '20200201'
      expect(subject.alternate_placer_order_number).to eq '98765'
      expect(subject.order_workflow_profile).to eq 'WorkflowProfile'
    end
  end

  describe 'complete field coverage' do
    subject { SimpleHL7Parser::HL7.parse(hl7).orc.first }

    it 'all 34 ORC fields are accessible' do
      # Verify all fields can be accessed without raising errors
      expect { subject.order_control }.not_to raise_error
      expect { subject.placer_order_number }.not_to raise_error
      expect { subject.filler_order_number }.not_to raise_error
      expect { subject.placer_group_number }.not_to raise_error
      expect { subject.order_status }.not_to raise_error
      expect { subject.response_flag }.not_to raise_error
      expect { subject.quantity_timing }.not_to raise_error
      expect { subject.parent_order }.not_to raise_error
      expect { subject.date_time_of_transaction }.not_to raise_error
      expect { subject.entered_by }.not_to raise_error
      expect { subject.verified_by }.not_to raise_error
      expect { subject.ordering_provider }.not_to raise_error
      expect { subject.enterer_s_location }.not_to raise_error
      expect { subject.call_back_phone_number }.not_to raise_error
      expect { subject.order_effective_date_time }.not_to raise_error
      expect { subject.order_control_code_reason }.not_to raise_error
      expect { subject.entering_organization }.not_to raise_error
      expect { subject.entering_device }.not_to raise_error
      expect { subject.action_by }.not_to raise_error
      expect { subject.advanced_beneficiary_notice_code }.not_to raise_error
      expect { subject.ordering_facility_name }.not_to raise_error
      expect { subject.ordering_facility_address }.not_to raise_error
      expect { subject.ordering_facility_phone_number }.not_to raise_error
      expect { subject.ordering_provider_address }.not_to raise_error
      expect { subject.order_status_modifier }.not_to raise_error
      expect { subject.advanced_beneficiary_notice_override_reason }.not_to raise_error
      expect { subject.fillers_expected_availability_date_time }.not_to raise_error
      expect { subject.confidentiality_code }.not_to raise_error
      expect { subject.order_type }.not_to raise_error
      expect { subject.enterer_authorization_mode }.not_to raise_error
      expect { subject.parent_universal_service_identifier }.not_to raise_error
      expect { subject.advanced_beneficiary_notice_date }.not_to raise_error
      expect { subject.alternate_placer_order_number }.not_to raise_error
      expect { subject.order_workflow_profile }.not_to raise_error
    end
  end
end
