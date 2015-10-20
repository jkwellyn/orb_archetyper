require_relative '../../lib/orb_archetyper/constants'

module E2EHelper
  def expect_path_to_exist(should_exist, *path)
    file = File.join(*path)
    if should_exist
      expect(File).to exist(file)
    else
      expect(File).not_to exist(file)
    end
  end

  shared_context 'in sandbox directory' do
    Dir.chdir(Constants::SANDBOX)
  end
end
