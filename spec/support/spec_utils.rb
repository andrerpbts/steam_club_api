module SpecUtils
  def read_fixture(file_name)
    File.read(File.join(SPEC_ROOT, 'fixtures', file_name))
  end
end
