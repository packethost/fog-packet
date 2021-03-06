module Fog
  module Compute
    class Packet
      # SshKey
      class SshKey < Fog::Model
        identity :id

        attribute :label
        attribute :key
        attribute :fingerprint
        attribute :created_at
        attribute :updated_at
        attribute :owner
        attribute :href

        attr_accessor :options

        def initialize(attributes = {})
          super
        end

        def save
          requires :label, :key

          options = {}
          options[:label] = label
          options[:key] = key
          response = service.create_ssh_key(options)
          merge_attributes(response.body)
        end

        def update
          requires :id

          options = {}
          options[:label] = label
          options[:key] = key
          response = service.update_ssh_key(id, options)
          merge_attributes(response.body)
        end

        def destroy
          requires :id

          response = service.delete_ssh_key(id)
          true if response.status == 204
        end
      end
    end
  end
end
