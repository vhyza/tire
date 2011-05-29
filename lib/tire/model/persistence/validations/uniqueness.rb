module Tire
  module Model

    module Persistence

      module Validations
        module Uniqueness

          def self.included(base)
            base.class_eval do
              include ActiveModel::Validations
              extend ClassMethods
            end
          end

          # Validates if a field is unique 
          class UniquenessValidator < ActiveModel::EachValidator

            def setup(klass)
              @klass = klass
            end

            def validate_each(document, attribute, value)
              unless value.blank?
                result = @klass.search("#{attribute}:#{value}")
                if result.total > 0 and result.first.id != document.id
                  document.errors.add(attribute, :taken, :default => options[:message], :value => value)
                end
              end
            end

          end

          module ClassMethods
            def validates_uniqueness_of(*args)
              validates_with(UniquenessValidator, _merge_attributes(args))
            end
          end
        end
      end

    end
  end
end
