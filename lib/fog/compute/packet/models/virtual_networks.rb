require_relative "virtual_network"

module Fog
  module Compute
    class Packet
      # Plans
      class VirtualNetworks < Fog::Collection
        model Fog::Compute::Packet::VirtualNetwork

        def all(project_id, params = {})
          response = service.list_virtual_networks(project_id, params)
          load(response.body["virtual_networks"])
        end
      end
    end
  end
end
