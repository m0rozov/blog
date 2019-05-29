# frozen_string_literal: true

module Articles
  module Rates
    class ShowAvgRepresenter
      def call(rate)
        { avg_rate: rate }
      end
    end
  end
end