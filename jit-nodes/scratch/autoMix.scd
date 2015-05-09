//Automixing env

~totalOut = 20

(
r = Routine { arg ~dividerOut = 4; //number of signals to divide
	~distributeOut = ~totalOut/~dividerOut;
	~biggestOut = ~distributeOut + ( 2 * (~distributeOut / ~dividerOut));
	16.wait;
	~distributeOut = (Line.kr((~totalOut/~dividerOut),3.5,16,1.5));
	~32.wait;
};
)