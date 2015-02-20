require_relative '../../lib/template_classes/bin_cli'

describe TemplateBinCli do
  context 'CLI project generation' do

    before(:each) do
      @bin_cli_template = TemplateBinCli.new('test-project', 'test-module-name')
    end

    it 'generates CLI specific files' do
      [/<%/, /%>/].each do |template_markup|
        expect(@bin_cli_template.render).not_to match(template_markup)
      end
    end
  end
end
