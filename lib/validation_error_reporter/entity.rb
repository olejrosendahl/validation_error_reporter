module ValidationErrorReporter

  class Entity

    def self.models_for(model_names = [])
      if model_names.nil? || model_names.empty?
        ActiveRecord::Base.descendants
      else
        model_names.collect do |model_name|
          model_name.classify.safe_constantize
        end
      end.reject do |model|
        !model.public_methods.include?(:all) || model.abstract_class? ||
          !model.table_exists? ||  model.name.include?("HABTM_")
      end
    end

  end
end
