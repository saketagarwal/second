package credits.sut;

public class credits {
	public double payment;
	
	public static void main(String[] args){}
	
	
	public void setPayment(double payment) {
		this.payment = payment;
	}

	public double calculateCredits() { return payment * 4; } 
}
