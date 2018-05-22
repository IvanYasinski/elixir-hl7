defmodule Hl7.DataType do
  @callback new(data_list :: list) :: new_struct :: term
  @callback to_list(segment :: term) :: data_list :: list

  defmacro __using__(opts) do
    field_list = Keyword.get(opts, :fields, [])
    field_count = field_list |> Enum.count()
    field_list_with_overflow = field_list ++ [{:_overflow, nil}]
    field_data = field_list_with_overflow |> Enum.map(fn {k, _} -> {k, nil} end)

    quote do
      @behaviour Hl7.DataType

      defstruct unquote(field_data)

      def new(data_list) when is_list(data_list) do
        data_fields =
          unquote(field_list_with_overflow)
          |> Hl7.DataType.overflow_zip(data_list)
          |> Enum.reduce(
            %__MODULE__{},
            fn {{field_name, field_type}, field_data}, result ->
              result
              |> Map.put(field_name, Hl7.DataType.new_field(field_data, field_type))
            end
          )
      end

      def to_list(%__MODULE__{} = data) do
        Hl7.DataType.to_list(data, unquote(field_list_with_overflow), [])
      end

      def get_part(%__MODULE__{} = data, i) when is_integer(i) and i < unquote(field_count) do
        {f, _} = unquote(field_list) |> Enum.at(i)
        data |> Map.get(f, nil)
      end

      def get_part(%__MODULE__{} = data, i) when is_integer(i) do
        overflow_index = i - unquote(field_count)
        overflow = data |> Map.get(:_overflow, []) |> Enum.at(overflow_index, nil)
      end

      def get_part(%__MODULE__{} = data, field_name) when is_atom(field_name) do
        data |> Map.get(field_name, nil)
      end

      def get_part(%__MODULE__{} = data, field_name) when is_binary(field_name) do
        data |> Map.get(String.to_existing_atom(field_name), nil)
      end
    end
  end

  @doc false
  def new_field("", nil) do
    ""
  end

  def new_field(field_data, nil) do
    field_data
  end

  def new_field(field_data, field_type) when is_binary(field_data) do
    apply(field_type, :new, [[field_data]])
  end

  def new_field(field_data, field_type) when is_list(field_data) do
    apply(field_type, :new, [field_data])
  end

  @doc false
  def to_list(data, [{:_overflow, nil}], result) do
    data_value = Map.get(data, :_overflow)

    case data_value do
      # no overflow, return full result
      nil ->
        Enum.reverse(result)

      "" ->
        ["" | result] |> Enum.reverse()

      _ ->
        Enum.reduce(data_value, result, fn d, acc -> [d | acc] end) |> Enum.reverse()
    end
  end

  def to_list(data, [{k, nil} | p_tail], result) do
    data_value = Map.get(data, k)

    case data_value do
      nil -> Enum.reverse(result)
      _ -> [data_value | to_list(data, p_tail, result)]
    end
  end

  def to_list(data, [{k, v} | p_tail], result) do
    data_value = Map.get(data, k)

    case data_value do
      nil -> Enum.reverse(result)
      text when is_binary(text) -> [text | to_list(data, p_tail, result)]
      _ -> [apply(v, :to_list, [data_value]) | to_list(data, p_tail, result)]
    end
  end

  def to_list(_data, [], result) do
    Enum.reverse(result)
  end

  @doc false
  def overflow_zip(field_list, data_list) do
    overflow_zip([], field_list, data_list) |> Enum.reverse()
  end

  def overflow_zip(result, _, []) do
    result
  end

  @doc false
  def overflow_zip(result, [{:_overflow, nil}], overflow_data) when is_list(overflow_data) do
    [{{:_overflow, nil}, overflow_data} | result]
  end

  def overflow_zip(result, [field | field_tail], [data | data_tail]) do
    new_result = [{field, data} | result]
    overflow_zip(new_result, field_tail, data_tail)
  end
end