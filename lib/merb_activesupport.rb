if defined?(Merb::Plugins) 
  class Merb::ActiveSupport
    DIR = File.expand_path(File.dirname(__FILE__)).freeze
    AS_CORE_EXT_DIR = (DIR / :vendor / :active_support / :core_ext).freeze
    PARTIAL_EXT_DIR = (DIR / :merb_activesupport ).freeze
  
    $:.push ::Merb::ActiveSupport::DIR / :vendor # some files automatically require others.

    class << self
    
      def official?(key)
        OFFICIAL_EXTS.has_key? key
      end

      # TODO: add more options
      OFFICIAL_EXTS =
        {
          :try    => :try,
          :symbol => :symbol,
          :delegate => (:module / :delegation),
          :date   => :date,

          # Time : This requires blankslate if BasicObject class isn't defined,
          # strictly speaking, the module which requires blankslate is 
          # ActiveSupport::CoreExtensions::Time::Calculations.
          :time   => :time,

          :enumerable => :enumerable,
          :AS_blank? => :blank
        }.freeze

      # TODO: add more options
      PARTIAL_EXTS =
        {
          :present? => :present,
          :array_access => :array_access,
          :time_convertion => :time_convertion
        }.freeze


      def available_exts
        hash = {}
        hash.merge! OFFICIAL_EXTS
        hash.merge! PARTIAL_EXTS
      end

      def config
        Merb::Plugins.config[:merb_activesupport]
      end

      def exts
        hash = available_exts
        case
          when config.has_key?(:only) : hash.only *config[:only]
          when config.has_key?(:except) : hash.except *config[:except]
        else
          raise ":only or :except option is required"
        end
      end

      def load
        exts.each do |key, path|
          if official? key
            require( Merb::ActiveSupport::AS_CORE_EXT_DIR / path )
          else
            require( Merb::ActiveSupport::PARTIAL_EXT_DIR / path )
          end
        end
      end

    end
  end

  Merb::ActiveSupport.load

end
