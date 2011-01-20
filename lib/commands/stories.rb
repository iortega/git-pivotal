require 'commands/base'

module Commands
  class Stories < Base

    def run!
      stories = project.stories.all(:current_state => 'unstarted')
      stories.each do |story|
        puts "#{story.id} - #{story.story_type} - #{story.name}"
      end
      0
    end

  end
end
