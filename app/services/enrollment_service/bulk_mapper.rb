# -*- encoding : utf-8 -*-
module EnrollmentService
  class BulkMapper
    attr_reader :klass, :columns, :default_options

    def initialize(klass, columns, opts={})
      @klass = klass
      @columns = columns
      @default_options = opts
    end

    def insert(values, opts={})
      choosed_columns = opts.delete(:columns) || columns
      # klass.import(choosed_columns, values, default_options.merge(opts))
      values.each do |attr_values|
        hash = choosed_columns.zip(attr_values).to_h
        begin
          if :id.in?(hash.keys)
            klass.find(hash[:id]).update(hash.except(:id))
          else
            klass.create(hash)
          end
        rescue ActiveRecord::RecordNotUnique
        end
      end

      values
    end
  end
end
