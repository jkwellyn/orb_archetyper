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
  end
end
