module FixtureHelper
  def load_yaml(request)
    YAML.safe_load load_file(request)
  end

  private

  def load_file(request)
    File.read(filename(request))
  end

  def filename(request)
    File.join(spec_root_path, 'fixtures', "#{request}.yml")
  end

  def spec_root_path
    File.dirname __dir__
  end
end
