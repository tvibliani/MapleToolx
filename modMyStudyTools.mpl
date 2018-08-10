#################################################################################
#
# Filename: modMyStudyTools.mpl
# 
# Copyright (c) 2018 Temur 
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
#################################################################################


MyStudyTools := module()
description "My Study Tools";
option package;
export no_eval;

no_eval := proc(expr::uneval)
description "Display expression (quotient for example) vithout evaluation...";
uses Typesetting;
(subsindets(expr,
            And(name,
                satisfies(t->type(eval(t),
                        {constant,
                        '`*`'({constant,
                                'specfunc'(anything, Units:-Unit)
                                })
                        }
                        ))
               ),
            z->Typeset(EV(z))
           ));
end proc;  # no_eval


end module; # My Study Tools


#################################################################################
#
# End of File: modMyStudyTools.mpl
#
#################################################################################

