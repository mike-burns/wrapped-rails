require 'wrapped-rails/wrap_nilables'

ActiveRecord::Base.send(:include, WrapNilables)
