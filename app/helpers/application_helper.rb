require 'passbook'
require 'fileutils'

module ApplicationHelper
  
  def configure_pass_folder_path pass_id
    ENV['pass_target_path'] = ENV['passes_folder_path'] + "/passes/#{pass_id}"
    if (File.exists?(ENV['pass_target_path']))
      puts '[File Exists] Deleting existing pass data.'
      FileUtils.remove_dir(ENV[pass_target_path])
    end
    puts '[ ok ] Creating pass data from template'
    FileUtils.cp_r ENV['pass_template_path'] + "/.", ENV['pass_target_path']
    puts '[ Done ]'
  end

  def modify_pass_json(pass={}, screening={})
    puts '[ ok ] Updating pass data'
    json_file_path = ENV['pass_target_path'] + '/pass.json'
    pass_json = JSON.parse(File.read(json_file_path))
    pass_json['passTypeIdentifier'] = pass['pass_type_id']
    pass_json['teamIdentifier'] = ENV['team_identifier']
    pass_json['serialNumber'] = pass[:serial_number] || '1234556' 
    pass_json['authenticationToken'] = pass[:authentication_token] || '123345667'
    pass_json['webServiceURL'] = ENV['web_service_ur'] || 'http://localhost:8080/'
    pass_json['barcode']['message'] = pass_barcode_string(pass)
    pass_json['eventTicket']['primaryFields'][0]['value'] = screening['title'] || 'GOT S6 Pre-Screening'
    pass_json['eventTicket']['secondaryFields'][0]['value'] = pass['title'] || 'Paul'

    File.open(json_file_path, 'w') do |f|
      f.write JSON.pretty_generate(pass_json)
    end
  end
  
  def instantiate_pass
    json_file_path = ENV['pass_target_path'] + '/pass.json'
    pass_json = JSON.parse(File.read(json_file_path))
    Passbook::PKPass.new pass_json 
  end

  def add_pass_files 
    pass = instantiate_pass 
    pass_dir = ENV['pass_target_path']
    Dir.foreach(pass_dir) do |file|
      next if file == '.' or file == '..' or file == '.DS_Store'
      pass.addFile file 
    end
    pass 
  end

  def generate_pass
    pass = add_pass_files
    pkpass = pass.file
    send_file pkpass.path, type: 'application/vnd.apple.pkpass', disposition: 'attachment', filename: 'pass.pkpass'
  end

  def generate_pass_stream
    pass = add_pass_files
    pkpass = pass.file
    send_data pkpass.string, type: 'application/vnd.apple.pkpass', disposition: 'attachment', filename: 'pass.pkpass'
  end


  def barcode_string_for_pass(pass)
    barcode_string = {
      'pass_type_id' => pass['pass_type_id'],
      'serial_number' => pass[:serial_number],
      'authentication_token' => pass[:authentication_token]
    }
    barcode_string.to_json
  end

end
