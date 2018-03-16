module Fog
  module Compute
    class Packet
      # Ip Model
      class Ip < Fog::Model
        identity :id

        attribute :address
        attribute :gateway
        attribute :network
        attribute :address_family
        attribute :netmask
        attribute :public
        attribute :cidr
        attribute :created_at
        attribute :updated_at
        attribute :href
        attribute :management
        attribute :manageable
        attribute :project

        def initialize(attributes = {})
          super
        end

        def reserve(quantity, type)
          requires :facility

          options = {}
          options[:quantity] = quantity
          options[:type] = type
          options[:facility] = facility

          data = service.reserve_ip(options)
        end

        def assign
          requires :address, :manageable

          options = {}
          options[:address] = address
          options[:manageable] = manageable

          service.assign_ip(options)
          true
        end

        def unassign(ip_id)
          service.unassign_ip(ip_id)
          true
        end
      end
    end
  end
end
