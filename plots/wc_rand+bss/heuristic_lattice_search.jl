using Primes
using Random
using Printf
using Dates
using SparseArrays

include("rand_T_out_of_M.jl")

"""
    heuristic_lattice_search(I)

Determines a reco rank-1 lattice for I.

"""
function heuristic_lattice_search(I)

	Mtmp=Int64(max(size(I,1)^2, findmax(I)[1]-findmin(I)[1]+1));
#	Mtmp=2^(ceil(log(Mtmp)/log(2)));
	Mtmp1=nextprime(Int64(Mtmp));
#	Mtmp=2^(ceil(log(Mtmp)/log(2)));
#    Mtmp1=Mtmp;


	if(!hasmethod(rand_T_out_of_M, Tuple{Int64,Int64}))
		include("rand_T_out_of_M.jl");
	end
	T=max(size(I,1)^(1/4), 100);
	
	numtests=0;	

	M=-1;
	z=zeros(size(I,2));
	
#	@printf("starting sortslices: %s\n", Dates.now());
	if(issparse(I))
		# brute force strategy
		I=sparse(sortslices(Array(I),dims=1));
	else
		I=sortslices(I,dims=1);
	end
#	@printf("finishing sortslices: %s\n", Dates.now());

	while numtests<5
#		@printf("Testing M=%d, ", Mtmp1);
#		@time ztmp, itno=search_lattice_onlyT(I,Mtmp1,T);
		ztmp, itno=search_lattice_onlyT(I,Mtmp1,T);
		if(findmin(itno)[1]>-1)
			M=Mtmp1;
			z=ztmp;
#			Mtmp=Mtmp/2;
#			Mtmp1=prevprime(Int64(Mtmp));
			if(Mtmp1==2)
				break;
			end
			Mtmp1=nextprime(Int64((Mtmp1+1)/2));
#			Mtmp1=Mtmp;
			numtests=-1;
#			@printf("Found reco lattice for M=%d. Decreasing M, new M=%.d\n", M, Mtmp1);
		end
		numtests=numtests+1;
	end
	return z, M;	
end

    function search_lattice_onlyT(I,M,T)
		Ilen=size(I,1);
		maxd=size(I,2);
		z=zeros(Int64, maxd);
		z[1]=1;
#		I=sortslices(I, dims=1); # new line
		tmp1=z[1]*I[1:Ilen,1];
		search_itno=ones(Int64,size(I,2))*-1;
		search_itno[1]=0;
		for d = 2:maxd
			#I2tmp=abs.(tmp1[2:end]-tmp1[1:end-1])+abs.(I[2:end,d]-I[1:end-1,d]);
			I2tmp=zeros(size(I,1)-1);
			for j=1:size(I,1)-1
				I2tmp[j]=abs(tmp1[j+1]-tmp1[j])+abs(I[j+1,d]-I[j,d]);
			end
	
			ind=findall(I2tmp.!=0);
			inds=zeros(Int64, length(ind));
			zaehler1=1;
			zaehler2=length(ind);
			for j=1:length(ind)
				if( I[ind[j],d] == 0)
					inds[zaehler2]=ind[j]; zaehler2=zaehler2-1;
				else
					inds[zaehler1]=ind[j]; zaehler1=zaehler1+1;
				end
			end
			# now zaehler2 is the number of nonzeros and length(ind)-zaehler2 the number of zeros in I[ind,d]
			I21a=zeros(Int64, zaehler2)			
			I22a=zeros(Int64, zaehler2)
			checkvar=zeros(Int64, length(ind));	
			for j=1:zaehler2
				I21a[j]=tmp1[inds[j]];
				I22a[j]=I[inds[j],d];
			end
			for j=zaehler2+1:length(ind)
				checkvar[j]=tmp1[inds[j]];		
			end

			reco=false;
			if(T<M)
				zcomp_cands=rand_T_out_of_M(M,T)
			else
				zcomp_cands=shuffle(1:M)
				T=M
			end

			for r=1:Int64(T)
				checkvar[1:zaehler2]=mod.(I21a+I22a*zcomp_cands[r],M);
				if (allunique(checkvar))
					z[d]=zcomp_cands[r];
					tmp1=mod.(tmp1+I[:,d]*z[d],M);
					search_itno[d]=r;
					@goto goto_next_dimension
				elseif r==T
#					@printf("No lattice could be found. Potential z candidates %d, tested: %d. Stopped at dimension %d.\n", M, T, d);
#					@show(Dates.now());
#					@warn("No lattice could be found.");
					@goto breaking_point_onlyT
				end
			end

			@label goto_next_dimension
#			@printf("d=%d, iterations=%d\n", d, search_itno[d]);
#			@show(Dates.now());
		end
		@label breaking_point_onlyT
		return z, search_itno
	end

#	function rand_T_out_of_M(M,T)
#
#		S=Set{Int64}();
#		for j=M-T+1:M
#			t=rand(1:j);
#			if(!in(t,S))
#				push!(S,t);
#			else
#				push!(S,j);
#			end
#		end
#       	return shuffle(collect(S));
#	end
