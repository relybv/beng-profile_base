require 'facter'

Facter.add(:role) do
  setcode do
    location = case Facter.value(:hostname)
               when /^dev[wea]s200[12]/ then 'labsbeta'
               when /dev(\d|)$/ then 'development'
               when /test(\d|)$/ then 'test'
               when /ip-172-30-1-4(\d|)$/ then 'puppetmaster'
               when /puppetmaster(\d|)$/ then 'puppetmaster'
               when /puppet(\d|)$/ then 'puppetmaster'
               when /^lb[ea]s[123]/ then 'labsbeta'
               when /^lt[ea]s[12]/ then  'labstest'
               when /^l[bt]ws[12]/ then 'webserver'
               when 'ldes1' then 'labsdevelopment'
                else 'base'
               end
  end
end
