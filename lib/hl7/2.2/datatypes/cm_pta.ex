defmodule HL7.V2_2.DataTypes.Cmpta do
  @moduledoc false

  use HL7.DataType,
    fields: [
      policy_type: nil,
      amount_class: nil,
      amount: nil
    ]
end
