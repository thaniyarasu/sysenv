require "active_support"

class Sysenv

  # Override Project Specific Environment variables with system specific
  #
  # Example:
  #   >> sysenv = Sysenv.new
  #   >> sysenv.parse({api:{secret:{key: 'value',cert:'certificate'}}})
  #   => {api:{secret:{key: 'value',cert:'certificate'}}}
  #
  # Arguments:
  #   apply: (Hash)

  def apply(hash, prefix=[])
    envs = {} # hash of { underscorized env keys : normal env keys }
    ENV.keys.collect { |e| envs[ActiveSupport::Inflector.underscore(e)] = e }
    override_nested_hash(hash, envs, prefix)
  end

  def override_nested_hash(hash, envs={}, prefix=[])
    hash.each do |key, value|
      if value.class == Hash
        hash[key] = override_nested_hash(value, envs, prefix.clone << key)
      end
      exp_key = (prefix.clone << key).join('_')
      index = envs.keys.index(exp_key) || envs.keys.index(exp_key.to_sym)
      hash[key] = ENV[envs.values[index]] if index
    end
    hash
  end	

end
