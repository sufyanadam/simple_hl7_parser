require "spec_helper"

RSpec.describe 'OBR Segment' do
  let(:hl7) do
    "MSH|^~\\&|GHH LAB|ELAB-3|GHH OE|BLDG4|200202150930||ORU^R01|CNTRL-3456|P|2.4\n" +
    "OBR|1|12345|67890|15545^GLUCOSE|5|200202150900|200202160730|200202160800|CollVol|Collector1|A|DangerCode|ClinicalInfo|200202160730|SpecSource|OrderProvider|555-1234|PlacerField1|PlacerField2|FillerField1|FillerField2|200202170000|ChargePractice|DiagServ|F|ParentResult|Qty/Timing|ResultCopies|ObsGroupParentId|TransMode|ReasonStudy|PrincipalInterp|AssistantInterp|Technician1|Transcriptionist1|200202170100|5|TransLogistics|CollectorComment|TransArrangement|Y|Y|TransportComment|44060-6|Modifier|PlacerSupInfo|FillerSupInfo|DupReason|HandlingCode|15545^GLUCOSE^PARENT|ObsGroupId|ParentObsGroupId|98765|ParentOrder"
  end

  describe 'originally mapped fields (1-8, 14)' do
    subject { SimpleHL7Parser::HL7.parse(hl7).obr.first }

    it 'returns correct values for original fields' do
      expect(subject.set_id).to eq '1'
      expect(subject.placer_order_number).to eq '12345'
      expect(subject.filler_order_number).to eq '67890'
      expect(subject.universal_service_id).to eq '15545^GLUCOSE'
      expect(subject.priority).to eq '5'
      expect(subject.requested_date_time).to eq '200202150900'
      expect(subject.observation_date_time).to eq '200202160730'
      expect(subject.observation_end_date_time).to eq '200202160800'
      expect(subject.specimen_received_date_time).to eq '200202160730'
    end
  end

  describe 'newly added fields (9-13, 15-54)' do
    subject { SimpleHL7Parser::HL7.parse(hl7).obr.first }

    it 'returns correct values for new fields (9-13)' do
      expect(subject.collection_volume).to eq 'CollVol'
      expect(subject.collector_identifier).to eq 'Collector1'
      expect(subject.specimen_action_code).to eq 'A'
      expect(subject.danger_code).to eq 'DangerCode'
      expect(subject.relevant_clinical_information).to eq 'ClinicalInfo'
    end

    it 'returns correct values for new fields (15-24)' do
      expect(subject.specimen_source).to eq 'SpecSource'
      expect(subject.ordering_provider).to eq 'OrderProvider'
      expect(subject.order_callback_phone_number).to eq '555-1234'
      expect(subject.placer_field_1).to eq 'PlacerField1'
      expect(subject.placer_field_2).to eq 'PlacerField2'
      expect(subject.filler_field_1).to eq 'FillerField1'
      expect(subject.filler_field_2).to eq 'FillerField2'
      expect(subject.results_rpt_status_chng_date_time).to eq '200202170000'
      expect(subject.charge_to_practice).to eq 'ChargePractice'
      expect(subject.diagnostic_serv_sect_id).to eq 'DiagServ'
    end

    it 'returns correct values for new fields (25-34)' do
      expect(subject.result_status).to eq 'F'
      expect(subject.parent_result).to eq 'ParentResult'
      expect(subject.quantity_timing).to eq 'Qty/Timing'
      expect(subject.result_copies_to).to eq 'ResultCopies'
      expect(subject.parent_results_observation_identifier).to eq 'ObsGroupParentId'
      expect(subject.transportation_mode).to eq 'TransMode'
      expect(subject.reason_for_study).to eq 'ReasonStudy'
      expect(subject.principal_result_interpreter).to eq 'PrincipalInterp'
      expect(subject.assistant_result_interpreter).to eq 'AssistantInterp'
      expect(subject.technician).to eq 'Technician1'
    end

    it 'returns correct values for new fields (35-44)' do
      expect(subject.transcriptionist).to eq 'Transcriptionist1'
      expect(subject.scheduled_date_time).to eq '200202170100'
      expect(subject.number_of_sample_containers).to eq '5'
      expect(subject.transport_logistics_collected_sample).to eq 'TransLogistics'
      expect(subject.collector_comment).to eq 'CollectorComment'
      expect(subject.transport_arrangement_responsibility).to eq 'TransArrangement'
      expect(subject.transport_arranged).to eq 'Y'
      expect(subject.escort_required).to eq 'Y'
      expect(subject.planned_patient_transport_comment).to eq 'TransportComment'
      expect(subject.procedure_code).to eq '44060-6'
    end

    it 'returns correct values for new fields (45-54)' do
      expect(subject.procedure_code_modifier).to eq 'Modifier'
      expect(subject.placer_supplemental_service_information).to eq 'PlacerSupInfo'
      expect(subject.filler_supplemental_service_information).to eq 'FillerSupInfo'
      expect(subject.medically_necessary_duplicate_procedure_reason).to eq 'DupReason'
      expect(subject.result_handling).to eq 'HandlingCode'
      expect(subject.parent_universal_service_identifier).to eq '15545^GLUCOSE^PARENT'
      expect(subject.observation_group_id).to eq 'ObsGroupId'
      expect(subject.parent_observation_group_id).to eq 'ParentObsGroupId'
      expect(subject.alternate_placer_order_number).to eq '98765'
      expect(subject.parent_order).to eq 'ParentOrder'
    end
  end

  describe 'complete field coverage' do
    subject { SimpleHL7Parser::HL7.parse(hl7).obr.first }

    it 'all 54 OBR fields are accessible' do
      # Verify all fields can be accessed without raising errors
      expect { subject.set_id }.not_to raise_error
      expect { subject.placer_order_number }.not_to raise_error
      expect { subject.filler_order_number }.not_to raise_error
      expect { subject.universal_service_id }.not_to raise_error
      expect { subject.priority }.not_to raise_error
      expect { subject.requested_date_time }.not_to raise_error
      expect { subject.observation_date_time }.not_to raise_error
      expect { subject.observation_end_date_time }.not_to raise_error
      expect { subject.collection_volume }.not_to raise_error
      expect { subject.collector_identifier }.not_to raise_error
      expect { subject.specimen_action_code }.not_to raise_error
      expect { subject.danger_code }.not_to raise_error
      expect { subject.relevant_clinical_information }.not_to raise_error
      expect { subject.specimen_received_date_time }.not_to raise_error
      expect { subject.specimen_source }.not_to raise_error
      expect { subject.ordering_provider }.not_to raise_error
      expect { subject.order_callback_phone_number }.not_to raise_error
      expect { subject.placer_field_1 }.not_to raise_error
      expect { subject.placer_field_2 }.not_to raise_error
      expect { subject.filler_field_1 }.not_to raise_error
      expect { subject.filler_field_2 }.not_to raise_error
      expect { subject.results_rpt_status_chng_date_time }.not_to raise_error
      expect { subject.charge_to_practice }.not_to raise_error
      expect { subject.diagnostic_serv_sect_id }.not_to raise_error
      expect { subject.result_status }.not_to raise_error
      expect { subject.parent_result }.not_to raise_error
      expect { subject.quantity_timing }.not_to raise_error
      expect { subject.result_copies_to }.not_to raise_error
      expect { subject.parent_results_observation_identifier }.not_to raise_error
      expect { subject.transportation_mode }.not_to raise_error
      expect { subject.reason_for_study }.not_to raise_error
      expect { subject.principal_result_interpreter }.not_to raise_error
      expect { subject.assistant_result_interpreter }.not_to raise_error
      expect { subject.technician }.not_to raise_error
      expect { subject.transcriptionist }.not_to raise_error
      expect { subject.scheduled_date_time }.not_to raise_error
      expect { subject.number_of_sample_containers }.not_to raise_error
      expect { subject.transport_logistics_collected_sample }.not_to raise_error
      expect { subject.collector_comment }.not_to raise_error
      expect { subject.transport_arrangement_responsibility }.not_to raise_error
      expect { subject.transport_arranged }.not_to raise_error
      expect { subject.escort_required }.not_to raise_error
      expect { subject.planned_patient_transport_comment }.not_to raise_error
      expect { subject.procedure_code }.not_to raise_error
      expect { subject.procedure_code_modifier }.not_to raise_error
      expect { subject.placer_supplemental_service_information }.not_to raise_error
      expect { subject.filler_supplemental_service_information }.not_to raise_error
      expect { subject.medically_necessary_duplicate_procedure_reason }.not_to raise_error
      expect { subject.result_handling }.not_to raise_error
      expect { subject.parent_universal_service_identifier }.not_to raise_error
      expect { subject.observation_group_id }.not_to raise_error
      expect { subject.parent_observation_group_id }.not_to raise_error
      expect { subject.alternate_placer_order_number }.not_to raise_error
      expect { subject.parent_order }.not_to raise_error
    end
  end
end
