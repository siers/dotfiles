#! /usr/bin/env ruby

require 'json'

# def jsonNixToPretty(json)
#   # let's abuse lib.generators.toPretty!
#   nixeval = %w{nix-instantiate --eval --argstr json}
#   source = '{json}: (import <nixpkgs> {}).lib.generators.toPretty {} json'
#   args = nixeval + [json] + %w{-E} + [source]
#
#   IO.popen(args, 'r+') do |p|
#     p.close_write
#     p.gets
#   end
# end
#
# puts(jsonNixToPretty(clientmaps.to_json))

def hash_to_nix(hash)
  "{\n%s}" % (hash.each.map do |(k, v)|
    v = if v.is_a? Hash
      v = %{#{hash_to_nix(v).gsub(/^/, '  ')}}[2..]
    else
      v = %{''\n#{v.gsub(/^/, '    ')}  ''}
    end

    %{  "#{k}" = #{v};\n}
  end.join)
end

clients = %x{grep for.client.in generate-openvpn-keys}.match(/for client in ([^;]+)/)[1].split(' ')

clientmaps = clients.map do |client|
  extmap = Dir.glob("**/#{client}.*").map do |file|
    [File.extname(file)[1..], File.read(file)]
  end.to_h

  [client, extmap]
end.to_h

clientmaps.merge!({
  "ca.crt": File.read('pki/ca.crt'),
})

indent = 2 * 1

puts(hash_to_nix(clientmaps.merge).gsub(/^/, ' ' * indent))

__END__

sample output:

  {
    "t480" = {
      "key" = ''
        -----BEGIN PRIVATE KEY-----
          ...
        -----END PRIVATE KEY-----
      '';
      "crt" = ''
        Certificate:
            Data:
                Version: 3 (0x2)
                Serial Number:
        -----BEGIN CERTIFICATE-----
        ...
        -----END CERTIFICATE-----
      '';
    };
    "rv-p53" = {
      "key" = ''
        -----BEGIN PRIVATE KEY-----
          ...
        -----END PRIVATE KEY-----
      '';
      "crt" = ''
        Certificate:
            Data:
                Version: 3 (0x2)
        ...
      '';
    };
    "ca.crt" = ''
      -----BEGIN CERTIFICATE-----
        ...
      -----END CERTIFICATE-----
    '';
  }
