require_relative '../../lib/template_classes/base'
require_relative '../../lib/template_classes/bin_cli'
require_relative '../../lib/template_classes/readme'

module  OrbArchetyper
  describe Template do
    context 'equality overrides' do
      it "considers 2 templates equal (both == and eql?) if they're the same template type and have the same values for
        project_name, module_name, and template_data " do
        template1 = Template.new('project_name', 'ProjectName')
        template2 = Template.new('project_name', 'ProjectName')

        expect(template1).to eq(template2)
        expect(template1).to eql(template2)
      end

      it "consider 2 templates not equal (both == and eql?) if they're not the same template type" do
        template1 = Template.new('project_name', 'ProjectName')
        template2 = TemplateBinCli.new('project_name', 'ProjectName')

        expect(template1).not_to eq(template2)
        expect(template1).not_to eql(template2)
      end

      it "considers 2 templates not equal (both == and eql?) if they don't have the same values for
        project_name, module_name and template_data" do
        template1 = Template.new('project_name', 'ProjectName', something: 'la la la')
        template2 = Template.new('project_name', 'ProjectName')

        expect(template1).not_to eq(template2)
        expect(template1).not_to eql(template2)
      end
    end

    context 'readme' do
      before(:all) do
        @original_user_env_variable = ENV['USER']
      end

      after(:each) do
        ENV['USER'] = @original_user_env_variable
      end

      it "uses <first_name-last_name> template when project domain and ENV['USER'] are nil" do
        ENV['USER'] = nil
        template = TemplateReadme.new(@project_name, @module_name)
        expect(template.template_data[:project_domain]).to eq('\<first_name-last_name\>')
      end

      it "uses ENV['USER'] if project domain is not assigned" do
        template = TemplateReadme.new(@project_name, @module_name)
        expect(template.template_data[:project_domain]).to eq(ENV['USER'].gsub('.', '-'))
      end
    end
  end
end
