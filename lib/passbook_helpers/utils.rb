require 'fileutils'
require 'json'

module PassbookHelpers
  module Utils
    def configure_pass_folder_path pass_id
      @pass_target_path = ENV['passes_folder_path'] + "/passes/#{pass_id}"
      if (File.exists?(@pass_target_path))
        puts '[File Exists] Deleting existing pass data.'
        FileUtils.remove_dir(@pass_target_path)
      end
      puts '[ ok ] Creating pass data from template'
      FileUtils.cp_r ENV['pass_template_path'] + "/.", @pass_target_path
      puts '[ Done ]'
    end

    def modify_pass_json(pass={}, screening={}, user={})
      puts '[ ok ] Updating pass data'
      json_file_path = @pass_target_path + '/pass.json'
      pass_json = JSON.parse(File.read(json_file_path))
      # Generic pass info
      pass_json['teamIdentifier'] = ENV['team_identifier'] 
      pass_json['webServiceURL'] = ENV['web_service_ur'] || 'http://localhost:8080/'
      pass_json['barcode']['message'] = barcode_string_for_pass(pass)
      pass_json['passTypeIdentifier'] = pass['pass_type_id']
      pass_json['authenticationToken'] = pass[:authentication_token] || '123345667'     
      
      # Pass Color
      pass_json['foregroundColor'] = 'rgb(255, 255, 255)'
      pass_json['backgroundColor'] = 'rgb(60, 65, 76)'

      # Screening info
      pass_json['organizationName'] = screening['org_name'] || 'ReeelApp'
      pass_json['serialNumber'] = pass[:serial_number] || '1234556' 
      pass_json['relevantDate'] = screening['time_date'].to_formatted_s(:w3c) || DateTime.now.to_formatted_s(:w3c)
      pass_json['locations'][0]['longitude'] = screening['location']['lng'] || -122.3748889
      pass_json['locations'][0]['latitude'] = screening['location']['lat'] || 37.6189722
      pass_json['eventTicket']['auxiliaryFields'][0]['value'] = screening['location_name'] || 'AMC Empire 25'
      pass_json['eventTicket']['auxiliaryFields'][1]['value'] = screening['time_date'].to_formatted_s(:w3c) || DateTime.now.to_formatted_s(:w3c)     
      pass_json['eventTicket']['backFields'][0]['value'] = screening['terms_n_conditions'] || 'Some Terms & Conditions'
      # Pass info
      # user dependent
      pass_json['eventTicket']['primaryFields'][0]['value'] = screening['title'] || 'GOT S6 Pre-Screening'
      pass_json['eventTicket']['secondaryFields'][0]['value'] = user['name'] || 'Jon Snow'
      pass_json['eventTicket']['secondaryFields'][1]['value'] = pass['number_of_seats'] || 1

      File.open(json_file_path, 'w') do |f|
        f.write JSON.pretty_generate(pass_json)
      end
    end
    
    def barcode_string_for_pass(pass)
      barcode_string = {
        'pass_type_id' => pass['pass_type_id'],
        'serial_number' => pass[:serial_number],
        'authentication_token' => pass[:authentication_token]
      }
      barcode_string.to_json
    end

    def delete_pass_dir(path)
      FileUtils.remove_entry(path)
    end
  end
end
