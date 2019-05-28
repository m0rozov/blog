require 'active_model'
require 'dry/monads/result'

class ApplicationValidator
  extend Dry::Monads::Result::Mixin
  include ActiveModel::Validations

  class << self
    def check(entity)
      v = new(entity)
      if v.valid?
        Success(entity)
      else
        Failure(v.error)
      end
    end
  end

  def initialize(entity)
    @entity = entity
    entity.attributes.except("id", "created_at", "updated_at").each do |name, value|
      instance_variable_set("@#{name}", value)
      self.class.send(:define_method, name.to_sym) do
        instance_variable_get("@#{name}")
      end
    end
  end

  def error
    Blog::ValidationError.new(errors.messages)
  end
end