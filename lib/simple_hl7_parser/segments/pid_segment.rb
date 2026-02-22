require 'simple_hl7_parser/segments/segment'

module SimpleHL7Parser
  class PIDSegment
    include Segment

    COLUMN_MAP = {
      patient_id:  2,
      patient_identifier_list:  3,
      alternae_patient_id:  4,  # deprecated: typo, use alternate_patient_id
      alternate_patient_id:  4,
      patientname:  5,
      mother_maiden_name:  6,
      date_of_birth:  7,
      sex:  8,
      patientalias:  9,
      race:  10,
      patient_address:  11,
      county_ode:  12,  # deprecated: typo, use county_code
      county_code:  12,
      phone_nmber_home:  13,  # deprecated: typo, use phone_number_home
      phone_number_home:  13,
      phone_nmber_business:  14,  # deprecated: typo, use phone_number_business
      phone_number_business:  14,
      primary_language:  15,
      marital_status:  16,
      religion:  17,
      patient_account_number:  18,
      ssn_numer_patient:  19,  # deprecated: typo, use ssn_number_patient
      ssn_number_patient:  19,
      driver_license_number_patient:  20,
      mothers_identifier:  21,
      ethnic_roup:  22,  # deprecated: typo, use ethnic_group
      ethnic_group:  22,
      birth_pace:  23,  # deprecated: typo, use birth_place
      birth_place:  23,
      multiple_birth_indicator:  24,
      birth_oder:  25,  # deprecated: typo, use birth_order
      birth_order:  25,
      citizenhip:  26,  # deprecated: typo, use citizenship
      citizenship:  26,
      veteran_military_status:  27,
      nationaity:  28,  # deprecated: typo, use nationality
      nationality:  28,
      patient_death_date_and_time:  29,
      patient_death_indicator:  30,
      identity_unknown_indicator:  31,
      identity_reliability_code:  32,
      last_update_datetime:  33,
      last_update_facility:  34,
      taxonomic_classification_code:  35,
      breed_code:  36,
      strain:  37,
      production_class_code:  38,
      tribal_citizenship:  39,
      patient_telecommunication_information:  40,
    }
  end
end
