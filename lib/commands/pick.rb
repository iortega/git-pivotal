require 'commands/base'

module Commands
  class Pick < Base

    def type
      raise Error("must define in subclass")
    end

    def plural_type
      raise Error("must define in subclass")
    end

    def branch_suffix
      raise Error("must define in subclass")
    end

    def run!
      response = super
      return response if response > 0

      msg = "Retrieving latest #{plural_type} from Pivotal Tracker" unless options[:story_id]
      if options[:only_mine]
        msg += " for #{options[:full_name]}"
      end
      put "#{msg}..."

      unless story
        put "No #{plural_type} available!"
        return 0
      end

      put "Story: #{story.name}"
      put "URL:   #{story.url}"

      put "Updating #{type} status in Pivotal Tracker..."
      
      if story.update(:current_state => 'started', :owned_by => options[:full_name])
    
        suffix = branch_suffix
        unless options[:quiet]
          put "Enter branch name (will be prepended by #{story.id}) [#{suffix}]: ", false
          suffix = input.gets.chomp
        end
        suffix = branch_suffix if suffix == ""

        branch = "#{story.id}-#{suffix}"
        if get("git branch").match(branch).nil?
          put "Creating #{branch} branch..."
          sys "git flow feature start #{branch}"
        end

        return 0
      else
        put "Unable to mark #{type} as started"

        return 1
      end
    end

  protected

    def story
      return @story if @story
      if !!options[:story_id]
        puts "Looking for story #{options[:story_id]}"
        @story = project.stories.find(options[:story_id])
        puts "Story has not state 'unstarted'. Current state '#{@story.current_state}'." if @story.current_state != "unstarted"
      else
        conditions = { :story_type => type, :current_state => "unstarted", :limit => 1, :offset => 0 }
        conditions[:owned_by] = options[:full_name] if options[:only_mine]
        @story = project.stories.all(conditions).first
      end
    end
  end
end
