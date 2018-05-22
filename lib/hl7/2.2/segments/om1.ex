defmodule Hl7.V2_2.Segments.OM1 do
  @moduledoc """
  HL7 segment data structure for "OM1"
  """

  require Logger
  alias Hl7.V2_2.{DataTypes}

  use Hl7.Segment,
    fields: [
      segment: nil,
      segment_type_id: nil,
      sequence_number_test_observation_master_file: nil,
      producers_test_observation_id: DataTypes.Ce,
      permitted_data_types: nil,
      specimen_required: nil,
      producer_id: DataTypes.Ce,
      observation_description: nil,
      other_test_observation_ids_for_the_observation: DataTypes.Ce,
      other_names: nil,
      preferred_report_name_for_the_observation: nil,
      preferred_short_name_or_mnemonic_for_observation: nil,
      preferred_long_name_for_the_observation: nil,
      orderability: nil,
      identity_of_instrument_used_to_perform_this_study: DataTypes.Ce,
      coded_representation_of_method: DataTypes.Ce,
      portable: nil,
      observation_producing_department_section: nil,
      telephone_number_of_section: nil,
      nature_of_test_observation: nil,
      report_subheader: DataTypes.Ce,
      report_display_order: nil,
      date_time_stamp_for_any_change_in_definition_for_obs: DataTypes.Ts,
      effective_date_time_of_change: DataTypes.Ts,
      typical_turn_around_time: nil,
      processing_time: nil,
      processing_priority: nil,
      reporting_priority: nil,
      outside_sites_where_observation_may_be_performed: DataTypes.Ce,
      address_of_outside_sites: DataTypes.Ad,
      phone_number_of_outside_site: nil,
      confidentiality_code: nil,
      observations_required_to_interpret_the_observation: DataTypes.Ce,
      interpretation_of_observations: nil,
      contraindications_to_observations: DataTypes.Ce,
      reflex_tests_observations: DataTypes.Ce,
      rules_that_trigger_reflex_testing: nil,
      fixed_canned_message: DataTypes.Ce,
      patient_preparation: nil,
      procedure_medication: DataTypes.Ce,
      factors_that_may_affect_the_observation: nil,
      test_observation_performance_schedule: nil,
      description_of_test_methods: nil
    ]
end