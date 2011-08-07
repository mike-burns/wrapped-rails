module WrapNilables
  def self.included(base)
    base.send(:include, InstanceMethods)
  end

  module InstanceMethods
    def read_attribute(attr_name)
      wrap_attributes!
      super(attr_name)
    end

    private

    def wrap_attributes!
      @attributes.each do |attr_name, value|
        if nilable?(attr_name)
          self.class.send(:define_method, attr_name.to_sym) do
            send(:"_#{attr_name}").wrapped
          end
        end
      end
    end

    def nilable?(attr_name)
      attr_name != 'id' &&
        !presence_validated?(attr_name) &&
        !null_constraint?(attr_name)
    end

    def presence_validated?(attr_name)
      self.class.validators_on(attr_name).any? do |v|
        v.is_a?(ActiveModel::Validations::PresenceValidator)
      end
    end

    def null_constraint?(attr_name)
      !self.class.columns_hash[attr_name].default.nil?
    end
  end
end
