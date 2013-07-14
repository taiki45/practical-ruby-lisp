require 'pry'

module RubyScheme
  class << self

    def primitive_func_env
      @primitive_func_env ||= {
        :+ => [:prim, lambda {|x, y| x + y }],
        :- => [:prim, lambda {|x, y| x + y }]
      }
    end

    def global_env
      @global_env ||= [primitive_func_env]
    end

    def _eval(exp, env)
      if not list? exp
        if immediate_val? exp
          exp
        else
          lookup_var(exp, env)
        end
      else
        if special_form? exp
          eval_specail_form(exp, env)
        else
          func = _eval(car(exp), env)
          args = eval_list(cdr(exp), env)
          apply(func, args)
        end
      end
    end

    def list?(exp)
      exp.is_a? Array
    end

    def special_form?(exp)
      lambda?(exp) or let?(exp)
    end

    def lambda?(exp)
      exp[0] == :lambda
    end

    def let?(exp)
      exp[0] == :let
    end

    def lookup_primitive_func(exp)
      @primitive_func_env[exp]
    end

    def car(list)
      list[0]
    end

    def cdr(list)
      list[1..-1]
    end

    def eval_specail_form(exp, env)
      if lambda?(exp)
        eval_lambda(exp, env)
      elsif let?(exp)
        eval_let(exp, env)
      end
    end

    def eval_list(exps, env)
      exps.map {|e| _eval(e, env) }
    end

    def immediate_val?(exp)
      num?(exp)
    end

    def num?(exp)
      exp.is_a? Numeric
    end

    def apply(func, args)
      if primitive_func?(func)
        apply_primitive_func(func, args)
      else
        lambda_apply(func, args)
      end
    end

    def primitive_func?(exp)
      exp[0] == :prim
    end

    def apply_primitive_func(func, args)
      func = func[1]
      func.call(*args)
    end

    def lookup_var(var, env)
      alist = env.find {|alist| alist.key?(var) }
      raise "couldn't find value: '#{var}'" unless alist

      alist[var]
    end

    def extend_env(params, args, env)
      alist = Hash[params.zip(args)]
      [alist] + env
    end

    def eval_lambda(exp, env)
      make_closure(exp, env)
    end

    def make_closure(exp, env)
      params, body = exp[1], exp[2]
      [:closure, params, body, env]
    end

    def lambda_apply(closure, args)
      params, body, env = separate_closure(closure)
      new_env = extend_env(params, args, env)
      _eval(body, new_env)
    end

    def separate_closure(closure)
      [closure[1], closure[2], closure[3]]
    end

  end
end

binding.pry
