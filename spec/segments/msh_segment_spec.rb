require "spec_helper"

RSpec.describe 'MSH Segment' do
  let(:hl7) do
    "MSH|^~\\&|SENDING_APP|SENDING_FAC|RECEIVING_APP|RECEIVING_FAC|20200101120000|SecurityInfo|ADT^A04|MSG123|P|2.3|SEQ123|ContinuationPtr|N|N|US|UTF-8|EN|ASCII|ProfileID|SendingOrg|ReceivingOrg|192.168.1.1|192.168.1.2"
  end

  describe 'encoding characters and field separator' do
    subject { SimpleHL7Parser::HL7.parse(hl7).msh.first }

    it 'returns encoding characters using the new correct name' do
      expect(subject.encoding_characters).to eq '^~\\&'
    end

    it 'returns field separator for backward compatibility' do
      expect(subject.field_separator).to eq '^~\\&'
    end

    it 'both names point to the same field value' do
      expect(subject.encoding_characters).to eq subject.field_separator
    end
  end

  describe 'all standard fields (2-19)' do
    subject { SimpleHL7Parser::HL7.parse(hl7).msh.first }

    it 'returns correct values for all fields' do
      expect(subject.sending_application).to eq 'SENDING_APP'
      expect(subject.sending_facility).to eq 'SENDING_FAC'
      expect(subject.receiving_application).to eq 'RECEIVING_APP'
      expect(subject.receiving_facility).to eq 'RECEIVING_FAC'
      expect(subject.date_time_of_message).to eq '20200101120000'
      expect(subject.security).to eq 'SecurityInfo'
      expect(subject.message_type).to eq 'ADT^A04'
      expect(subject.message_control_id).to eq 'MSG123'
      expect(subject.processing_id).to eq 'P'
      expect(subject.version_id).to eq '2.3'
      expect(subject.sequence_number).to eq 'SEQ123'
      expect(subject.continuation_pointer).to eq 'ContinuationPtr'
      expect(subject.accept_acknowledgment_type).to eq 'N'
      expect(subject.application_acknowledgment_type).to eq 'N'
      expect(subject.country_code).to eq 'US'
      expect(subject.character_set).to eq 'UTF-8'
      expect(subject.principal_language_of_message).to eq 'EN'
    end
  end

  describe 'corrected field name (MSH-20)' do
    subject { SimpleHL7Parser::HL7.parse(hl7).msh.first }

    it 'returns correct value using new field name with lowercase scheme' do
      expect(subject.alternate_character_set_handling_scheme).to eq 'ASCII'
    end

    it 'returns correct value using deprecated field name with capital Scheme' do
      expect(subject.alternate_character_set_handling_Scheme).to eq 'ASCII'
    end

    it 'both names point to the same field value' do
      expect(subject.alternate_character_set_handling_scheme).to eq subject.alternate_character_set_handling_Scheme
    end
  end

  describe 'newly added fields (21-25)' do
    subject { SimpleHL7Parser::HL7.parse(hl7).msh.first }

    it 'returns correct values for new fields' do
      expect(subject.message_profile_identifier).to eq 'ProfileID'
      expect(subject.sending_responsible_organization).to eq 'SendingOrg'
      expect(subject.receiving_responsible_organization).to eq 'ReceivingOrg'
      expect(subject.sending_network_address).to eq '192.168.1.1'
      expect(subject.receiving_network_address).to eq '192.168.1.2'
    end
  end

  describe 'complete field coverage' do
    subject { SimpleHL7Parser::HL7.parse(hl7).msh.first }

    it 'all 25 MSH fields are accessible' do
      # Verify all fields can be accessed without raising errors
      expect { subject.field_separator }.not_to raise_error
      expect { subject.encoding_characters }.not_to raise_error
      expect { subject.sending_application }.not_to raise_error
      expect { subject.sending_facility }.not_to raise_error
      expect { subject.receiving_application }.not_to raise_error
      expect { subject.receiving_facility }.not_to raise_error
      expect { subject.date_time_of_message }.not_to raise_error
      expect { subject.security }.not_to raise_error
      expect { subject.message_type }.not_to raise_error
      expect { subject.message_control_id }.not_to raise_error
      expect { subject.processing_id }.not_to raise_error
      expect { subject.version_id }.not_to raise_error
      expect { subject.sequence_number }.not_to raise_error
      expect { subject.continuation_pointer }.not_to raise_error
      expect { subject.accept_acknowledgment_type }.not_to raise_error
      expect { subject.application_acknowledgment_type }.not_to raise_error
      expect { subject.country_code }.not_to raise_error
      expect { subject.character_set }.not_to raise_error
      expect { subject.principal_language_of_message }.not_to raise_error
      expect { subject.alternate_character_set_handling_scheme }.not_to raise_error
      expect { subject.message_profile_identifier }.not_to raise_error
      expect { subject.sending_responsible_organization }.not_to raise_error
      expect { subject.receiving_responsible_organization }.not_to raise_error
      expect { subject.sending_network_address }.not_to raise_error
      expect { subject.receiving_network_address }.not_to raise_error
    end
  end

end
