require 'facter'

Facter.add(:role) do
  setcode do
    location = case Facter.value(:hostname)
               when /dev(\d|)$/ then 'development'
               when /test(\d|)$/ then 'test'
               when /ip-172-30-1-4(\d|)$/ then 'puppetmaster'
               else 'base'
               end
  end
end
