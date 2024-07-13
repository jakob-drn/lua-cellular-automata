
plain={p0={},p1={},state={alive="o",dead=" "},gen=0}
plain.p0={}
plain.p1={}
do 
	local row=50
	local col=100

	for i=1,row do 
		plain.p0[i]={}
		plain.p1[i]={}
		for j=1,col do 
			plain.p0[i][j]=plain.state.dead 
			plain.p1[i][j]=plain.state.dead 
		end
	end
end

plain.p0[25][55]=plain.state.alive
plain.p0[25][56]=plain.state.alive
plain.p0[25][57]=plain.state.alive
plain.p0[24][57]=plain.state.alive
plain.p0[23][56]=plain.state.alive

plain.rule=function (self)
	local p0=self.p0
	local p1=self.p1
	for i,c in ipairs(p0) do
		for j,e in ipairs(c) do
			local n=0
			for p=-1,1 do
				for q=-1,1 do
					if p==0 and q==0 then ;
					elseif p0[i+p]==nil then ;
					elseif p0[i+p][j+q]==nil then ;
					elseif p0[i+p][j+q]==self.state.alive then n=n+1 
					end
				end
			end
			-- + + + + + + + + + + + + + + + + + + + + + + + + + +  
			if e==self.state.alive then
				if n<2 or n>3 then
					p1[i][j]=self.state.dead 
				else 
					p1[i][j]=self.state.alive
				end

			elseif n==3 then p1[i][j]=self.state.alive
			end
			-- - - - - - - - - - - - - - - - - - - - - - - - - - - 
		end
	end
	
end

plain.update=function (self)
	for i,c in ipairs(self.p1) do 
		for j,k in ipairs(c) do 
			self.p0[i][j]=k
			self.p1[i][j]=self.state.dead
		end
	end
	self.gen=self.gen+1
end

plain.print=function (self)
	io.write(": ",self.gen,"\t"); 
	for i in ipairs(self.p0[1]) do io.write(". ") end
	io.write("\n");	
	for i,c in ipairs(self.p0) do 
		io.write(i,"\t")
		for j,c in ipairs(c) do 
			if c~=self.state.dead then io.write(c) 
			else io.write(self.state.dead)
			end
			io.write(" ")
		end 
		io.write("\n");	
	end	
	io.write("\n");	
end

plain.evolve=function (self)
	self.rule(self)
	self.update(self)
end

---------------------------------------------------------------------------

os.execute("clear")
while true do 
	plain.print(plain); 
	plain.evolve(plain);
	while (os.clock()*1000) % 500 ~=0 do end
	os.execute("clear")
end

