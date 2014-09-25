require_relative '../../lib/option_parser'
require_relative '../../lib/template_classes/template_license'
require_relative '../../lib/template_classes/template_spec_helper'

module OrbArchetyper
  describe OptionParser do

    context 'test missing arguements' do

      it 'throws MissingArgument when no args given' do
        args = []
        expect { OptionParser.parse(args) }.to raise_error OptionParser::MissingArgument
      end

      it 'throws MissingArgument when project name is omitted' do
        args = ['-t cli']
        expect { OptionParser.parse(args) }.to raise_error OptionParser::MissingArgument
      end

      it 'throws InvalidArgument when type is missing' do
        args = ['-p project_x']
        expect { OptionParser.parse(args) }.to raise_error OptionParser::InvalidArgument
      end

    end

    context 'options are valid' do

      it 'initializes as expected' do
        args = ['-t', 'cli']
        args << '-p' << 'name'

        options = OptionParser.parse(args)

        expect(options.key?(:project)).to be true
        expect(options[:project]).to eq('name')

        expect(options.key?(:type)).to be true
        expect(options[:type]).to eq('cli')

        expect(options.key?(:no_github)).to be false
        expect(options[:no_github]).to be_nil

      end

      it 'supports uploading to the current user repository' do
        args = ['-t', 'cli']
        args << '-p' << 'name'
        args << '-u'

        options = OptionParser.parse(args)

        expect(options.key?(:upload_organization)).to be false
        expect(options.key?(:upload_user)).to be true
        expect(options[:upload_user]).to be true
      end

      it 'supports uploading to an organization' do
        args = ['-u', 'auto']
        args << '-p' << 'name'
        args << '-t' << 'cli'
        options = OptionParser.parse(args)

        expect(options.key?(:upload_organization)).to be true
        expect(options[:upload_organization]).to eql 'auto'
      end

      it 'supports all arguments as expected' do
        args = ['-t', 'cli']
        args << '-p' << 'name'
        args << '-f' << 'opower/foo_project'
        args << '-u' << 'opower'

        options = OptionParser.parse(args)

        expect(options.key?(:project)).to be true
        expect(options.key?(:type)).to be true
        expect(options.key?(:fork)).to be true
        expect(options.key?(:upload_organization)).to be true
        expect(options.key?(:project)).to be true
      end
    end

    context 'helper arguments' do

      it 'throws SystemExit after displaying options' do
        args = ['-h']
        expect { OptionParser.parse(args) }.to raise_error SystemExit
      end

      it 'throws SystemExit after displaying options' do
        args = ['--help']
        expect { OptionParser.parse(args) }.to raise_error SystemExit
      end

      it 'throws SystemExit after displaying options' do
        args = ['-v']
        expect { OptionParser.parse(args) }.to raise_error SystemExit
      end

      it 'throws SystemExit after displaying options' do
        args = ['--version']
        expect { OptionParser.parse(args) }.to raise_error SystemExit
      end

      it 'throws InvalidArgument if --no-gihub and -u defined' do
        args = ['-t', 'cli']
        args << '-p' << 'foo'
        args << '--no-github'
        args << '-u'

        expect { OptionParser.parse(args) }.to raise_error OptionParser::InvalidArgument
      end
    end
  end
end
