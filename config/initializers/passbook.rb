require 'passbook'

# Setting ENV variables
# Files
ENV['cert_dir'] = File.dirname(File.expand_path(__FILE__ + '../../../')) + "/lib/certificates"
ENV['passes_folder_path'] = File.dirname(File.expand_path(__FILE__ + '../../../')) + "/app/passes"
ENV['pass_template_path'] = ENV['passes_folder_path'] + "/template"
# IDs
ENV['pass_team_identifier'] = 'pass.com.pearl-lab.reeel'
ENV['team_identifier'] = 'L3UWNA9BQQ'
ENV['web_service_url'] = 'http://hostname:post/'


def get_cert_path cert_type
  certs = Dir.glob("#{ENV['cert_dir']}/*.#{cert_type}")
  if certs.count == 0
    puts "Couldn't find a certificate at #{ENV['cert_dir']}"
    puts "Exiting"
    Process.exit 
  else
    certificate_path = certs[0]
  end
end



Passbook.configure do |passbook|


  # Path to your wwdc cert file
  passbook.wwdc_cert = get_cert_path 'pem'

  # Path to your cert.p12 file
  passbook.p12_certificate = get_cert_path 'p12'
  
  # Password for your certificate
  passbook.p12_password = 'purpose'
end
