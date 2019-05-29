# frozen_string_literal: true

module Articles
  class IpWithLoginsRepresenter
    def call(ip_with_logins_array)
      ip_with_logins_array.map do |ip_with_logins|
        {
          ip:     ip_with_logins[0].to_s,
          logins: ip_with_logins[1]
        }
      end
    end
  end
end
