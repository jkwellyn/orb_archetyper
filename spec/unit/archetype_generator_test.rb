require_relative '../spec_helper'
require_relative '../../lib/archetype_generator'

module OrbArchetyper

	describe ArchetypeGenerator do
		context "Initialization" do 
			it "generator is initilaized as expected" do

				generator = ArchetypeGenerator.new("project_a")
				expect(generator.pname).to eq("project_a")
				expect(generator.mname).to eq("ProjectA")

			end
		end

		context "Sanitize" do 

			invalid_size = "Invalid Project Name Error. Project Name is either: nil or of incorrect length."

			it "Correctly handles incorrect length=1" do			
				expect{ArchetypeGenerator.new("a")}.to raise_error invalid_size
			end

			it "Correctly handles incorrect length=0" do			
				expect{ArchetypeGenerator.new("")}.to raise_error "Invalid Project Name Error. Project Name is either: nil or of incorrect length."
			end
			
			it "Correctly handles incorrect nil" do			
				expect{ArchetypeGenerator.new(nil)}.to raise_error "Invalid Project Name Error. Project Name is either: nil or of incorrect length."
			end

			it "Correctly handles incorrect length > 30" do			
				expect{ArchetypeGenerator.new("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")}.to raise_error "Invalid Project Name Error. Project Name is either: nil or of incorrect length."
			end
			
			it "Correctly handles invalid project names" do			
				expect{ArchetypeGenerator.new("aaaa+")}.to raise_error "Invalid Project Name: should only contain a-z, 0-9, -,_"
			end			

			it "Correctly handles invalid project names" do			
				expect{ArchetypeGenerator.new("aa//aa")}.to raise_error "Invalid Project Name: should only contain a-z, 0-9, -,_"
			end			

			it "Correctly handles invalid project names" do			
				expect{ArchetypeGenerator.new("aa%%^^&&aa")}.to raise_error "Invalid Project Name: should only contain a-z, 0-9, -,_"
			end			

			it "Correctly handles invalid project names" do			
				expect{ArchetypeGenerator.new("aa %%^ ^&&a a")}.to raise_error "Invalid Project Name: should only contain a-z, 0-9, -,_"
			end

		end
	end
end