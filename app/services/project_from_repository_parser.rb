class ProjectFromRepositoryParser

  attr_reader :repository_parser

  def initialize(repository_parser)
    @repository_parser = repository_parser
  end

  def find_or_create
    Project.find_or_create_by(attributes)
  end

  private

  def attributes
    repository_parser.attributes
  end
end
