require 'facter'

Facter.add(:role) do
  setcode do
    location = case Facter.value(:hostname)
               when /dev(\d|)$/ then 'development'
               when /test(\d|)$/ then 'test'
               else 'production'
               end
  end
end
