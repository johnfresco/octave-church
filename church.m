zero = @(f) @(x) x;
succ = @(n) @(f) @(x) f(n(f)(x));
add = @(m, n) @(f) @(x) m(f)(n(f)(x));
mul = @(m, n) @(f) @(x) m(n(f))(x);
pow = @(b, e) e(b);
 
% Need a short-circuiting ternary
iif = @(varargin) varargin{3 - varargin{1}}();
 
% Helper for anonymous recursion
% The branches are thunked to prevent infinite recursion
to_church_ = @(f, i) iif(i == 0, @() zero, @() succ(f(f, i - 1)));
to_church = @(i) to_church_(to_church_, i);
 
to_int = @(c) c(@(n) n + 1)(0);
 
three = succ(succ(succ(zero)));
four = succ(succ(succ(succ(zero))));
 
cellfun(to_int, {
    add(three, four),
    mul(three, four),
    pow(three, four),
    pow(four, three)})
