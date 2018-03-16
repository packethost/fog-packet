module Fog
  module Compute
    class Packet < Fog::Service
      API_VERSION = 'v1'.freeze

      SUCCESS_CODES = [200, 201, 202, 204].freeze

      requires :packet_token

      recognizes :packet_url

      # Models
      model_path 'packet/models'

      # model :project
      # collection :projects

      model :plan
      collection :plans

      model :project
      collection :projects

      model :facility
      collection :facilities

      model :device
      collection :devices

      # Requests
      request_path 'packet/requests'

      request :list_plans
      request :list_projects
      request :get_project
      request :create_project
      request :delete_project
      request :list_facilities
      request :list_operating_systems

      request :create_device
      request :list_devices
      request :get_device
      request :delete_device
      request :update_device
      request :reboot_device
      request :poweron_device
      request :poweroff_device

      request :get_volume
      request :create_volume
      request :list_volumes
      request :delete_volume
      request :attach_volume
      request :detach_volume
      request :update_volume

      request :reserve_ip
      request :list_ips
      request :assign_ip
      request :unassign_ip
      request :create_snapshot
      request :delete_snapshot
      request :list_snapshots

      request :create_virtual_network
      request :list_virtual_networks
      request :delete_virtual_network
      request :assign_port
      request :unassign_port
      request :disbond_ports
      request :bond_ports

      class Real
        def initialize(options = {})
          @packet_token = options[:packet_token]
          @base_url = 'https://api.packet.net/'
          @version = ''
          @header = {
            'X-Auth-Token' => @packet_token,
            'Content-Type' => 'application/json'
          }
          @connection = Fog::Core::Connection.new(@base_url)
        end

        def request(params)
          # Perform Request

          begin
            response = @connection.request(method: params[:method],
                                           path: params[:path],
                                           headers: @header,
                                           body: params[:body],
                                           query: params[:params])
          rescue Excon::Errors::Unauthorized => error
            raise error
          rescue Excon::Errors::HTTPStatusError => error
            raise error
          rescue Excon::Errors::InternalServerError => error
            raise error
          rescue Fog::Errors::NotFound => error
            raise error
          end

          # Parse body
          response.body = Fog::JSON.decode(response.body) if response.body != ''

          #
          # Check for server error
          if response.status == 500
            raise "Internal Server Error. Please try again."
          end
          # Raise exception if a bad status code is returned
          # unless SUCCESS_CODES.include? response.status
          #   raise response.status
          # end

          response
        end
      end # real

      class Mock
        def initialize(options = {})
          @packet_token = options[:packet_token]
        end

        def self.data
          @plans = Hash.new({ "plans" => [{ "id" => "e69c0169-4726-46ea-98f1-939c9e8a3607", "slug" => "baremetal_0", "name" => "Type 0", "description" => "Our Type 0 configuration is a general use \"cloud killer\" server, with a Intel Atom 2.4Ghz processor and 8GB of RAM.", "line" => "baremetal", "specs" => { "cpus" => [{ "count" => 1, "type" => "Intel Atom C2550 @ 2.4Ghz" }], "memory" => { "total" => "8GB" }, "drives" => [{ "count" => 1, "size" => "80GB", "type" => "SSD" }], "nics" => [{ "count" => 2, "type" => "1Gbps" }], "features" => { "raid" => false, "txt" => true } }, "available_in" => [{ "href" => "/facilities/8ea03255-89f9-4e62-9d3f-8817db82ceed" }, { "href" => "/facilities/2b70eb8f-fa18-47c0-aba7-222a842362fd" }, { "href" => "/facilities/8e6470b3-b75e-47d1-bb93-45b225750975" }, { "href" => "/facilities/e1e9c52e-a0bc-4117-b996-0fc94843ea09" }], "pricing" => { "hour" => 0.07 } }, { "id" => "6d1f1ffa-7912-4b78-b50d-88cc7c8ab40f", "slug" => "baremetal_1", "name" => "Type 1", "description" => "Our Type 1 configuration is a zippy general use server, with an Intel E3-1240 v3 processor and 32GB of RAM.", "line" => "baremetal", "specs" => { "cpus" => [{ "count" => 1, "type" => "Intel E3-1240 v3" }], "memory" => { "total" => "32GB" }, "drives" => [{ "count" => 2, "size" => "120GB", "type" => "SSD" }], "nics" => [{ "count" => 2, "type" => "1Gbps" }], "features" => { "raid" => true, "txt" => true } }, "available_in" => [{ "href" => "/facilities/8ea03255-89f9-4e62-9d3f-8817db82ceed" }, { "href" => "/facilities/2b70eb8f-fa18-47c0-aba7-222a842362fd" }, { "href" => "/facilities/8e6470b3-b75e-47d1-bb93-45b225750975" }, { "href" => "/facilities/e1e9c52e-a0bc-4117-b996-0fc94843ea09" }], "pricing" => { "hour" => 0.4 } }, { "id" => "e829e15f-bfa0-4d8f-806e-cc92bb6567b4", "slug" => "baremetal_1e", "name" => "Type 1E", "description" => "Our Type 1e ...", "line" => "baremetal", "specs" => { "cpus" => [{ "count" => 1, "type" => "Intel Xeon E3-1578L v5" }], "memory" => { "total" => "32GB" }, "drives" => [{ "count" => 1, "size" => "240GB", "type" => "SSD" }], "nics" => [{ "count" => 2, "type" => "10Gbps" }], "features" => {} }, "available_in" => [{ "href" => "/facilities/d0c0d80d-4637-4fa0-b79e-803fc42b19bd" }, { "href" => "/facilities/fd8c403f-c81d-4de7-ba5e-91362fc2d71c" }, { "href" => "/facilities/14a4cad8-6f81-41b6-8cba-aaf8322910af" }, { "href" => "/facilities/75b74ee6-d7af-4a65-82ca-73c895cd50a9" }, { "href" => "/facilities/855e3cd5-d27c-4330-9b9f-1ffd7e9bfff5" }, { "href" => "/facilities/ad136386-a3b5-4127-b5a4-1c6ff0cc5ddb" }, { "href" => "/facilities/8dd1568c-45be-40c0-998c-b47e7cbe3912" }, { "href" => "/facilities/92d199e7-3203-4df1-afb5-f16a890150ac" }, { "href" => "/facilities/8f3eb9dc-cd96-486d-9326-3c11b22a18ac" }, { "href" => "/facilities/fe4d0bcc-ffb4-488b-9a62-9a983ed0d66d" }, { "href" => "/facilities/ca3bb830-4aa2-4226-9daa-8d67be3c0c61" }, { "href" => "/facilities/c4501630-3713-4751-8ea8-65d9ed8ae18f" }], "pricing" => { "hour" => 0.4 } }, { "id" => "a3729923-fdc4-4e85-a972-aafbad3695db", "slug" => "baremetal_2", "name" => "Type 2", "description" => "Our Type 2 configuration is the perfect all purpose virtualization server, with dual E5-2650 v4 processors, 256 GB of DDR4 RAM, and six SSDs totaling 2.8 TB of storage.", "line" => "baremetal", "specs" => { "cpus" => [{ "count" => 2, "type" => "Intel Xeon E5-2650 v4 @2.2GHz" }], "memory" => { "total" => "256GB" }, "drives" => [{ "count" => 6, "size" => "480GB", "type" => "SSD" }], "nics" => [{ "count" => 2, "type" => "10Gbps" }], "features" => { "raid" => true, "txt" => true } }, "available_in" => [{ "href" => "/facilities/2b70eb8f-fa18-47c0-aba7-222a842362fd" }, { "href" => "/facilities/e1e9c52e-a0bc-4117-b996-0fc94843ea09" }], "pricing" => { "hour" => 1.7 } }, { "id" => "3bc8a214-b807-4058-ad4a-6925f2411155", "slug" => "baremetal_2a", "name" => "Type 2A", "description" => "Our Type 2A configuration is a 96-core dual socket ARM 64 beast based on Cavium ThunderX chips", "line" => "baremetal", "specs" => { "cpus" => [{ "count" => 2, "type" => "Cavium ThunderX CN8890 @2GHz" }], "memory" => { "total" => "128GB" }, "drives" => [{ "count" => 1, "size" => "340GB", "type" => "SSD" }], "nics" => [{ "count" => 2, "type" => "10Gbps" }], "features" => {} }, "available_in" => [{ "href" => "/facilities/8ea03255-89f9-4e62-9d3f-8817db82ceed" }, { "href" => "/facilities/e1e9c52e-a0bc-4117-b996-0fc94843ea09" }], "pricing" => { "hour" => 0.5 } }, { "id" => "741f3afb-bb2f-4694-93a0-fcbad7cd5e78", "slug" => "baremetal_3", "name" => "Type 3", "description" => "Our Type 3 configuration is a high core, high IO server, with dual Intel E5-2640 v3 processors, 128GB of DDR4 RAM and ultra fast NVME flash drives.", "line" => "baremetal", "specs" => { "cpus" => [{ "count" => 2, "type" => "Intel E5-2640 v3" }], "memory" => { "total" => "128GB" }, "drives" => [{ "count" => 2, "size" => "120GB", "type" => "SSD" }, { "count" => 1, "size" => "1.6TB", "type" => "NVME" }], "nics" => [{ "count" => 2, "type" => "10Gbps" }], "features" => { "raid" => true, "txt" => true } }, "available_in" => [{ "href" => "/facilities/2b70eb8f-fa18-47c0-aba7-222a842362fd" }, { "href" => "/facilities/8e6470b3-b75e-47d1-bb93-45b225750975" }, { "href" => "/facilities/e1e9c52e-a0bc-4117-b996-0fc94843ea09" }], "pricing" => { "hour" => 1.75 } }, { "id" => "66173669-84fc-43b3-92b5-64f84497c887", "slug" => "baremetal_s", "name" => "Type S", "description" => "Our Type S server packs in 24TB of storage and is perfect for large object or file needs.", "line" => "baremetal", "specs" => { "cpus" => [{ "count" => 1, "type" => "Intel Xeon D-1537 @1.7GHz" }], "memory" => { "total" => "64GB" }, "drives" => [{ "count" => 2, "size" => "480GB", "type" => "SSD" }, { "count" => 12, "size" => "2TB", "type" => "HDD" }, { "count" => 1, "size" => "128GB", "type" => "SATA DOM" }], "nics" => [{ "count" => 2, "type" => "10Gbps" }], "features" => {} }, "available_in" => [{ "href" => "/facilities/8e6470b3-b75e-47d1-bb93-45b225750975" }, { "href" => "/facilities/e1e9c52e-a0bc-4117-b996-0fc94843ea09" }], "pricing" => { "hour" => 1.5 } }, { "id" => "5aeee4f9-1137-4514-8f3e-a1e103b02966", "slug" => "c2.medium.x86", "name" => "c2.medium.x86", "description" => "Our c2.medium.x86 configuration is an AMD 7401P EPYC server.", "line" => "baremetal", "specs" => { "cpus" => [{ "count" => 1, "type" => "AMD EPYC 7401P 24-Core Processor @ 2.0GHz" }], "memory" => { "total" => "64GB" }, "drives" => [{ "count" => 2, "size" => "120GB", "type" => "SSD" }, { "count" => 2, "size" => "480GB", "type" => "SSD" }], "nics" => [{ "count" => 2, "type" => "10Gbps" }], "features" => {} }, "available_in" => [{ "href" => "/facilities/2b70eb8f-fa18-47c0-aba7-222a842362fd" }, { "href" => "/facilities/e1e9c52e-a0bc-4117-b996-0fc94843ea09" }], "pricing" => { "hour" => 1.0 } }, { "id" => "c5a9c64a-07e4-46a9-8dfe-2437f521dcb8", "slug" => "m2.xlarge.x86", "name" => "m2.xlarge.x86", "description" => "Our m2.xlarge.x86 configuration is a...", "line" => "baremetal", "specs" => { "cpus" => [{ "count" => 2, "type" => "Intel Scalable Gold 5120 28-Core Processor @ 2.2GHz" }], "memory" => { "total" => "384GB" }, "drives" => [{ "count" => 2, "size" => "120GB", "type" => "SSD" }, { "count" => 1, "size" => "3.8TB", "type" => "NVME" }], "nics" => [{ "count" => 2, "type" => "10Gbps" }], "features" => {} }, "available_in" => [{ "href" => "/facilities/2b70eb8f-fa18-47c0-aba7-222a842362fd" }, { "href" => "/facilities/e1e9c52e-a0bc-4117-b996-0fc94843ea09" }], "pricing" => { "hour" => 2.0 } }, { "id" => "87728148-3155-4992-a730-8d1e6aca8a32", "slug" => "storage_1", "name" => "Standard", "description" => "TBD", "line" => "storage", "specs" => {}, "available_in" => [], "pricing" => { "hour" => 0.000104 } }, { "id" => "d6570cfb-38fa-4467-92b3-e45d059bb249", "slug" => "storage_2", "name" => "Performance", "description" => "TBD", "line" => "storage", "specs" => {}, "available_in" => [], "pricing" => { "hour" => 0.000223 } }] })

          return @plans
        end

        def data
          self.class.data[@packet_token]
        end
      end
    end # packet
  end # compute
end # fog
