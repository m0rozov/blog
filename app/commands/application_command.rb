require 'dry/monads/result'
require 'dry/monads/maybe'

class ApplicationCommand
  include Dry::Monads::Result::Mixin
end