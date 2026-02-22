require "spec_helper"

RSpec.describe 'PID Segment' do
  describe 'backward compatibility with typo field names' do
    subject { SimpleHL7Parser::HL7.parse(hl7).pid.first }

    let(:hl7) do
      "MSH|^~\\&|GHH LAB|ELAB-3|GHH OE|BLDG4|200202150930||ORU^R01|CNTRL-3456|P|2.4\n" +
      "PID|1|12345|67890||Smith^Jane||19900101|M|ALIAS|White|123 Main St|County|555-1234|555-5678|ENG|S|CAT|ACC123|123456789|DL123|Mother123|African|US|N|3|US|Vet|American|20200101|N|N|High|20210101|Hospital|Species|Breed|Strain|Class|Tribe|"
    end

    it 'returns correct values for deprecated typo field names' do
      expect(subject.county_ode).to eq 'County'
      expect(subject.phone_nmber_home).to eq '555-1234'
      expect(subject.phone_nmber_business).to eq '555-5678'
      expect(subject.ssn_numer_patient).to eq '123456789'
      expect(subject.ethnic_roup).to eq 'African'
      expect(subject.birth_pace).to eq 'US'
      expect(subject.birth_oder).to eq '3'
      expect(subject.citizenhip).to eq 'US'
      expect(subject.nationaity).to eq 'American'
    end
  end

  describe 'new correct field names' do
    subject { SimpleHL7Parser::HL7.parse(hl7).pid.first }

    let(:hl7) do
      "MSH|^~\\&|GHH LAB|ELAB-3|GHH OE|BLDG4|200202150930||ORU^R01|CNTRL-3456|P|2.4\n" +
      "PID|1|12345|67890||Smith^Jane||19900101|M|ALIAS|White|123 Main St|County|555-1234|555-5678|ENG|S|CAT|ACC123|123456789|DL123|Mother123|African|US|N|3|US|Vet|American|20200101|N|N|High|20210101|Hospital|Species|Breed|Strain|Class|Tribe|"
    end

    it 'returns correct values for corrected field names' do
      expect(subject.county_code).to eq 'County'
      expect(subject.phone_number_home).to eq '555-1234'
      expect(subject.phone_number_business).to eq '555-5678'
      expect(subject.ssn_number_patient).to eq '123456789'
      expect(subject.ethnic_group).to eq 'African'
      expect(subject.birth_place).to eq 'US'
      expect(subject.birth_order).to eq '3'
      expect(subject.citizenship).to eq 'US'
      expect(subject.nationality).to eq 'American'
    end
  end

  describe 'new PID fields (31-40)' do
    subject { SimpleHL7Parser::HL7.parse(hl7).pid.first }

    let(:hl7) do
      "MSH|^~\\&|GHH LAB|ELAB-3|GHH OE|BLDG4|200202150930||ORU^R01|CNTRL-3456|P|2.4\n" +
      "PID|1|12345|67890||Smith^Jane||19900101|M|ALIAS|White|123 Main St|County|555-1234|555-5678|ENG|S|CAT|ACC123|123456789|DL123|Mother123|African|US|N|3|US|Vet|American|20200101|N|N|High|20210101|Hospital|Species|Breed|Strain|Class|Tribe|"
    end

    it 'returns correct values for new fields' do
      expect(subject.identity_unknown_indicator).to eq 'N'
      expect(subject.identity_reliability_code).to eq 'High'
      expect(subject.last_update_datetime).to eq '20210101'
      expect(subject.last_update_facility).to eq 'Hospital'
      expect(subject.taxonomic_classification_code).to eq 'Species'
      expect(subject.breed_code).to eq 'Breed'
      expect(subject.strain).to eq 'Strain'
      expect(subject.production_class_code).to eq 'Class'
      expect(subject.tribal_citizenship).to eq 'Tribe'
    end
  end
end
