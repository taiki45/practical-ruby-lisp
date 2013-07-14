require 'pry'


def _eval(exp)
  if not list? exp
    if immediate_val? exp
      exp
    else
      lookup_primitive_func(exp)
    end
  else
    func = _eval(car(exp))
    args = eval_list(cdr(exp))
    apply(func, args)
  end
end

def list?(exp)
  exp.is_a? Array
end

def lookup_primitive_func(exp)
  $primitive_func_env[exp]
end

$primitive_func_env = {
  :+ => [:prim, lambda {|x, y| x + y }],
  :- => [:prim, lambda {|x, y| x + y }]
}

def car(list)
  list[0]
end

def cdr(list)
  list[1..-1]
end

def eval_list(exps)
  exps.map {|e| _eval(e) }
end

def immediate_val?(exp)
  num?(exp)
end

def num?(exp)
  exp.is_a? Numeric
end

def apply(func, args)
  apply_primitive_func(func, args)
end

def apply_primitive_func(func, args)
  func = func[1]
  func.call(*args)
end


binding.pry
