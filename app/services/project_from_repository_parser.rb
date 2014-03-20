class ProjectFromRepositoryParser

  attr_reader :repository_parser

  def initialize(repository_parser)
    @repository_parser = repository_parser
  end

  def find_or_create
    p_owner = get_project_owner
    p = Project.find_or_create_by(attributes)
    p.update_attribute(:project_owner, p_owner)
  end

  def get_project_owner
    ProjectOwner.find_or_create_by(owner_attributes)
  end

  private

  def owner_attributes
    repository_parser.owner.attributes
  end

  def attributes
    repository_parser.attributes
  end
end
