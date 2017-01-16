require 'simple_hl7_parser/segments/segment'

module SimpleHL7Parser
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
end
