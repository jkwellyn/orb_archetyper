module E2EHelper

  SANDBOX = File.join('spec', 'sandbox')

  def expect_path_to_exist(should_exist, *path)
    if should_exist
      expect(File).to exist(File.join(*path))
    else
      expect(File).not_to exist(File.join(*path))
    end
  end

  shared_context 'in sandbox directory' do
    Dir.chdir(SANDBOX)
  end
end