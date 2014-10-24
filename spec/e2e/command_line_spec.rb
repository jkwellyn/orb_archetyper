require 'English'

describe 'Command Line Interface' do
  it 'returns exit status of 0' do
    cli_path = File.join(File.dirname(__FILE__), '..', '..', 'bin', 'orb_archetyper')
    `#{cli_path} -h`
    expect($CHILD_STATUS).to eq 0
  end
end
