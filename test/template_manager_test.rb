require_relative '../lib/template_manager'

module OrbArchetyper

	describe TemplateManager do

		context "class variables supported types" do

				it "supports 4 project pattern types" do
					TemplateManager.types.length.should == 4
				end

				it "has the correct project types" do
					TemplateManager.types.sort == [:cli, :core, :utility, :test].sort
				end

				it "has the correct archetypes" do
					
					a = []
						TemplateManager.new("x", "y").archetypes.each do |key, value|
					  a + value
					end
					a.uniq.sort == [:binf, :config, :coverage, :gemfile, :gemlock, :gemspec, :gitignore, :libf, :logs, :rake, :rdoc, :readme, :resources, :results, :rvmrc, :spec, :test, :version]
				end
		end

		context "class initizialaztion with args" do

				it "supports project and module vars" do
					temp_manager = TemplateManager.new("project", "module")
					
					expect(temp_manager.folders[:base]).to eq("project")

				end

		end
	end

#!module	
end