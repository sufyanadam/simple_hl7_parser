require "spec_helper"

RSpec.describe 'OBX Segment' do
  let(:hl7) do
    "MSH|^~\\&|GHH LAB|ELAB-3|GHH OE|BLDG4|200202150930||ORU^R01|CNTRL-3456|P|2.4\n" +
    "OBX|1|NM|1554-5^GLUCOSE^POST 12H CFST:MCNC:PT:SER/PLAS:QN|1|^182|mg/dl|70_100|N|||F|||200202160730|ProducerId^ProducerName|ResponsibleObserver^ObserverName|LIS||SiteA|InstanceId|EventMood|OrgName|OrgAddress|MedDirector|ReleaseCategory|RootCauseInfo|ProcessControl"
  end

  describe 'existing fields (1-7, 9-11, 13-17)' do
    subject { SimpleHL7Parser::HL7.parse(hl7).obx.first }

    it 'returns correct values for existing fields' do
      expect(subject.set_id).to eq '1'
      expect(subject.value_type).to eq 'NM'
      expect(subject.observation_identifier).to eq '1554-5^GLUCOSE^POST 12H CFST:MCNC:PT:SER/PLAS:QN'
      expect(subject.observation_sub_id).to eq '1'
      expect(subject.observation_value).to eq '^182'
      expect(subject.units).to eq 'mg/dl'
      expect(subject.references_range).to eq '70_100'
      expect(subject.probability).to eq ''
      expect(subject.nature_of_abnormal_test).to eq ''
      expect(subject.observation_result_status).to eq 'F'
      expect(subject.user_defined_access_checks).to eq ''
      expect(subject.date_time_of_the_observation).to eq '200202160730'
      expect(subject.producer_id).to eq 'ProducerId^ProducerName'
      expect(subject.responsible_observer).to eq 'ResponsibleObserver^ObserverName'
      expect(subject.observation_method).to eq 'LIS'
    end
  end

  describe 'renamed fields - backward compatibility' do
    subject { SimpleHL7Parser::HL7.parse(hl7).obx.first }

    describe 'field 8: interpretation_codes (new name) and abnormal_flags (deprecated)' do
      it 'returns correct value using new name' do
        expect(subject.interpretation_codes).to eq 'N'
      end

      it 'returns correct value using deprecated name for backward compatibility' do
        expect(subject.abnormal_flags).to eq 'N'
      end

      it 'both names point to the same field value' do
        expect(subject.interpretation_codes).to eq subject.abnormal_flags
      end
    end

    describe 'field 12: effective_date_reference_range (new name) and date_last_obs_normal_values (deprecated)' do
      it 'returns correct value using new name' do
        expect(subject.effective_date_reference_range).to eq ''
      end

      it 'returns correct value using deprecated name for backward compatibility' do
        expect(subject.date_last_obs_normal_values).to eq ''
      end

      it 'both names point to the same field value' do
        expect(subject.effective_date_reference_range).to eq subject.date_last_obs_normal_values
      end
    end
  end

  describe 'new fields (18-28)' do
    subject { SimpleHL7Parser::HL7.parse(hl7).obx.first }

    it 'returns correct values for new fields' do
      expect(subject.equipment_instance_identifier).to eq ''
      expect(subject.date_time_of_analysis).to eq 'SiteA'
      expect(subject.observation_site).to eq 'InstanceId'
      expect(subject.observation_instance_identifier).to eq 'EventMood'
      expect(subject.mood_code).to eq 'OrgName'
      expect(subject.performing_organization_name).to eq 'OrgAddress'
      expect(subject.performing_organization_address).to eq 'MedDirector'
      expect(subject.performing_organization_medical_director).to eq 'ReleaseCategory'
      expect(subject.patient_results_release_category).to eq 'RootCauseInfo'
      expect(subject.root_cause).to eq 'ProcessControl'
      expect(subject.local_process_control).to be_nil
    end
  end

  describe 'complete field coverage' do
    subject { SimpleHL7Parser::HL7.parse(hl7).obx.first }

    it 'all 28 OBX fields are accessible' do
      # Verify all fields can be accessed without raising errors
      expect { subject.set_id }.not_to raise_error
      expect { subject.value_type }.not_to raise_error
      expect { subject.observation_identifier }.not_to raise_error
      expect { subject.observation_sub_id }.not_to raise_error
      expect { subject.observation_value }.not_to raise_error
      expect { subject.units }.not_to raise_error
      expect { subject.references_range }.not_to raise_error
      expect { subject.interpretation_codes }.not_to raise_error
      expect { subject.probability }.not_to raise_error
      expect { subject.nature_of_abnormal_test }.not_to raise_error
      expect { subject.observation_result_status }.not_to raise_error
      expect { subject.effective_date_reference_range }.not_to raise_error
      expect { subject.user_defined_access_checks }.not_to raise_error
      expect { subject.date_time_of_the_observation }.not_to raise_error
      expect { subject.producer_id }.not_to raise_error
      expect { subject.responsible_observer }.not_to raise_error
      expect { subject.observation_method }.not_to raise_error
      expect { subject.equipment_instance_identifier }.not_to raise_error
      expect { subject.date_time_of_analysis }.not_to raise_error
      expect { subject.observation_site }.not_to raise_error
      expect { subject.observation_instance_identifier }.not_to raise_error
      expect { subject.mood_code }.not_to raise_error
      expect { subject.performing_organization_name }.not_to raise_error
      expect { subject.performing_organization_address }.not_to raise_error
      expect { subject.performing_organization_medical_director }.not_to raise_error
      expect { subject.patient_results_release_category }.not_to raise_error
      expect { subject.root_cause }.not_to raise_error
      expect { subject.local_process_control }.not_to raise_error
    end
  end
end
