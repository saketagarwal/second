package CalcFix;
import Calc.*;

public class CalcSumFix {
	
	public double first,second,sum;

	public void setFirst(double first) {
		this.first = first;
	}

	public void setSecond(double second) {
		this.second = second;
	}
	
	public void execute()
	{
		this.sum= new Calc_sum().sum(first,second);
		
	}
	
	public double sum(){
		return this.sum;
	}
	
	

}
