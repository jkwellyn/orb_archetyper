require 'English'
load "#{File.dirname(__FILE__)}/../../bin/orb"

describe 'Command Line Interface' do
  it 'returns exit status of 0' do
    cli_path = File.join(File.dirname(__FILE__), '..', '..', 'bin', 'orb')
    `#{cli_path} help`
    expect($CHILD_STATUS).to eq 0
  end

  it 'invokes the help command' do
    output = capture(:stdout) { OrbCLI.start(%w(help)) }
    expect(output).to include('Commands:')
  end

  it 'invokes the version command' do
    output = capture(:stdout) { OrbCLI.start(%w(version)) }
    expect(output).to include('orb-archetyper version')
  end

  it 'invokes the fork comamnd' do
    output = capture(:stderr) { OrbCLI.start(%w(fork)) }
    expect(output).to match(/ERROR: .* fork\" was called with no arguments/)
  end

  context '#generate command' do
    it 'is invoked' do
      cmds = [%w(generate), %w(generate -t cli)]
      cmds.each do |cmd|
        output = capture(:stderr) { OrbCLI.start(cmd) }
        expect(output).to match(/No value provided for required options/)
      end
    end

    it 'fails on invalid project type' do
      output = capture(:stderr) { OrbCLI.start(%w(generate -t foo)) }
      expect(output).to match(/Expected \'--type\' to be one of/)
    end

    it 'fails on mutually exclusive arguments' do
      msg = /ERROR MutuallyExclusiveArguments: no-github option AND github organization specified/
      expect { OrbCLI.start(%w(generate -t cli -p myproj -o auto --no-github)) }.to raise_error.with_message(msg)
    end
  end
end
