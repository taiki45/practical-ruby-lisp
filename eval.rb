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
