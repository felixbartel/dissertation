	function rand_T_out_of_M(M,T)

		S=Set{Int64}();
		for j=M-T+1:M
			t=rand(1:j);
			if(!in(t,S))
				push!(S,t);
			else
				push!(S,j);
			end
		end
       	return shuffle(collect(S));
	end
