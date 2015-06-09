module ValidationErrorReporter
  class OptionsValidator

    class << self

      def validate!(options)
        if options[:models]
          options[:models].split(',').collect do |class_name|
            unless ActiveRecord.descendants.include?(class_name)
              raise_argument_error "Chosen model '#{class_name}' does not exist"
            end
          end
        end
        unless options[:print]
          unless options[:email_to].present?
            raise_argument_error "Missing required option 'mail_to'"
          end
          unless options[:email_from].present?
            raise_argument_error "Missing required option 'mail_from'"
          end
        end
      end

      private

      def raise_argument_error(message)
        raise ArgumentError, message
      end
    end
  end
  class OptionsValidator
    class << self
      def validate!(options)
        if options[:models]
          options[:models].split(',').collect do |class_name|
            unless const_defined?(class_name) && ActiveRecord::Base.descendants.include?(class_name.constantize)
              raise_argument_error "Chosen model '#{class_name}' does not exist"
            end
          end
        end
        unless options[:print]
          unless options[:email_to].present?
            raise_argument_error "Missing required option 'email_to'"
          end
          unless options[:email_from].present?
            raise_argument_error "Missing required option 'email_from'"
          end
        end
      end

      private

      def raise_argument_error(message)
        raise ArgumentError, message
      end
    end
  end
end
