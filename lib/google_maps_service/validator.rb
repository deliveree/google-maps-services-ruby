require_relative './convert'

module GoogleMapsService

  # Validate value that is accepted by Google Maps.
  module Validator
    module_function

    # Validate travel mode. The valid value of travel mode are `driving`, `walking`, `bicycling` or `transit`.
    #
    # @param [String, Symbol] mode Travel mode to be validated.
    #
    # @raise ArgumentError The travel mode is invalid.
    #
    # @return [String] Valid travel mode.
    def travel_mode(mode)
      # NOTE(broady): the mode parameter is not validated by the Maps API
      # server. Check here to prevent silent failures.
      unless [:driving, :walking, :bicycling, :transit].include?(mode.to_sym)
        raise ArgumentError, 'Invalid travel mode.'
      end
      mode
    end

    # Validate route restriction. The valid value of route restriction are `tolls`, `highways` or `ferries`.
    #
    # @param [String] avoid Route restriction to be validated.
    #
    # Format input avoid: '[key][character][key][character][key]' 
    #
    # Characters which between the keys can be , . ' or | 
    #
    # Ex: 'tolls|highways|ferries'
    #
    # @raise ArgumentError The route restriction is invalid.
    #
    # @return [String] Valid route restriction.
    def avoid(avoid)
      array_keys = avoid.split(/[,.'|]/).map{|key| key.strip.to_sym}
      unless ([:tolls, :highways, :ferries] & array_keys).size == array_keys.size
        raise ArgumentError, 'Invalid route restriction.'
      end
      array_keys.join('|')
    end

    # Validate traffic model. The valid values of traffic are `best_guess`, `pessimistic` or `optimistic`.
    #
    # @param [String, Symbol] traffic_model Traffic model to be validated
    #
    # @raise ArgumentError The traffic model is invalid.
    #
    # @return [String] Valid traffic model
    def traffic_model(traffic_model)
      unless [:best_guess, :pessimistic, :optimistic].include?(traffic_model.to_sym)
        raise ArgumentError, 'Invalid traffic model.'
      end
      traffic_model
    end
  end
end