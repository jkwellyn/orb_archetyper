require_relative '../spec_helper'
require_relative '../../lib/template_manager'

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

		context "class initizialaztion returns objects as expected" do

				it "supports project args" do
					temp_manager = TemplateManager.new("project", "module")
					
					expect(temp_manager.archetypes.nil?).to eq(false)
					expect(temp_manager.folders.nil?).to eq(false)
					expect(temp_manager.files.nil?).to eq(false)
					expect(temp_manager.substitutes.nil?).to eq(false)
					expect(temp_manager.subtypes.nil?).to eq(false)
				end
		end

		context "class initizialaztion with args assignment" do

				it "supports project args" do
					temp_manager = TemplateManager.new("project", "module")
					
					expect(temp_manager.folders[:base]).to eq("project")

				end

				it "supports module args" do
					temp_manager = TemplateManager.new("project", "module")
					
					expect(temp_manager.substitutes[:gemspec][:module_name][1]).to eq("module")

				end

		end

		context "file paths exists in the lib/templates folders" do

				it "the template manager files structure contains valid paths to each tenplate file" do
					
					temp_manager = TemplateManager.new("project", "module")
					#tests are executed from rake file to no need to .. 
					libdir = File.expand_path('lib', Dir.pwd)
				
					temp_manager.files.each do |key, file_array|
						filepath = File.join(libdir, file_array[1])
						expect(File.exists?(filepath)).to be_true
					end
				end
		end
	end

#!module	
end