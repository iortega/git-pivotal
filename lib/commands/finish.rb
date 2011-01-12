require 'commands/base'

module Commands
  class Finish < Base
  
    def run!
      super
      
      unless story_id
        put "Branch name must contain a Pivotal Tracker story id"
        return 1
      end

      put "Marking Story #{story_id} as finished..."
      if story.update(:current_state => 'finished')
        # put "Merging #{current_branch} into #{integration_branch}"
        # sys "git checkout #{integration_branch}"
        # sys "git merge --no-ff #{current_branch}"
        # 
        # put "Removing #{current_branch} branch"
        # sys "git branch -d #{current_branch}"

        sys "git flow feature finish #{current_branch}"

        return 0
      else
        put "Unable to mark Story #{story_id} as finished"
        
        return 1
      end
    end

  protected
  
    def finished_state
      if story.story_type == "chore"
        "accepted"
      else
        "finished"
      end
    end

    def current_branch
      @current_branch ||= get('git branch | grep "^\*"').gsub(/^\*\s+feature\//, '').chomp
    end

    def story_id
      current_branch[/\d+/].to_i
    end

    def story
      @story ||= project.stories.find(story_id)
    end
  end
end
