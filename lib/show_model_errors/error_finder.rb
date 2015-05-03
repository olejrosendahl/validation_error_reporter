module ShowModelErrors
  class ErrorFinder

    class << self

      def get_errors(models)
        errors = []
        models.collect do |model|
          next unless ActiveRecord::Base.connection.table_exists? model.table_name
          model.all.collect do |row|
            unless row.valid?
              errors << [model.model_name.human, row.public_send(model.primary_key), row.errors.full_messages]
            end
          end
        end
        errors
      end
    end

  end

end
