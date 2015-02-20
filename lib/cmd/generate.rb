class OrbCLI < Thor
  desc 'generate', 'Generate an Orb project'
  # required options
  method_option :project,
                aliases: ['-n', '--name', '-p'],
                required: true,
                desc: 'Project name'

  method_option :type,
                aliases: ['-t'],
                required: true,
                default: 'core',
                enum: %w(bertha_test cli core test),
                desc: 'Project type'

  # optional
  method_option :upload_organization,
                aliases: ['-o', '--org', '--upload-organization'],
                desc: "Github organization name, e.g. 'opower', 'eng_main', 'auto'"

  method_option :no_github,
                aliases: ['--no-github'],
                type: :boolean,
                default: false,
                desc: 'Do not push to gihtub. Defaults to false'

  def generate
    # convert strings to symbols in hash to avoid duplicate keys (string & symbol) in params
    opts = symbolize_keys(options)

    if opts[:no_github] && opts[:upload_organization]
      abort("\nERROR MutuallyExclusiveArguments: no-github option AND github organization specified")
    end

    ArchetypeGenerator.new(opts[:project]).generate(opts)
  end

  default_task :generate
end
