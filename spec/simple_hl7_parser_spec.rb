require "spec_helper"

describe SimpleHL7Parser do
  it "has a version number" do
    expect(SimpleHL7Parser::VERSION).not_to be nil
  end

  describe SimpleHL7Parser::HL7 do
    describe '.parse' do
      subject { described_class.parse(hl7) }

      let(:hl7) { File.read('spec/fixtures/sample.hl7') }

      it 'returns a Simple::HL7Message with the correct attributes' do
        msg = subject
        expect(msg.msh.first.message_type).to eq 'ORU^R01'
        expect(msg.obx.first.obr.universal_service_id).to eq '15545^GLUCOSE'
        expect(msg.obx.last.obr.universal_service_id).to eq '15545^GLUCOSE'
        expect(msg.obx.first.observation_identifier).to eq '1554-5^GLUCOSE^POST 12H CFST:MCNC:PT:SER/PLAS:QN'
        expect(msg.obx.first.observation_value).to eq '^182'
        expect(msg.obx.first.units).to eq 'mg/dl'
      end
    end
  end
end
