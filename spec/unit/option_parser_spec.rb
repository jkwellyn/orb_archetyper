require_relative '../../lib/option_parser'
require_relative '../../lib/template_classes/template_license'
require_relative '../../lib/template_classes/template_spec_helper'

module OrbArchetyper

  describe OptionParser do

    context "test missing arguements" do

      it "throws MissingArgument when no args given" do
        args = []
        expect { OptionParser.parse(args) }.to raise_error OptionParser::MissingArgument
      end

      it "throws MissingArgument when project name is omitted" do
        args = ['-t cli']
        expect { OptionParser.parse(args) }.to raise_error OptionParser::MissingArgument
      end

      it "throws InvalidArgument when type is missing" do
        args = ['-p project_x']
        expect { OptionParser.parse(args) }.to raise_error OptionParser::InvalidArgument
      end

    end

    context "options are valid" do

      it "initializes as expected" do
        args = ['-t', 'cli']
        args << '-p' << 'name'

        options = OptionParser.parse(args)

        expect(options.key?(:project)).to be_true
        expect(options[:project]).to eq("name")

        expect(options.key?(:type)).to be_true
        expect(options[:type]).to eq('cli')

        expect(options.key?(:github)).to be_true
        expect(options[:github]).to be_false

      end

      it "supports optional github arguments as expected" do
        args = ['-t', 'cli']
        args << '-p' << 'name'
        args << '-g'

        options = OptionParser.parse(args)

        expect(options.key?(:github)).to be_true
        expect(options[:github]).to be_true

      end

      it "supports optional include arr arguments as expected" do
        args = ['-t', 'cli']
        args << '-p' << 'name'
        args << '-i' << 'license,spec_helper'

        options = OptionParser.parse(args)

        expect(options.key?(:include)).to be_true

        expect(options[:include].length).to eq(2)
        expect(options[:include]).to eq(['license', 'spec_helper'])

      end

      it "supports optional exclude arr arguments as expected" do
        args = ['-t', 'cli']
        args << '-p' << 'name'
        args << '-x' << 'license'

        options = OptionParser.parse(args)

        expect(options.key?(:exclude)).to be_true

        expect(options[:exclude].length).to eq(1)
        expect(options[:exclude]).to eq(['license'])

      end

      it "supports all arguments as expected" do
        args = ['-t', 'cli']
        args << '-p' << 'name'
        args << '-i' << 'license,spec_helper'
        args << '-x' << 'license'
        args << '-g'

        options = OptionParser.parse(args)

        expect(options.key?(:project)).to be_true
        expect(options.key?(:type)).to be_true
        expect(options.key?(:include)).to be_true
        expect(options.key?(:exclude)).to be_true
        expect(options.key?(:project)).to be_true

      end

      it 'should convert template names into template classes' do
        args = ['-t', 'cli']
        args << '-p' << 'name'
        args << '-i' << 'license,spec_helper'
        args << '-x' << 'license'

        options = OptionParser.parse(args)
        expect(options[:include]).to eq ['license', 'spec_helper']
        expect(options[:exclude]).to eq ['license']
      end
    end

    context "helper arguments" do

      #TODO fix this
      #it "throws SystemExit after displaying options" do
      #	args = ['-e']
      #	expect{OptionParser.parse(args)}.to raise_error SystemExit
      #end

      it "throws SystemExit after displaying options" do
        args = ['-h']
        expect { OptionParser.parse(args) }.to raise_error SystemExit
      end

      it "throws SystemExit after displaying options" do
        args = ['--help']
        expect { OptionParser.parse(args) }.to raise_error SystemExit
      end

      it "throws SystemExit after displaying options" do
        args = ['-v']
        expect { OptionParser.parse(args) }.to raise_error SystemExit
      end

      it "throws SystemExit after displaying options" do
        args = ['--version']
        expect { OptionParser.parse(args) }.to raise_error SystemExit
      end

    end

  end
end