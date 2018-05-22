defmodule Hl7.V2_5_1.DataTypes.Hd do
  @moduledoc """
  The "HD" (HD) data type
  """

  use Hl7.DataType,
    fields: [
      namespace_id: nil,
      universal_id: nil,
      universal_id_type: nil
    ]
end