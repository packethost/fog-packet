module Fog
  module Compute
    class Packet
      class Project < Fog::Model
        identity :id
        attribute :name
        attribute :created_at
        attribute :updated_at
        attribute :network_status
        attribute :max_devices
        attribute :organization
        attribute :memebers
        attribute :memeberships
        attribute :devices
        attribute :ssh_keys
        attribute :transfers
        attribute :volumes
        attribute :href

        attr_accessor :options

        def initialize(attributes = {})
          super
        end

        def save(payment_method_id)
          requires :name

          options = {}
          options[:name] = name
          options[:payment_method_id] = payment_method_id if payment_method_id

          data = service.create_project(options)
          true
        end
      end
    end
  end
end
