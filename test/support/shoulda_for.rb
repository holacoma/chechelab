module Shoulda
  module BulkDsl
    def context_for(base_description, *raw_data, &block)
      raise ArgumentError, "Block is required" unless block
      iterate_rows(raw_data) do |values|
        context(label_for(base_description, block, values)) do
          instance_exec(*values, &block)
        end
      end
    end

    def should_for(base_description, *raw_data, &block)
      raise ArgumentError, "Block is required" unless block
      iterate_rows(raw_data) do |values|
        should(label_for(base_description, block, values)) do
          instance_exec(*values, &block)
        end
      end
    end

    private

    def iterate_rows(raw_data)
      rows = normalize_rows(raw_data)
      rows.each { |values| yield(values) }
    end

    def normalize_rows(raw_data)
      source =
        if raw_data.length == 1 && enumerable_argument?(raw_data.first)
          raw_data.first
        else
          raw_data
        end

      rows = Array(source)
      raise ArgumentError, "Data set can't be empty" if rows.empty?

      rows.map { |row| row.is_a?(Array) ? row : [row] }
    end

    def enumerable_argument?(value)
      value.respond_to?(:to_a) && !value.is_a?(String)
    end

    def label_for(base_description, block, values)
      suffix = format_suffix(block, values)
      suffix.empty? ? base_description : "#{base_description} (#{suffix})"
    end

    def format_suffix(block, values)
      param_names = block.parameters.map { |(_, name)| name }.compact
      return values.map(&:inspect).join(", ") if param_names.empty?

      param_names.zip(values).map do |name, value|
        next unless name
        "#{name}=#{value.inspect}"
      end.compact.join(", ")
    end
  end
end

Shoulda::Context::Context.include(Shoulda::BulkDsl)
ActiveSupport::TestCase.extend(Shoulda::BulkDsl)
